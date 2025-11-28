import 'package:flutter/material.dart';
import 'package:overclock/ui/common/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/ui/login/login_page.dart';
import 'package:overclock/ui/spash_screen/spash_screen.dart';
import 'package:overclock/ui/common/providers/auth_provider.dart';
import 'package:overclock/ui/home/home_page.dart';
import 'package:overclock/core/networking/ws/app_ws.dart';
import 'package:overclock/ui/common/widgets/phoenix.dart';

void main() {
  runApp(Phoenix(child: const ProviderScope(child: MyApp())));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  bool _hasWSInitialized = false;

  @override
  void initState() {
    super.initState();
    ref
        .read(appWSProvider)
        .initialize()
        .then(
          (value) => setState(() {
            _hasWSInitialized = true;
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authViewModel);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Overclock',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: _getScreen(authState),
    );
  }

  Widget _getScreen(AuthState authState) {
    if (authState.isLoading || !_hasWSInitialized) {
      return const SplashScreen();
    }
    return authState.isLoggedIn ? const HomePage() : const LoginPage();
  }
}
