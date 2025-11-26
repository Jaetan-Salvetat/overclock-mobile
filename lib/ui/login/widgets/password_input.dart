import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  const PasswordInput({super.key, required this.controller});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return FrostedTextField(
      controller: widget.controller,
      obscureText: _obscureText,
      prefixIcon: const Icon(Icons.lock),
      hintText: 'Mot de passe',
      suffixIcon: FrostedIconButton(
        icon: _obscureText ? Icons.visibility : Icons.visibility_off,
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      ),
    );
  }
}
