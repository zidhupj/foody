import 'package:foody/data/repository/popular_product_repo.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:get/get.dart';
import 'package:foody/services/popular_product.dart';

class PopularProductController extends GetxController {
  final PopularProductService popularProductService;
  Rx<List<ProductItem>> _popularProductList = Rx<List<ProductItem>>([]);
  List<ProductItem> get popularProductList => _popularProductList.value;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PopularProductController({required this.popularProductService});

  Future<void> getPopularProductList() async {
    _isLoaded = false;
    var productListStream = popularProductService.getPopularProductStream();
    print("Got product list");
    _popularProductList = Rx<List<ProductItem>>([]);
    _popularProductList.bindStream(productListStream);
    ever(_popularProductList, (_) {
      update();
    });
    _isLoaded = true;
  }
}
