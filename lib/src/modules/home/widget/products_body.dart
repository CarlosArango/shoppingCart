import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/products/products_bloc.dart';

import 'package:shopping_cart/src/utils/widgets/product_item.dart';
import 'package:collection/collection.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, productsState) {
        return BlocBuilder<ProductsCartsBloc, ProductCartsState>(
          builder: (context, productCartsState) {
            return StreamBuilder<QuerySnapshot<ProductCart>>(
              stream: productCartsState.productCarts,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<ProductCart>> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: ListView.builder(
                    itemCount: productsState.products.length,
                    itemBuilder: (context, index) {
                      final productCarts = snapshot.data?.docs.toList();
                      final product = productsState.products[index].data();
                      int quantity = productCarts != null
                          ? getQuantityByProduct(productCarts, product)
                          : 0;

                      return ProductItem(
                        isLoadedQuantity:
                            productCartsState.productCartsStatus ==
                                ProductCartsStatus.loaded,
                        product: product,
                        quantity: quantity,
                        onPressAddQuantity: () {
                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsAdd(
                              product: product,
                            ),
                          );

                          manageStreamEmptyProductCarts(
                            context,
                            productCarts,
                          );
                        },
                        onPressSubstractQuantity: () async {
                          if (quantity == 0) return;

                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsSubstract(
                              product: product,
                            ),
                          );
                          manageStreamEmptyProductCarts(
                            context,
                            productCarts,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  int getQuantityByProduct(
    List<QueryDocumentSnapshot<ProductCart>> productCarts,
    Product product,
  ) {
    int quantities = 0;
    if (productCarts.isNotEmpty) {
      final productCart = productCarts.firstWhereOrNull(
        (element) => element.data().product.id == product.id,
      );
      if (productCart != null) {
        quantities = productCart.data().quantity;
      }
    }
    return quantities;
  }

  void manageStreamEmptyProductCarts(
    BuildContext context,
    productCarts,
  ) {
    if (productCarts == null) {
      Timer(
        Duration(milliseconds: 1000),
        () {
          BlocProvider.of<ProductsCartsBloc>(context).add(
            ProductCartsLoad(),
          );
        },
      );
    }
  }
}
