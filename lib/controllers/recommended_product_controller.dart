import 'package:foody/data/repository/recommended_product_repo.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:foody/services/recommended_product.dart';
import 'package:get/get.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductService recommendedProductService;
  Rx<List<ProductItem>> _recommendedProductList = Rx<List<ProductItem>>([]);
  List<ProductItem> get recommendedProductList => _recommendedProductList.value;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  RecommendedProductController({required this.recommendedProductService});

  Future<void> getRecommendedProductList() async {
    _isLoaded = false;
    // Response response =
    //     await recommendedProductRepo.getRecommendedProductList();
    var recommendedProductsStream =
        recommendedProductService.getRecommendedProductStream();
    print("Got recomended product list");
    _recommendedProductList = Rx<List<ProductItem>>([]);
    _recommendedProductList.bindStream(recommendedProductsStream);
    ever(_recommendedProductList, (_) {
      update();
    });
    _isLoaded = true;
  }
}
