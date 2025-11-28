import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/models/product_list.dart';
import 'package:overclock/core/networking/ws/app_ws.dart';
import 'package:overclock/core/networking/ws/models/request_type.dart';

class ProductListsNotifier extends AsyncNotifier<List<ProductList>> {
  @override
  Future<List<ProductList>> build() async {
    final result = _fetchList();
    listenUpdates();

    return result;
  }

  Future<List<ProductList>> _fetchList() async {
    ref.watch(appWSProvider).send(RequestType.getAllLists, {});

    final result = await ref.waitForWsEvent(RequestType.getAllLists);
    return ProductList.fromJsonList(result.toList());
  }

  // Actions
  Future<bool> createList(String listName) async {
    final ws = ref.watch(appWSProvider);

    ws.send(RequestType.createList, {"list_name": listName});
    await ref.waitForWsEvent(RequestType.createList);

    return true;
  }

  // Listeners
  void listenUpdates() {
    handleNewList();
  }

  void handleNewList() {
    ref.listenToWsEvent(RequestType.newList, (data) {
      final lists = ProductList.fromJsonList(data.toList());
      state = AsyncValue.data([...state.value!, ...lists]);
    });
  }
}

final productListsProvider =
    AsyncNotifierProvider<ProductListsNotifier, List<ProductList>>(
      () => ProductListsNotifier(),
    );
