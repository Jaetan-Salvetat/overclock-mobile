import 'product.dart';

class ProductList {
  final int id;
  final String name;
  final List<Product> products;

  ProductList({required this.id, required this.name, required this.products});

  static List<ProductList> fromJsonList(List<Map<String, dynamic>> json) {
    return json.map((x) => ProductList.fromJson(x)).toList();
  }

  factory ProductList.fromJson(Map<String, dynamic> json) {
    return ProductList(
      id: json['id'],
      name: json['name'],
      products: json['products'] == null || json['products'].isEmpty
          ? []
          : List<Product>.from(
              json['products'].map((x) => Product.fromJson(x)),
            ),
    );
  }
}
