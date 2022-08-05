import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/models/product_list_model.dart';

class PopularProductService {
  Stream<List<ProductItem>> getPopularProductStream() {
    var popularProductsStream = FirebaseFirestore.instance
        .collection('products')
        .where('type', isEqualTo: 'popular')
        .snapshots()
        .map((e) => e.docs.map((e) => ProductItem.fromJSON(e.data())).toList());
    // print(popularProductsList);
    return popularProductsStream;
  }
}
