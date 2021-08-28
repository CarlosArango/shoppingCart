import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
        title,
      ),
      onPressed: onPressed,
    );
  }
}
