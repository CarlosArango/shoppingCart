import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/product_cart.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/modules/home/widget/products_body.dart';
import 'package:shopping_cart/src/resources/repositories/carts_repo.dart';
import 'package:shopping_cart/src/resources/repositories/product_carts_repo.dart';
import 'package:shopping_cart/src/utils/cart.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCartsBloc>(
      create: (context) => ProductsCartsBloc(
        productCartsRepository: ProductCartsRepository(),
        cartsRepository: CartsRepository(),
      )..add(
          ProductCartsLoad(),
        ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'TULCART',
          ),
          actions: <Widget>[
            Stack(
              alignment: Alignment.center,
              textDirection: TextDirection.rtl,
              fit: StackFit.loose,
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.shopping_basket),
                  tooltip: 'Go cart',
                  onPressed: () {
                    Navigator.pushNamed(context, '/cart');
                  },
                ),
                Positioned(
                  bottom: 5,
                  right: 14,
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, '/cart'),
                    child: Container(
                      alignment: Alignment.center,
                      width: 18,
                      height: 18,
                      decoration: new BoxDecoration(
                        color: Colors.amber,
                        borderRadius: new BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: BlocBuilder<ProductsCartsBloc, ProductCartsState>(
                        builder: (context, state) {
                          return StreamBuilder<QuerySnapshot<ProductCart>>(
                            stream: state.productCarts,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot<ProductCart>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.active) {
                                final productCarts =
                                    snapshot.data!.docs.toList();
                                final infoCart = getInfoCart(productCarts);
                                return Text(
                                  infoCart['quantities'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                );
                              }

                              return Text("0");
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        body: HomeBody(),
      ),
    );
  }
}
