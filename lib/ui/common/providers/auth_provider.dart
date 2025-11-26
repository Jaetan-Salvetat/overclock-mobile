import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    return AuthState(isLoggedIn: false);
  }

  void login() {
    state = state.copyWith(isLoggedIn: true);
  }

  void logout() {
    state = state.copyWith(isLoggedIn: false);
  }
}

class AuthState {
  final bool isLoggedIn;

  AuthState({required this.isLoggedIn});

  AuthState copyWith({bool? isLoggedIn}) {
    return AuthState(isLoggedIn: isLoggedIn ?? this.isLoggedIn);
  }
}

final authViewModel = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
