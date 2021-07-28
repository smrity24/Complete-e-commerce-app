import 'package:e_com/models/product.dart';
import 'package:flutter/material.dart';

enum ImageType { local, network }

class CustomImage {
  final ImageType imageType;
  final String path;

  CustomImage({this.imageType = ImageType.local, @required this.path});
}

class ProductDetail extends ChangeNotifier {
  List<CustomImage> _selectedImages = [];
  ProductType _productType;
  List<String> _searchTags = [];

  List<CustomImage> get selectedImages => _selectedImages;

  set initialSelectedImages(List<CustomImage> images) {
    _selectedImages = images;
  }

  set selectedImages(List<CustomImage> images) {
    _selectedImages = images;
    notifyListeners();
  }

  void setSelectedImages(CustomImage image, int index) {
    if (index < _selectedImages.length) {
      _selectedImages[index] = image;
      notifyListeners();
    }
  }

  void addNewSelectedImages(CustomImage images) {
    _selectedImages.add(images);
    notifyListeners();
  }

  ProductType get productType => _productType;

  set initialProductType(ProductType type) {
    _productType = type;
  }

  set productType(ProductType type) {
    _productType = type;
    notifyListeners();
  }

  List<String> get searchTags => _searchTags;

  set initialSearchTags(List<String> tags) {
    _searchTags = tags;
  }

  set searchTags(List<String> tags) {
    _searchTags = tags;
    notifyListeners();
  }

  void addSearchTags(String tags) {
    _searchTags.add(tags);
    notifyListeners();
  }

  void removeSearchTags({int index}) {
    if (index == null)
      _searchTags.removeLast();
    else
      _searchTags.removeAt(index);
    notifyListeners();
  }
}
