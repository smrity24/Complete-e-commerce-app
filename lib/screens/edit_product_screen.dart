import 'dart:io';

import 'package:e_com/exceptions/image_picking_exceptions.dart';
import 'package:e_com/exceptions/local_file_handling_exception.dart';
import 'package:e_com/models/product.dart';
import 'package:e_com/models/product_details.dart';
import 'package:e_com/services/choose_images_from_local_file.dart';
import 'package:e_com/services/product_services.dart';
import 'package:e_com/utils/color_helper.dart';
import 'package:e_com/widgets/default_button.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _basicDetailsFormKey = GlobalKey<FormState>();
  final _describeProductFormKey = GlobalKey<FormState>();
  final _uploadImagesFormKey = GlobalKey<FormState>();
  final _tagStateKey = GlobalKey<TagsState>();

  Product product = Product('');
  bool newProduct = true;

  final TextEditingController titleFieldController = TextEditingController();
  final TextEditingController originalPriceFieldController =
      TextEditingController();
  final TextEditingController discountPriceFieldController =
      TextEditingController();
  final TextEditingController sellerFieldController = TextEditingController();
  final TextEditingController highlightsFieldController =
      TextEditingController();
  final TextEditingController descriptionFieldController =
      TextEditingController();

  Future<void> addImages({int index}) async {
    final productDetail = Provider.of<ProductDetail>(context, listen: false);

    if (index == null && productDetail.selectedImages.length >= 3) {
      // toast
      Fluttertoast.showToast(
          msg: "Max 3 images can be uploaded",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }
    String path;
    String toast;
    // choose images from local file
    try {
      path = await chooseImagesFromLocalFile(context);
      if (path == null) {
        throw LocalImagePickingUnknownReasonFailureException();
      }
    } on LocalFileHandlingException catch (e) {
      toast = e.toString();
    } catch (e) {
      toast = e.toString();
    } finally {
      if (toast != null) {
        Fluttertoast.showToast(
            msg: toast,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey,
            textColor: Colors.white);
      }
    }
    if (path == null) {
      return;
    }

    if (index == null) {
      productDetail.addNewSelectedImages(
          CustomImage(path: path, imageType: ImageType.local));
    } else {
      productDetail.setSelectedImages(
          CustomImage(path: path, imageType: ImageType.local), index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF800f2f),
        centerTitle: true,
        title: Text('Add Product'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(height: 10),
                Text(
                  "Fill Product Details",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 30),
                // basic details form
                Form(
                  key: _basicDetailsFormKey,
                  child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "Basic Details",
                      style: TextStyle(color: Color(0XFF8B8B8B), fontSize: 18),
                    ),
                    leading: Icon(
                      Icons.shop,
                      color: Color(0xFF800f2f),
                    ),
                    childrenPadding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      // title field
                      TextFormField(
                        controller: titleFieldController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "e.g., Samsung Galaxy F41 Mobile",
                          labelText: "Product Title",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (titleFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20),
                      // original price
                      TextFormField(
                        controller: originalPriceFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "e.g., 5999.0",
                          labelText: "Original Price",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (originalPriceFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20),
                      // discount price
                      TextFormField(
                        controller: discountPriceFieldController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "e.g., 2499.0",
                          labelText: "Discount Price",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (discountPriceFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20),
                      // seller field
                      TextFormField(
                        controller: sellerFieldController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          hintText: "e.g., HighTech Traders",
                          labelText: "Seller",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (sellerFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // description form
                Form(
                  key: _describeProductFormKey,
                  child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "Describe Product",
                      style: TextStyle(
                        color: Color(0XFF8B8B8B),
                        fontSize: 18,
                      ),
                    ),
                    leading: Icon(
                      Icons.description,
                      color: Color(0xFF800f2f),
                    ),
                    childrenPadding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      // highlights field
                      TextFormField(
                        controller: highlightsFieldController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText:
                              "e.g., RAM: 4GB | Front Camera: 30MP | Rear Camera: Quad Camera Setup",
                          labelText: "Highlights",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (highlightsFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                      SizedBox(height: 20),
                      // description field
                      TextFormField(
                        controller: descriptionFieldController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText:
                              "e.g., This a flagship phone under made in India, by Samsung. With this device, Samsung introduces its new F Series.",
                          labelText: "Description",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: (_) {
                          if (descriptionFieldController.text.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        maxLines: null,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                      ),
                    ],
                  ),
                ),
                // upload images form
                SizedBox(height: 10),
                Form(
                  key: _uploadImagesFormKey,
                  child: ExpansionTile(
                    maintainState: true,
                    title: Text(
                      "Upload Images",
                      style: TextStyle(
                        color: Color(0XFF8B8B8B),
                        fontSize: 18,
                      ),
                    ),
                    leading: Icon(
                      Icons.image,
                      color: Color(0xFF800f2f),
                    ),
                    childrenPadding: EdgeInsets.symmetric(vertical: 20),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.add_a_photo,
                            color: Color(0xFF800f2f),
                          ),
                          color: Color(0xFF757575),
                          onPressed: () {
                            // add images function
                            addImages();
                          },
                        ),
                      ),
                      Consumer<ProductDetail>(
                          builder: (context, productDetail, child) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(
                                productDetail.selectedImages.length,
                                (index) => SizedBox(
                                    height: 80,
                                    width: 80,
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          addImages(index: index);
                                        },
                                        child: productDetail
                                                    .selectedImages[index]
                                                    .imageType ==
                                                ImageType.local
                                            ? Image.memory(
                                                File(productDetail
                                                        .selectedImages[index]
                                                        .path)
                                                    .readAsBytesSync(),
                                              )
                                            : Image.network(productDetail
                                                .selectedImages[index].path),
                                      ),
                                    )))
                          ],
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // product type drop down
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xFF757575),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(28),
                    ),
                  ),
                  child: Consumer<ProductDetail>(
                      builder: (context, productDetail, child) {
                    return DropdownButton(
                      value: productDetail.productType,
                      items: ProductType.values
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(EnumToString.convertToString(e))))
                          .toList(),
                      elevation: 0,
                      underline: SizedBox(
                        width: 0,
                        height: 0,
                      ),
                      hint: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: kPrimaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kPrimaryColor),
                        ),
                        child: Text('Choose Product Type'),
                      ),
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        productDetail.productType = value;
                      },
                    );
                  }),
                )
                // product search tags
                ,
                SizedBox(height: 20),
                ExpansionTile(
                  maintainState: true,
                  title: Text(
                    "Search Tags",
                    style: TextStyle(
                      color: Color(0XFF8B8B8B),
                      fontSize: 18,
                    ),
                  ),
                  leading: Icon(
                    Icons.check_circle_sharp,
                    color: Color(0xFF800f2f),
                  ),
                  childrenPadding: EdgeInsets.symmetric(vertical: 20),
                  children: [
                    Text("Your product will be searched for this Tags"),
                    SizedBox(height: 15),
                    Consumer<ProductDetail>(
                        builder: (context, productDetail, child) {
                      return Tags(
                        key: _tagStateKey,
                        horizontalScroll: true,
                        heightHorizontalScroll: 80,
                        textField: TagsTextField(
                          lowerCase: true,
                          constraintSuggestion: true,
                          keyboardType: TextInputType.name,
                          width: 120,
                          onSubmitted: (String str) {
                            productDetail.addSearchTags(str.toLowerCase());
                          },
                          hintText: "Add Search Tags",
                        ),
                        itemCount: productDetail.searchTags.length,
                        itemBuilder: (index) {
                          return ItemTags(
                            index: index,
                            active: true,
                            activeColor: kPrimaryColor,
                            padding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            title: productDetail.searchTags[index],
                            alignment: MainAxisAlignment.spaceBetween,
                            removeButton: ItemTagsRemoveButton(
                                backgroundColor: Colors.white,
                                color: Color(0xFF757575),
                                onRemoved: () {
                                  productDetail.removeSearchTags(index: index);
                                  return true;
                                }),
                          );
                        },
                      );
                    })
                  ],
                ),
                // default button
                DefaultButton(
                  text: "Save Product",
                  press: () {
                    // save product method
                    saveProduct();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateBasicDetailsForm() {
    if (_basicDetailsFormKey.currentState.validate()) {
      _basicDetailsFormKey.currentState.save();
      product.title = titleFieldController.text;
      product.originalPrice = double.parse(originalPriceFieldController.text);
      product.discountPrice = double.parse(discountPriceFieldController.text);
      product.seller = sellerFieldController.text;
      return true;
    }
    return false;
  }

  bool validateDescribeProductForm() {
    if (_describeProductFormKey.currentState.validate()) {
      _describeProductFormKey.currentState.save();
      product.highlights = highlightsFieldController.text;
      product.description = descriptionFieldController.text;
      return true;
    }
    return false;
  }

  // save product method
  Future<void> saveProduct() async {
    if (validateBasicDetailsForm() == false) {
      Fluttertoast.showToast(
          msg: "Errors in Basic Details Form",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }

    if (validateDescribeProductForm() == false) {
      Fluttertoast.showToast(
          msg: "Errors in Describe Product Form",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }

    final productDetail = Provider.of<ProductDetail>(context, listen: false);
    if (productDetail.selectedImages.length < 1) {
      Fluttertoast.showToast(
          msg: "Upload atleast One Image of Product",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }

    if (productDetail.productType == null) {
      Fluttertoast.showToast(
          msg: "Please select Product Type",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }

    if (productDetail.searchTags.length < 3) {
      Fluttertoast.showToast(
          msg: "Add atleast 3 search tags",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white);
      return;
    }
    
  }
}
