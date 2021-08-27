import 'package:flutter/material.dart';
import 'package:shopping_cart/src/model/products.dart';

class ProductItem extends StatelessWidget {
  final Product? product;
  const ProductItem({
    Key? key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
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
                        product!.name,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Container(
                      child: Text(
                        product!.price.toString(),
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(0),
                    ),
                    elevation: MaterialStateProperty.all(10),
                  ),
                  onPressed: () {},
                  child: Text("+"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
