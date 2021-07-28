import 'package:e_com/services/data_stream.dart';
import 'package:e_com/services/product_services.dart';

class FavouriteProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    // show all favourite products
    final favouriteProductsFuture =
        ProductServices().userFavouriteProductsList();
    favouriteProductsFuture.then((favProducts) {
      addData(favProducts.cast<String>());
    }).catchError((e) {
      addError(e);
    });
  }
}
