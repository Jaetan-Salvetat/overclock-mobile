import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/services/token_service.dart';

class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _checkAuth();
    return AuthState(isLoggedIn: false, isLoading: true);
  }

  void _checkAuth() {
    TokenService.instance.getToken().then((token) {
      print(token);
      state = state.copyWith(isLoggedIn: token != null, isLoading: false);
    });
  }
}

class AuthState {
  final bool isLoggedIn;
  final bool isLoading;

  AuthState({required this.isLoggedIn, required this.isLoading});

  AuthState copyWith({bool? isLoggedIn, bool? isLoading}) {
    return AuthState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final authViewModel = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
