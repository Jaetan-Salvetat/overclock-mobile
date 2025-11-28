import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/ui/common/providers/product_lists_provider.dart';

class CreationListBottomSheet extends ConsumerStatefulWidget {
  CreationListBottomSheet({super.key});

  @override
  ConsumerState<CreationListBottomSheet> createState() =>
      _CreationListBottomSheetState();

  static void show(BuildContext context) {
    FrostedBottomSheet.show(
      context: context,
      title: "Création d'une nouvelle liste",
      child: CreationListBottomSheet(),
    );
  }
}

class _CreationListBottomSheetState
    extends ConsumerState<CreationListBottomSheet> {
  final TextEditingController _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FrostedTextField(
          hintText: "Nom de la liste",
          controller: _nameController,
        ),
        const SizedBox(height: 16),
        FrostedFilledButton(
          onPressed: _isLoading ? null : _createList,
          child: _isLoading
              ? const FrostedCircularProgressIndicator(size: 20)
              : const Text("Créer"),
        ),
      ],
    );
  }

  void _createList() {
    final productListsVM = ref.read(productListsProvider.notifier);
    setState(() {
      _isLoading = true;
    });
    productListsVM
        .createList(_nameController.text)
        .then(
          (data) => setState(() {
            _isLoading = false;
          }),
        );
  }
}
