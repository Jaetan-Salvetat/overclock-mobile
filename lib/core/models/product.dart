class Product {
  final String name;
  final bool isDone;

  Product({required this.name, required this.isDone});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(name: json['name'], isDone: json['isDone']);
  }
}
