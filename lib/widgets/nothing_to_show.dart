import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NothingToShow extends StatelessWidget {
  const NothingToShow(
      {Key key,
      this.iconPath = "assets/icons/empty_box.svg",
      this.primaryMessage = "Nothing to show",
      this.secondaryMessage = ''})
      : super(key: key);

  final String iconPath;
  final String primaryMessage;
  final String secondaryMessage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: Column(
        children: [
          SvgPicture.asset(
            iconPath,
            color: Color(0xFF757575),
            width: 75,
          ),
          SizedBox(height: 16),
          Text(
            "$primaryMessage",
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 15,
            ),
          ),
          Text(
            "$secondaryMessage",
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
