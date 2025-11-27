import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/ui/login/widgets/password_input.dart';
import 'package:overclock/ui/login/providers/login_provider.dart';
import 'package:overclock/ui/login/widgets/login_header.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginViewModel);
    final viewModel = ref.read(loginViewModel.notifier);

    return FrostedScaffold(
      appBar: FrostedAppBar(title: 'Login'),
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16,
          children: [
            const LoginHeader(),

            PasswordInput(
              controller: state.passwordController,
              errorText: state.passwordError,
            ),

            const SizedBox(height: 24),

            SizedBox(
              height: 50,
              child: FrostedFilledButton(
                onPressed: state.isLoading
                    ? null
                    : () => viewModel.login(context),
                child: state.isLoading
                    ? const FrostedCircularProgressIndicator(size: 20)
                    : const Text('Se connecter'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
