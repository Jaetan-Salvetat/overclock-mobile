import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/networking/http/auth_api.dart';
import 'package:overclock/core/errors/app_errors.dart';
import 'package:overclock/ui/common/widgets/error_dialog.dart';
import 'package:overclock/ui/common/providers/auth_provider.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(
      passwordController: TextEditingController(),
      isLoading: false,
      error: null,
      passwordError: null,
    );
  }

  void dispose() {
    state.passwordController.dispose();
  }

  void login(BuildContext context) {
    if (!_validate()) {
      state = state.copyWith(passwordError: 'Le mot de passe est requis');
      return;
    }
    state = state.copyWith(isLoading: true);

    AuthApi()
        .login(state.passwordController.text)
        .then((value) {
          state = state.copyWith(isLoading: false);
          ref.invalidate(authViewModel);
        })
        .catchError((err) {
          final error = AppError.fromObject(err);
          state = state.copyWith(isLoading: false, error: error);
          if (context.mounted) {
            _showErrorDialog(context, error);
          }
        });
  }

  bool _validate() {
    return state.passwordController.text.isNotEmpty;
  }

  void _showErrorDialog(BuildContext context, AppError error) {
    ErrorDialog.show(context, error.label);
  }
}

class LoginState {
  final TextEditingController passwordController;
  final bool isLoading;
  final AppError? error;
  final String? passwordError;

  LoginState({
    required this.passwordController,
    required this.isLoading,
    required this.error,
    required this.passwordError,
  });

  LoginState copyWith({
    bool? isLoading,
    AppError? error,
    String? passwordError,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      passwordController: passwordController,
      error: error ?? this.error,
      passwordError: passwordError ?? this.passwordError,
    );
  }
}

final loginViewModel = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
