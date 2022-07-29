import 'package:flutter/material.dart';
import 'package:foody/data/repository/card_repo.dart';
import 'package:foody/models/cart_model.dart';
import 'package:foody/models/product_list_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;

  final Map<int, CartModel> _cart = {};
  List<CartModel> _cartHistory = [];
  List<CartModel> get cartHistory => _cartHistory;
  set setCartFromLocalStorage(bool i) {
    for (var cartItem in cartRepo.getCartList) {
      _cart.putIfAbsent(cartItem.id!, () => cartItem);
    }
  }

  void initLocalCart() {
    cartRepo.initCart = cartItemList;
  }

  int _currentQuantity = 1;
  int get currentQuantity => _currentQuantity;
  set initCurrentQuantity(int i) => _currentQuantity = 1;
  set incrementCurrentQuantity(int i) {
    if (_currentQuantity < 20) {
      _currentQuantity += 1;
      update();
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Item Count",
        message: "You can't add more!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      ));
    }
  }

  set decrementCurrentQuantity(int i) {
    if (_currentQuantity > 1) {
      _currentQuantity -= 1;
      update();
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Item Count",
        message: "You can't reduce more!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      ));
    }
  }

  int _cartQuantity = 0;
  int get cartQuantity => _cartQuantity;
  set initCartQuantity(int productId) => _cartQuantity =
      _cart.containsKey(productId) ? _cart[productId]!.quantity! : 0;

  int get cartItemCount => _cart.length;

  CartController({required this.cartRepo});

  void addToCart(ProductItem product) {
    int cartQuantity =
        _cart.containsKey(product.id) ? _cart[product.id]!.quantity! : 0;
    if (_currentQuantity + cartQuantity < 1 ||
        _currentQuantity + cartQuantity > 20) {
      Get.showSnackbar(const GetSnackBar(
        title: "Cart Item Count",
        message: "You can't add more than 20 of the same product to the cart!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      ));
      return;
    }
    _cart.putIfAbsent(
        product.id!,
        () => CartModel(
              id: product.id,
              img: product.img,
              name: product.name,
              price: product.price,
              quantity: 0,
              isExist: true,
              time: DateTime.now().toString(),
            ));
    _cart[product.id!]!.quantity =
        _cart[product.id!]!.quantity! + _currentQuantity;
    _cartQuantity += _currentQuantity;

    cartRepo.addToCartList(cartItemList);

    update();
  }

  List<CartModel> get cartItemList => _cart.values.toList();

  set incrementCartQuantity(CartModel cartItem) {
    if (_cart[cartItem.id!]!.quantity! < 20) {
      _cart[cartItem.id!]!.quantity = _cart[cartItem.id!]!.quantity! + 1;
      cartRepo.addToCartList(cartItemList);
      update();
    } else {
      Get.showSnackbar(const GetSnackBar(
        title: "Cart Item Count",
        message: "You can't add more!",
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 5),
      ));
    }
  }

  set decrementCartQuantity(CartModel cartItem) {
    if (_cart[cartItem.id!]!.quantity! > 1) {
      _cart[cartItem.id!]!.quantity = _cart[cartItem.id!]!.quantity! - 1;
      cartRepo.addToCartList(cartItemList);
    } else {
      _cart.remove(cartItem.id!);
    }
    update();
  }

  double get totalAmount {
    double total = 0;
    _cart.forEach(
        (i, cartItem) => total += cartItem.price! * cartItem.quantity!);
    return total;
  }

  void addToCartHistory() {
    cartRepo.addToCartHistory();
    _cart.removeWhere((key, value) => true);
    update();
  }

  Map<String, int> cartItemsPerOrder = {};

  void getHistoryList() {
    _cartHistory = [];
    cartItemsPerOrder = {};
    for (var cartItem in cartRepo.getHistoryList) {
      _cartHistory.add(cartItem);
      if (cartItemsPerOrder.containsKey(cartItem.time)) {
        cartItemsPerOrder.update(cartItem.time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(cartItem.time!, () => 1);
      }
    }
  }

  List<int> get cartOrderTimeList =>
      cartItemsPerOrder.entries.map((e) => e.value).toList();
}
