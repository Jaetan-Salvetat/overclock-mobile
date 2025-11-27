import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

abstract class AppWS {
  late final WebSocketChannel channel;

  Stream<dynamic> get stream => channel.stream;

  AppWS() {
    channel = WebSocketChannel.connect(
      Uri.parse('wss://api.overclock.jaetan.fr'),
    );
  }

  Future<void> initialize() async {
    await channel.ready;

    stream.listen((message) {
      print(message);
    });
  }

  void disconnect() {
    channel.sink.close(status.normalClosure);
  }
}
