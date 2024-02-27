class ProductModel {
  String? name;
  String? price;
  String? barcode;

  ProductModel({required this.name, required this.price});

  ProductModel.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    price = json["price"];
    barcode = json["barcode"];
  }
  Map<String, dynamic> toMap() {
    return {'name': name, 'price': price, 'barcode': barcode};
  }
}
