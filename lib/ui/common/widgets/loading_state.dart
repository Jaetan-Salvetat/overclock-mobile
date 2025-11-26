import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: FrostedCircularProgressIndicator());
  }
}
