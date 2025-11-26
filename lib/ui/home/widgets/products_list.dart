import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:overclock/core/extensions/list.dart';
import 'package:overclock/core/models/product_list.dart';
import 'package:overclock/ui/home/widgets/product_list_item.dart';
import 'package:overclock/ui/home/widgets/product_list_item_done.dart';

class ProductsList extends StatelessWidget {
  final List<ProductList> products;
  const ProductsList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.filter();

    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: filteredProducts.notDone.length,
          itemBuilder: (context, index) {
            return ProductListItem(
              product: filteredProducts.notDone[index],
              onClick: () {},
            );
          },
        ),

        Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: const FrostedDivider(),
        ),

        ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount: filteredProducts.done.length,
          itemBuilder: (context, index) {
            return ProductListItemDone(
              product: filteredProducts.done[index],
              onClick: () {},
            );
          },
        ),
      ],
    );
  }
}
