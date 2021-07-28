import 'package:e_com/widgets/home/custom_search_text_field.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key key, @required this.onSearchSubmit})
      : super(key: key);

  final Function onSearchSubmit;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // search text field
        Expanded(
            child: CustomSearchTextField(
          onSubmitted: onSearchSubmit,
        )),
        SizedBox(width: 5),
        // notification icon
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Color(0xFF800f2f), width: 3),
          ),
          child: IconButton(
              icon: Icon(
                Icons.notifications_none_outlined,
                size: 33,
                color: Color(0xFF800f2f),
              ),
              onPressed: () {}),
        ),
      ],
    );
  }
}
