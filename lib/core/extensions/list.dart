import 'package:overclock/core/models/product_list.dart';
import 'package:overclock/core/models/product_list_filtered.dart';

extension ListExtension on List<ProductList> {
  ProductListFiltered filter() {
    final done = where(
      (list) => list.products.every((product) => product.isDone),
    ).toList();
    final notDone = where(
      (list) => !list.products.every((product) => product.isDone),
    ).toList();
    return ProductListFiltered(done: done, notDone: notDone);
  }
}
