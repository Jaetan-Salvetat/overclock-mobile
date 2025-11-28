import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overclock/core/networking/ws/models/request_event.dart';
import 'package:overclock/core/networking/ws/models/request_type.dart';
import 'package:overclock/core/services/token_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class AppWS {
  late final WebSocketChannel _channel;
  final _streamController = StreamController<dynamic>.broadcast();

  Stream<dynamic> get stream => _streamController.stream;

  Future<void> initialize() async {
    print("🔌 Connexion WebSocket...");

    try {
      final ws = await WebSocket.connect('wss://api.overclock.jaetan.fr/ws');
      _channel = IOWebSocketChannel(ws);
    } catch (e) {
      print("Erreur WS connect: $e");
    }

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
    print("📤 Envoyé: $data; type: $type");
    final token = await TokenService().getJwt() ?? "";
    final body = RequestEvent(
      header: Header(type: type, token: token),
      data: data,
    );

    _channel.sink.add(jsonEncode(body.toJson()));
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

extension WSListener on Ref {
  void listenToWsEvent(RequestType type, void Function(dynamic data) onEvent) {
    final subscription = listen(wsStreamProvider, (previous, next) {
      next.whenData((event) {
        if (event is Map &&
            event['header'] != null &&
            event['header']['type'] == type.label) {
          onEvent(event['data']);
        }
      });
    });

    onDispose(() => subscription.close());
  }

  Future<dynamic> waitForWsEvent(
    RequestType type, {
    Duration timeout = const Duration(seconds: 10),
  }) {
    final completer = Completer<dynamic>();
    late final ProviderSubscription subscription;

    final timer = Timer(timeout, () {
      if (!completer.isCompleted) {
        subscription.close();
        completer.completeError(
          TimeoutException('Timeout waiting for ${type.label}'),
        );
      }
    });

    subscription = listen(wsStreamProvider, (previous, next) {
      if (next is AsyncData) {
        final event = next.value;

        if (!completer.isCompleted &&
            event is Map &&
            event['header'] != null &&
            event['header']['type'] == type.label) {
          timer.cancel();
          completer.complete(event['data']);
          subscription.close();
        }
      }
    });

    return completer.future;
  }
}
