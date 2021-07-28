import 'package:flutter/material.dart';

class ProductSectionTitle extends StatelessWidget {
  const ProductSectionTitle(
      {Key key, @required this.title, @required this.press})
      : super(key: key);
  final String title;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
