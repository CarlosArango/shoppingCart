import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';
import 'package:shopping_cart/src/modules/home/widget/products_body.dart';
import 'package:shopping_cart/src/utils/cart.dart' as UtilCart;
import 'package:shopping_cart/src/utils/widgets/icon_cart_widget.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tul cart',
        ),
        actions: <Widget>[
          BlocBuilder<ProductsCartsBloc, ProductCartsState>(
            builder: (context, state) {
              int quantity = state.productCarts.length > 0
                  ? UtilCart.getQuantities(state.productCarts)
                  : 0;

              return IconCartWidget(
                onPressIcon: () {
                  Navigator.pushNamed(context, '/cart');
                },
                quantity: state.productCarts.isEmpty &&
                        state.productCartsStatus == ProductCartsStatus.add
                    ? 1
                    : quantity,
              );
            },
          ),
        ],
      ),
      body: HomeBody(),
    );
  }
}
