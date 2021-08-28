import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/utils/cart.dart';
import 'package:shopping_cart/src/utils/string.dart';
import 'package:shopping_cart/src/utils/widgets/product_item.dart';

class CartBody extends StatelessWidget {
  const CartBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCartsBloc, ProductCartsState>(
      builder: (context, state) {
        return StreamBuilder<QuerySnapshot<ProductCart>>(
          stream: state.productCarts,
          builder: (BuildContext context,
              AsyncSnapshot<QuerySnapshot<ProductCart>> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final productCarts = snapshot.data!.docs
                  .where((element) => element.data().quantity > 0)
                  .toList();

              final infoCart = getInfoCart(productCarts);

              return Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: productCarts.length,
                      itemBuilder: (context, index) {
                        final productCart = productCarts[index].data();
                        return ProductItem(
                          isLoadedQuantity: true,
                          product: productCart.product,
                          quantity: productCart.quantity,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text("Cantidad de productos:"),
                        ),
                        Container(
                          child: Text(infoCart['quantities'].toString()),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text("Total:"),
                        ),
                        Container(
                          child: Text("\$${format(infoCart['total'])}"),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }

            return Container(
              child: Text("Loading..."),
            );
          },
        );
      },
    );
  }
}
