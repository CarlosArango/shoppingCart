import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/modules/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/products/products_bloc.dart';

import 'package:shopping_cart/src/utils/widgets/product_item.dart';
import 'package:collection/collection.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) {
        if (state.cartStatus == CartStatus.bought) {
          BlocProvider.of<ProductsCartsBloc>(context).add(ProductCartsLoad());
          Navigator.pop(context);

          final snackBar = SnackBar(
            content: Text('Your order was created, the cart now is empty'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, productsState) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: ListView.builder(
              itemCount: productsState.products.length,
              itemBuilder: (context, index) {
                return BlocBuilder<ProductsCartsBloc, ProductCartsState>(
                  builder: (context, state) {
                    final productCarts = state.productCarts;
                    final product = productsState.products[index].data();
                    int quantity = productCarts.isNotEmpty
                        ? getQuantityByProduct(productCarts, product)
                        : 0;
                    return ProductItem(
                      product: product,
                      quantity: state.productCarts.isEmpty &&
                              state.productSelected?.id == product.id &&
                              state.productCartsStatus == ProductCartsStatus.add
                          ? 1
                          : quantity,
                      onPressAddQuantity: () {
                        BlocProvider.of<ProductsCartsBloc>(context).add(
                          ProductCartsAdd(
                            product: product,
                            isFirstTime: productCarts.isEmpty,
                          ),
                        );
                      },
                      onPressSubstractQuantity: () {
                        if (quantity <= 0) return;

                        BlocProvider.of<ProductsCartsBloc>(context).add(
                          ProductCartsSubstract(
                            product: product,
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          );
        },
      ),
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
