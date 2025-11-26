import 'package:flutter/material.dart';
import 'package:overclock/ui/common/app_theme.dart';
import 'package:overclock/ui/common/providers/auth_provider.dart';
import 'package:overclock/ui/home/home_page.dart';
import 'package:overclock/ui/login/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModel);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overclock',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: authState.isLoggedIn ? const HomePage() : const LoginPage(),
    );
  }
}
