class Products {
  int? _totalSize;
  int? _typeId;
  int? _offset;

  late List<ProductItem> _productList;
  List<ProductItem> get productList => _productList;

  Products(
      {required totalSize,
      required typeId,
      required offset,
      required productList}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _productList = productList;
  }

  Products.fromJSON(Map<String, dynamic> json) {
    _totalSize = json["total_size"];
    _typeId = json["type_id"];
    _offset = json["offset"];
    if (json["products"] != null) {
      _productList = <ProductItem>[];
      for (var product in (json["products"] as List)) {
        _productList.add(ProductItem.fromJSON(product));
      }
    }
  }
}

class ProductItem {
  int? id;
  String? name;
  String? description;
  double? price;
  double? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductItem(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.createdAt,
      this.updatedAt,
      this.location,
      this.img,
      this.typeId});

  ProductItem.fromJSON(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    price = json["price"].toDouble();
    stars = json["stars"].toDouble();
    img = json["img"];
    location = json["location"];
    createdAt = json["created_at"];
    updatedAt = json["updated_at"];
    typeId = json["type_id"];
  }

  Map<String, dynamic> toJSON() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "stars": stars,
      "img": img,
      "location": location,
      "createdAt": createdAt,
      "updatedAt": updatedAt,
      "typeId": typeId
    };
  }
}
