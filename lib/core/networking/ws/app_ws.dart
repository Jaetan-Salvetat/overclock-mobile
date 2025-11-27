import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/errors/app_errors.dart';
import 'package:overclock/core/networking/ws/models/request_event.dart';
import 'package:overclock/core/networking/ws/models/request_type.dart';
import 'package:overclock/core/services/token_service.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class AppWS {
  late final WebSocketChannel _channel;
  final _streamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get stream => _streamController.stream;

  void initialize() {
    print("🔌 Connexion WebSocket...");
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.overclock.jaetan.fr'),
    );

    _channel.stream.listen(
      (message) {
        print("📩 Reçu: $message");
        final decoded = jsonDecode(message);
        _streamController.add(decoded);
      },
      onDone: () {
        print("Deconnexion WS");
        _channel.sink.close(status.normalClosure);
      },
      onError: (error) => print("Erreur WS: $error"),
    );
  }

  void disconnect() {
    _channel.sink.close(status.normalClosure);
  }

  Future<void> send(RequestType type, Map<String, dynamic> data) async {
    final token = await TokenService().getToken() ?? "";
    final body = RequestEvent(
      header: Header(type: type, token: token),
      data: data,
    );

    _channel.sink.add(jsonEncode(body.toJson()));
  }

  Future<dynamic> sendAndReceive(
    RequestType type,
    Map<String, dynamic> data,
  ) async {
    await send(type, data);

    try {
      final result = stream
          .firstWhere((event) => event['type'] == type.label)
          .timeout(const Duration(seconds: 10));
      return result;
    } catch (e) {
      throw AppError.timeout;
    }
  }
}

final appWSProvider = Provider<AppWS>((ref) {
  final ws = AppWS();
  ref.onDispose(() {
    ws.disconnect();
  });
  return ws;
});

final wsStreamProvider = StreamProvider<dynamic>((ref) {
  final ws = ref.watch(appWSProvider);
  return ws.stream;
});
