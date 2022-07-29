import 'package:foody/data/repository/recommended_product_repo.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  List<ProductItem> _recommendedProductList = [];
  List<ProductItem> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RecommendedProductController({required this.recommendedProductRepo});

  Future<void> getRecommendedProductList() async {
    _isLoaded = false;
    Response response =
        await recommendedProductRepo.getRecommendedProductList();
    if (response.statusCode == 200) {
      print("Got recomended product list");
      _recommendedProductList = [];
      _recommendedProductList
          .addAll(Products.fromJSON(response.body).productList);
      _isLoaded = true;
      update();
    } else {
      print("Got no response");
      print(response.request!.url);
    }
  }
}
