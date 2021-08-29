import 'package:flutter/material.dart';

class IconCartWidget extends StatelessWidget {
  final VoidCallback onPressIcon;
  final int quantity;
  const IconCartWidget({
    Key? key,
    required this.onPressIcon,
    required this.quantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      textDirection: TextDirection.rtl,
      fit: StackFit.loose,
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_basket),
          tooltip: 'Go cart',
          onPressed: onPressIcon,
        ),
        Positioned(
          bottom: 5,
          right: 14,
          child: InkWell(
            onTap: onPressIcon,
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
                child: Text(
                  quantity.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
