import 'package:flutter/material.dart';
import 'package:frosted_ui/frosted_ui.dart';
import 'package:overclock/core/networking/http/auth_api.dart';
import 'package:overclock/core/services/token_service.dart';
import 'package:overclock/ui/common/widgets/phoenix.dart';

class ExpiredSessionDialog extends StatefulWidget {
  const ExpiredSessionDialog({super.key});

  @override
  State<ExpiredSessionDialog> createState() => _ExpiredSessionDialogState();

  static void show(BuildContext context) {
    FrostedDialog.show(
      context: context,
      title: const Text('Session Expiré'),
      content: const ExpiredSessionDialog(),
    );
  }
}

class _ExpiredSessionDialogState extends State<ExpiredSessionDialog> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Veuillez redémarrer l\'application'),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FrostedFilledButton(
              onPressed: onRestartApp,
              child: _isLoading
                  ? const FrostedCircularProgressIndicator(size: 20)
                  : const Text('Redémarrer'),
            ),
          ],
        ),
      ],
    );
  }

  void onRestartApp() {
    setState(() {
      _isLoading = true;
    });
    restartApp(context);
  }

  Future<void> restartApp(BuildContext context) async {
    final token = await TokenService.instance.getToken();
    await AuthApi().login(token!);

    if (context.mounted) {
      Phoenix.rebirth(context);
    }
  }
}
