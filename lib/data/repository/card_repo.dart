import 'dart:convert';

import 'package:foody/models/cart_model.dart';
import 'package:foody/utils/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo extends GetxService {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> _cart = [];
  List<String> _cartHistory = [];

  set initCart(List<CartModel> cartList) {
    _cart = [];
    _cart = cartList.map((e) => jsonEncode(e.toJSON())).toList();
  }

  set initCartHistory(List<CartModel> cartHistory) {
    var cartHistoryString =
        cartHistory.map((e) => jsonEncode(e.toJSON())).toList();
    sharedPreferences.setStringList(
        AppConstants.cartHistoryList, cartHistoryString);
  }

  void addToCartList(List<CartModel> cartList) {
    // sharedPreferences.remove(AppConstants.cartHistoryList);
    // sharedPreferences.remove(AppConstants.cartList);

    _cart = [];
    var time = DateTime.now().toString();
    _cart = cartList.map((e) {
      e.time = time;
      return jsonEncode(e.toJSON());
    }).toList();

    sharedPreferences.setStringList(AppConstants.cartList, _cart);
    // print(sharedPreferences.getStringList(AppConstants.cartList));
    // List<CartModel> newCartList = getCartList;
    // newCartList.forEach((element) {
    //   print("${element.name} ${element.quantity}");
    // });
  }

  List<CartModel> get getCartList {
    _cart = [];
    List<CartModel> cartList = [];
    if (sharedPreferences.containsKey(AppConstants.cartList)) {
      _cart = sharedPreferences.getStringList(AppConstants.cartList)!;
      cartList = _cart.map((e) => CartModel.fromJSON(jsonDecode(e))).toList();
    }
    return cartList;
  }

  void addToCartHistory() {
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      _cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
    }
    for (var cartItem in _cart) {
      _cartHistory.add(cartItem);
    }
    sharedPreferences.setStringList(AppConstants.cartHistoryList, _cartHistory);
    print(sharedPreferences.getStringList(AppConstants.cartHistoryList));
    sharedPreferences.remove(AppConstants.cartList);
    _cart = [];

    print("History length: ${getHistoryList.length}");
  }

  List<CartModel> get getHistoryList {
    _cartHistory = [];
    List<CartModel> historyList = [];
    if (sharedPreferences.containsKey(AppConstants.cartHistoryList)) {
      _cartHistory =
          sharedPreferences.getStringList(AppConstants.cartHistoryList)!;
      historyList =
          _cartHistory.map((e) => CartModel.fromJSON(jsonDecode(e))).toList();
    }
    return historyList;
  }
}
