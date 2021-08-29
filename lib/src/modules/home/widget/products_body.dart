import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/products/products_bloc.dart';

import 'package:shopping_cart/src/utils/widgets/product_item.dart';
import 'package:shopping_cart/src/resources/repositories/carts_repo.dart';
import 'package:shopping_cart/src/resources/repositories/product_carts_repo.dart';
import 'package:collection/collection.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsBloc, ProductsState>(
      listener: (context, state) {},
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

                      return ProductItem(
                        isLoadedQuantity:
                            productCartsState.productCartsStatus ==
                                ProductCartsStatus.loaded,
                        product: product,
                        quantity: getQuantityByProduct(productCarts!, product),
                        onPressAddQuantity: () {
                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsAdd(
                              product: product,
                            ),
                          );
                        },
                        onPressSubstractQuantity: () {
                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsSubstract(
                              product: product,
                            ),
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
}
