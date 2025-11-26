import 'package:overclock/core/models/product_list.dart';

class ProductListFiltered {
  final List<ProductList> done;
  final List<ProductList> notDone;

  ProductListFiltered({required this.done, required this.notDone});
}
