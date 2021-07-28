import 'package:e_com/models/product.dart';
import 'package:e_com/widgets/categories/category_product.dart';
import 'package:flutter/material.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({Key key, @required this.productType})
      : super(key: key);
  final ProductType productType;
  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CategoryProduct(
        productType: widget.productType,
      )
      // category product
      ,
    );
  }
}
