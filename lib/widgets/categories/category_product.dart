import 'package:e_com/models/product.dart';
import 'package:e_com/utils/color_helper.dart';
import 'package:e_com/widgets/home/custom_search_text_field.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  CategoryProduct({Key key, @required this.productType}) : super(key: key);
  final ProductType productType;
  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // header section
          SizedBox(height: 40),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.west_outlined,
                  color: Color(0xFF800f2f),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              Expanded(child: CustomSearchTextField(onSubmitted: (value) {})),
            ],
          ),
          SizedBox(height: 20),
          // banner section
          SizedBox(
            height: 120,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bannerFromProductType()),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                        kPrimaryColor,
                        BlendMode.hue,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      EnumToString.convertToString(widget.productType),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String bannerFromProductType() {
    switch (widget.productType) {
      case ProductType.Electronics:
        return "assets/images/electronics_banner.jpg";
      case ProductType.Books:
        return "assets/images/books_banner.jpg";
      case ProductType.Fashion:
        return "assets/images/fashions_banner.jpg";
      case ProductType.Groceries:
        return "assets/images/groceries_banner.jpg";
      case ProductType.Art:
        return "assets/images/arts_banner.jpg";
      case ProductType.Others:
        return "assets/images/others_banner.jpg";
      default:
        return "assets/images/others_banner.jpg";
    }
  }
}
