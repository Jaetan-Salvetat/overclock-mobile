import 'product.dart';

class ProductList {
  final int id;
  final String name;
  final List<Product> products;

  ProductList({required this.id, required this.name, required this.products});
}
