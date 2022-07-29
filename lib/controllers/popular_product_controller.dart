import 'package:foody/data/repository/popular_product_repo.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  List<ProductItem> _popularProductList = [];
  List<ProductItem> get popularProductList => _popularProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  PopularProductController({required this.popularProductRepo});

  Future<void> getPopularProductList() async {
    _isLoaded = false;
    Response response = await popularProductRepo.getPopularProductList();
    if (response.statusCode == 200) {
      print("Got product list");
      _popularProductList = [];
      _popularProductList.addAll(Products.fromJSON(response.body).productList);
      _isLoaded = true;
      update();
    } else {
      print("Got no response");
      print(response.request!.url);
    }
  }
}
