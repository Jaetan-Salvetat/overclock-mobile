import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/ui/common/providers/product_lists_provider.dart';
import 'package:overclock/ui/common/widgets/loading_state.dart';
import 'package:overclock/ui/home/widgets/products_list.dart';

class ListsList extends ConsumerWidget {
  const ListsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListVM = ref.watch(productListsProvider);

    return productsListVM.when(
      data: (data) => ProductsList(products: data),
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      loading: () => const LoadingState(),
    );
  }
}
