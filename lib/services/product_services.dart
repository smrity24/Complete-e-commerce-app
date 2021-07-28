import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/models/product.dart';
import 'package:e_com/services/auth.dart';

class ProductServices {
  static const String FAV_PRODUCT_KEY = "favourite_products";

  ProductServices._privateConstructor();

  static ProductServices _instance = ProductServices._privateConstructor();

  factory ProductServices() {
    return _instance;
  }

  FirebaseFirestore _firebaseFirestore;
  FirebaseFirestore get firestore {
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore;
  }

  // get product with id
  Future<Product> getProductWithId(String productsId) async {
    final docSnapshot =
        await firestore.collection('Products').doc(productsId).get();

    if (docSnapshot.exists) {
      return Product.fromMap(docSnapshot.data(), id: docSnapshot.id);
    }
    return null;
  }

  // user favourite products list
  Future<List> userFavouriteProductsList() async {
    String uid = Authentication().auth.currentUser.uid;
    final userDocSnapshot = await firestore.collection('users').doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData[FAV_PRODUCT_KEY];
    return favList;
  }

  }
