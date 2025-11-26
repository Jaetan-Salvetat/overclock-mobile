import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(
      passwordController: TextEditingController(),
      isLoading: false,
    );
  }

  void dispose() {
    state.passwordController.dispose();
  }

  void login() {
    state = state.copyWith(isLoading: true);
  }
}

class LoginState {
  final TextEditingController passwordController;
  final bool isLoading;

  LoginState({required this.passwordController, required this.isLoading});

  LoginState copyWith({bool? isLoading}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      passwordController: passwordController,
    );
  }
}

final loginViewModel = NotifierProvider<LoginNotifier, LoginState>(
  LoginNotifier.new,
);
