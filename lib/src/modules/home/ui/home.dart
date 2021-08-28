import 'package:flutter/material.dart';
import 'package:shopping_cart/src/modules/home/widget/products_body.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TULCART',
        ),
      ),
      body: HomeBody(),
    );
  }
}
