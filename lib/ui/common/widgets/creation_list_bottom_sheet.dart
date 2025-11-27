import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreationListBottomSheet extends ConsumerWidget {
  final TextEditingController _nameController = TextEditingController();
  CreationListBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onPressed: () {
            print("creation");
          },
          child: const Text("Créer"),
        ),
      ],
    );
  }

  static void show(BuildContext context) {
    FrostedBottomSheet.show(
      context: context,
      title: "Création d'une nouvelle liste",
      child: CreationListBottomSheet(),
    );
  }
}
