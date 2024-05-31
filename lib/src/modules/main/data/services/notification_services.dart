import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';
import 'package:hawi_hub_owner/src/modules/places/data/data_sources/place_remote_data_source.dart';

class NotificationServices {
  Future<void> init() async {
    // final wsUrl = Uri.parse(ApiManager.webSocket);
    // final channel = WebSocketChannel.connect(wsUrl);
    // await channel.ready;
    // channel.stream.listen((message) {
    //   channel.sink.add(message);
    //   channel.sink.close();
    // });
  }

  Future<Either<Exception, List<AppNotification>>> getNotifications() async {
    await startTimer(1);
    return const Right([]);
  }

  Future<Either<Exception, Unit>> sendNotification(AppNotification appNotification) async {
    throw UnimplementedError();
  }
}
