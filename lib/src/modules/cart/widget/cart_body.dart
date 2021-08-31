import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/cart/cart_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';

import 'package:shopping_cart/src/utils/string.dart';
import 'package:shopping_cart/src/utils/widgets/button_widget.dart';
import 'package:shopping_cart/src/utils/widgets/product_item.dart';
import 'package:shopping_cart/src/utils/cart.dart' as UtilCart;

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCartsBloc, ProductCartsState>(
      builder: (context, state) {
        final productCarts = state.productCarts
            .where((element) => element.data().quantity > 0)
            .toList();

        if (productCarts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Cart empty",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Container(
                  width: 150,
                  child: ButtonWidget(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      title: "Go Home"),
                )
              ],
            ),
          );
        }
        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: productCarts.length,
                    itemBuilder: (context, index) {
                      final productCart = productCarts[index].data();
                      return ProductItem(
                        product: productCart.product,
                        quantity: productCart.quantity,
                        onPressAddQuantity: () {
                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsAdd(
                              product: productCart.product,
                            ),
                          );
                        },
                        onPressSubstractQuantity: () {
                          BlocProvider.of<ProductsCartsBloc>(context).add(
                            ProductCartsSubstract(
                              product: productCart.product,
                            ),
                          );
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Cantidad de productos",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          UtilCart.getQuantities(productCarts).toString(),
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            "Total:",
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        Text(
                          "\$${format(UtilCart.getTotal(productCarts))}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 40,
                    color: Colors.white,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      child: Text("Comprar"),
                      onPressed: () {
                        BlocProvider.of<CartBloc>(context).add(
                          CartButtonBuyPressed(
                            cartId: productCarts[0].data().cartId,
                            productsCart: productCarts,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
