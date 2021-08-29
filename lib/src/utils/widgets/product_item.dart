import 'package:flutter/material.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/utils/string.dart';
import 'package:shopping_cart/src/utils/widgets/button_widget.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final int quantity;

  final VoidCallback onPressAddQuantity;
  final VoidCallback onPressSubstractQuantity;

  const ProductItem({
    Key? key,
    required this.product,
    this.quantity = 0,
    required this.onPressAddQuantity,
    required this.onPressSubstractQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      product.name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                  Container(
                    child: Text(
                      "\$${format(product.price)}",
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  child: ButtonWidget(
                    onPressed: onPressSubstractQuantity,
                    title: "-",
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: 30,
                  child: Text(quantity.toString()),
                ),
                Container(
                  width: 25,
                  height: 25,
                  child: ButtonWidget(
                    onPressed: onPressAddQuantity,
                    title: "+",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
