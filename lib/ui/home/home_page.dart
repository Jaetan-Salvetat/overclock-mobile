import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:overclock/ui/common/providers/auth_provider.dart';
import 'package:overclock/ui/home/subviews/lists_list.dart';
import 'package:overclock/ui/home/subviews/products_list.dart';
import 'package:overclock/ui/common/widgets/creation_list_bottom_sheet.dart';
import 'package:overclock/ui/common/widgets/creation_product_bottom_sheet.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  HomePageTab currentTab = HomePageTab.lists;

  @override
  void initState() {
    super.initState();
    ref.read(authViewModel.notifier).listenSessionExpired(context);
  }

  @override
  Widget build(BuildContext context) {
    return FrostedScaffold(
      appBar: FrostedAppBar(title: currentTab.label),
      floatingActionButton: FrostedFloatingActionButton(
        onPressed: () => currentTab == HomePageTab.lists
            ? CreationListBottomSheet.show(context)
            : CreationProductBottomSheet.show(context),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: FrostedBottomNavigationBar(
        items: HomePageTab.values
            .map(
              (tab) => BottomNavigationBarItem(
                icon: Icon(tab.icon),
                activeIcon: Icon(tab.activeIcon),
                label: tab.label,
              ),
            )
            .toList(),
        currentIndex: currentTab.index,
        onTap: (index) {
          setState(() {
            currentTab = HomePageTab.values[index];
          });
        },
      ),
      child: currentTab == HomePageTab.lists
          ? const ListsList()
          : const ProductsList(),
    );
  }
}

enum HomePageTab {
  lists,
  products;

  String get label {
    switch (this) {
      case HomePageTab.products:
        return 'Produits';
      case HomePageTab.lists:
        return 'Listes';
    }
  }

  IconData get icon {
    switch (this) {
      case HomePageTab.lists:
        return Icons.dashboard_outlined;
      case HomePageTab.products:
        return Icons.inventory_2_outlined;
    }
  }

  IconData get activeIcon {
    switch (this) {
      case HomePageTab.lists:
        return Icons.dashboard;
      case HomePageTab.products:
        return Icons.inventory_2;
    }
  }
}
