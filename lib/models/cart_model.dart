class CartModel {
  int? id;
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
    id = json["id"];
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
