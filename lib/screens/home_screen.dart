import 'package:e_com/models/product.dart';
import 'package:e_com/services/favourite_products_stream.dart';
import 'package:e_com/widgets/categories/product_type_box.dart';
import 'package:e_com/widgets/home/header_section.dart';
import 'package:e_com/widgets/product/product_section.dart';
import 'package:flutter/material.dart';

import 'category_products_screen.dart';

//Color(0xFF757575)
const String ICON_KEY = 'icon';
const String TITLE_KEY = 'title';
const String PRODUCT_TYPE_KEY = 'product_type';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final productCategories = <Map>[
    <String, dynamic>{
      ICON_KEY: 'assets/icons/Electronics.svg',
      TITLE_KEY: 'Electronics',
      PRODUCT_TYPE_KEY: ProductType.Electronics,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Books.svg",
      TITLE_KEY: "Books",
      PRODUCT_TYPE_KEY: ProductType.Books,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Fashion.svg",
      TITLE_KEY: "Fashion",
      PRODUCT_TYPE_KEY: ProductType.Fashion,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Groceries.svg",
      TITLE_KEY: "Groceries",
      PRODUCT_TYPE_KEY: ProductType.Groceries,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Art.svg",
      TITLE_KEY: "Art",
      PRODUCT_TYPE_KEY: ProductType.Art,
    },
    <String, dynamic>{
      ICON_KEY: "assets/icons/Others.svg",
      TITLE_KEY: "Others",
      PRODUCT_TYPE_KEY: ProductType.Others,
    },
  ];

  final FavouriteProductsStream favouriteProductsStream =
      FavouriteProductsStream();

  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
  }

  @override
  void dispose() {
    favouriteProductsStream.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        SizedBox(height: 40),
        // header section
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: HeaderSection(
            onSearchSubmit: (value) {
              // will update later
            },
          ),
        ),
        // categories section
        SizedBox(height: 15),
        SizedBox(
          height: 120,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              ...List.generate(
                productCategories.length,
                (index) => ProductTypeBox(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CategoryProductsScreen(
                                  productType: productCategories[index]
                                      [PRODUCT_TYPE_KEY],
                                )));
                  },
                  title: productCategories[index][TITLE_KEY],
                  icon: productCategories[index][ICON_KEY],
                ),
              ),
            ],
          ),
        ),
        // product section
        SizedBox(height: 20),
        ProductSection(
          productStreamController: favouriteProductsStream,
          sectionTitle: "Products You Like",
        ),
      ],
    ));
  }
}
