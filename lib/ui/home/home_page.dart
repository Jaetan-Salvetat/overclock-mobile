import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/ui/common/providers/product_lists_provider.dart';
import 'package:overclock/ui/common/widgets/loading_state.dart';
import 'package:overclock/ui/home/widgets/products_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListVM = ref.watch(productListsProvider);

    return FrostedScaffold(
      appBar: const FrostedAppBar(title: 'Overclock'),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: productsListVM.when(
        data: (data) => ProductsList(products: data),
        error: (error, stackTrace) => const Placeholder(),
        loading: () => const LoadingState(),
      ),
    );
  }
}
