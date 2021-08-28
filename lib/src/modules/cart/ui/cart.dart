import 'package:flutter/material.dart';
import 'package:shopping_cart/src/modules/cart/widget/cart_body.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: CartBody(),
    );
  }
}
