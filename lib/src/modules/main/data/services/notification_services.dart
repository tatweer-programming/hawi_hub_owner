import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationServices {
  Future<void> init() async {
    final wsUrl = Uri.parse('ws://example.com');
    final channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;

    channel.stream.listen((message) {
      channel.sink.add(message);
      channel.sink.close();
    });
  }

  Future<Either<Exception, List<AppNotification>>> getNotifications() async {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> sendNotification(AppNotification appNotification) async {
    throw UnimplementedError();
  }
}
