import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/models/product_list.dart';
import 'package:overclock/core/models/product.dart';

class ProductsListNotifier extends AsyncNotifier<List<ProductList>> {
  @override
  Future<List<ProductList>> build() async {
    return await _fetchProductsList();
  }

  Future<List<ProductList>> _fetchProductsList() async {
    return await Future.delayed(const Duration(seconds: 2), () {
      return generateProductList();
    });
  }
}

final productsListProvider =
    AsyncNotifierProvider<ProductsListNotifier, List<ProductList>>(
      () => ProductsListNotifier(),
    );

List<ProductList> generateProductList() {
  return [
    ProductList(
      id: 1,
      name: 'Liste 1',
      products: [
        Product(id: 1, name: 'Produit 1', isDone: false),
        Product(id: 2, name: 'Produit 2', isDone: false),
        Product(id: 3, name: 'Produit 3', isDone: false),
        Product(id: 1, name: 'Produit 1', isDone: false),
        Product(id: 2, name: 'Produit 2', isDone: false),
        Product(id: 3, name: 'Produit 3', isDone: false),
        Product(id: 1, name: 'Produit 1', isDone: false),
        Product(id: 2, name: 'Produit 2', isDone: false),
        Product(id: 3, name: 'Produit 3', isDone: false),
        Product(id: 1, name: 'Produit 1', isDone: false),
        Product(id: 2, name: 'Produit 2', isDone: false),
        Product(id: 3, name: 'Produit 3', isDone: false),
      ],
    ),
    ProductList(
      id: 2,
      name: 'Liste 2',
      products: [
        Product(id: 4, name: 'Produit 4', isDone: false),
        Product(id: 5, name: 'Produit 5', isDone: true),
        Product(id: 6, name: 'Produit 6', isDone: false),
      ],
    ),
    ProductList(
      id: 3,
      name: 'Liste 3',
      products: [
        Product(id: 7, name: 'Produit 7', isDone: true),
        Product(id: 8, name: 'Produit 8', isDone: true),
        Product(id: 6, name: 'Produit 6', isDone: true),
      ],
    ),
  ];
}
