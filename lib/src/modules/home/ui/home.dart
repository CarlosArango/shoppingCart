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
                bottom: 10,
                right: 10,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: Container(
                    alignment: Alignment.center,
                    width: 20,
                    height: 20,
                    decoration: new BoxDecoration(
                      color: Colors.green,
                      borderRadius: new BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      "1",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: HomeBody(),
    );
  }
}
