import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/networking/ws/app_ws.dart';
import 'package:overclock/core/services/token_service.dart';
import 'package:overclock/ui/common/widgets/expired_session_dialog.dart';

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

  void listenSessionExpired(BuildContext context) {
    ref.listen(wsStreamProvider, (previous, next) {
      next.whenData((event) {
        if (event is Map &&
            event['header'] != null &&
            event['header']['success'] == false) {
          ExpiredSessionDialog.show(context);
        }
      });
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
