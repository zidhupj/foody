import 'package:foody/pages/cart/cart_history.dart';

class CartModel {
  String? id;
  String? name;
  double? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;

  CartModel(
      {this.id,
      this.name,
      this.price,
      this.img,
      this.quantity,
      this.isExist,
      this.time});

  CartModel.fromJSON(Map<String, dynamic> json) {
    id = json["id"].toString();
    name = json["name"];
    price = json["price"].toDouble();
    img = json["img"];
    quantity = json["quantity"];
    isExist = json["isExist"];
    time = json["time"];
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExist": isExist,
      "time": time
    };
  }
}

class CartHistoryModel {
  List<CartModel> _cartHistoryItems = [];
  List<CartModel> get cartHistoryItems => _cartHistoryItems;

  CartHistoryModel(List<CartModel> cartHistory) {
    _cartHistoryItems = cartHistory;
  }

  Map<String, dynamic> toJSON() {
    return {
      "cartHistoryItems": _cartHistoryItems.map((e) => e.toJSON()).toList(),
    };
  }

  CartHistoryModel.fromJSON(Map<String, dynamic> json) {
    var x = json["cartHistoryItems"].map((e) => CartModel.fromJSON(e)).toList();
    _cartHistoryItems = (json["cartHistoryItems"] as List)
        .map((e) => CartModel.fromJSON(Map<String, dynamic>.from(e)))
        .toList();
  }
}
