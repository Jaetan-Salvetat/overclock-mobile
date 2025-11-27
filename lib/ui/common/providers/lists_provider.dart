import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/models/product_list.dart';

class ListsNotifier extends Notifier<List<ProductList>> {
  @override
  List<ProductList> build() {
    return [];
  }
}
