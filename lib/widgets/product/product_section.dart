import 'package:e_com/services/data_stream.dart';
import 'package:e_com/widgets/nothing_to_show.dart';
import 'package:e_com/widgets/product/product_card.dart';
import 'package:flutter/material.dart';

import 'product_section_title.dart';

class ProductSection extends StatelessWidget {
  const ProductSection(
      {Key key,
      @required this.sectionTitle,
      @required this.productStreamController,
      this.emptyListMessage = "No Products to show here"})
      : super(key: key);

  final String emptyListMessage;
  final DataStream productStreamController;
  final String sectionTitle;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF5F6F9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          // title
          ProductSectionTitle(
            title: sectionTitle,
            press: () {},
          ),
          SizedBox(height: 15),
          Expanded(
            child: buildProductsList(),
          ),
        ],
      ),
    );
  }

  Widget buildProductsList() {
    return StreamBuilder<List<String>>(
        stream: productStreamController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length == 0) {
              return Center(
                // nothing to show
                child: NothingToShow(
                  secondaryMessage: emptyListMessage,
                ),
              );
            }
            return buildProductGrid(snapshot.data);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            final error = snapshot.error;
            return NothingToShow(
              iconPath: "assets/icons/network_error.svg",
              primaryMessage: "Something went wrong",
              secondaryMessage: "Unable to connect to Database",
            );
          }
          return Container();
        });
  }

  Widget buildProductGrid(List<String> productsId) {
    return GridView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: productsId.length,
        itemBuilder: (context, index) {
          return ProductCard();
        });
  }
}
