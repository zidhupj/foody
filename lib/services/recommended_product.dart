import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foody/models/product_list_model.dart';

class RecommendedProductService {
  Stream<List<ProductItem>> getRecommendedProductStream() {
    var recommendedProductStream = FirebaseFirestore.instance
        .collection('products')
        .where('type', isEqualTo: 'recommended')
        .snapshots()
        .map((e) => e.docs.map((e) => ProductItem.fromJSON(e.data())).toList());

    return recommendedProductStream;
  }
}
