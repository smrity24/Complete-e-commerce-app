import 'package:e_com/utils/color_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductTypeBox extends StatelessWidget {
  const ProductTypeBox(
      {Key key,
      @required this.icon,
      @required this.title,
      @required this.onPressed})
      : super(key: key);

  final String icon;
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: AspectRatio(
          aspectRatio: 1.05,
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 4,
            ),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(0.09),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.18),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: SvgPicture.asset(
                        icon,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  title,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w900,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )),
    );
  }
}
