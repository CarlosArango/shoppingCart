import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_cart/src/model/products.dart';
import 'package:shopping_cart/src/modules/blocs/product_carts/product_carts_bloc.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  final int quantity;
  final bool isLoadedQuantity;
  final BuildContext? contextP;
  const ProductItem({
    Key? key,
    required this.product,
    this.quantity = 0,
    this.isLoadedQuantity = false,
    this.contextP,
  }) : super(key: key);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.text = widget.quantity.toString();
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
                      widget.product.name,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                  Container(
                    child: Text(
                      widget.product.price.toString(),
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  child: renderButton("-", () {
                    if (widget.quantity != 0) {
                      BlocProvider.of<ProductsCartsBloc>(context).add(
                        ProductCartsSubstract(
                          product: widget.product,
                        ),
                      );
                    }
                  }),
                ),
                Container(
                  width: 50,
                  child: TextField(
                    controller: _controller,
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 30,
                  height: 30,
                  child: renderButton(
                    "+",
                    () {
                      BlocProvider.of<ProductsCartsBloc>(context).add(
                        ProductCartsAdd(
                          product: widget.product,
                        ),
                      );
                    },
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

Widget renderButton(String text, VoidCallback onPressed) {
  return OutlinedButton(
    style: OutlinedButton.styleFrom(
        elevation: 6,
        padding: EdgeInsets.all(0),
        backgroundColor: Colors.amber,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
    child: Text(
      text,
    ),
    onPressed: onPressed,
  );
}
