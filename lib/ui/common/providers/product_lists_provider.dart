import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/models/product_list.dart';
import 'package:overclock/core/networking/ws/app_ws.dart';
import 'package:overclock/core/networking/ws/models/request_type.dart';

class ProductListsNotifier extends AsyncNotifier<List<ProductList>> {
  @override
  Future<List<ProductList>> build() async {
    final completer = Completer<List<ProductList>>();
    final result = _fetchList(completer);

    completer.complete(result);
    return result;
  }

  Future<List<ProductList>> _fetchList(
    Completer<List<ProductList>> completer,
  ) async {
    final ws = ref.watch(appWSProvider);

    await ws.send(RequestType.getAllLists, {});

    final suscription = ref.listen(wsStreamProvider, (previous, next) {
      next.whenData((event) {
        if (event['type'] == RequestType.getAllLists.label) {
          final data = ProductList.fromJsonList(event['data']);
          completer.complete(data);
        }
      });
    });

    ref.onDispose(() => suscription.close());

    return completer.future;
  }
}

final productListsProvider =
    AsyncNotifierProvider<ProductListsNotifier, List<ProductList>>(
      () => ProductListsNotifier(),
    );
