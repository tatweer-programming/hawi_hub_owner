import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/modules/main/data/models/app_notification.dart';

class NotificationServices {
  Future<void> init() async {}

  Future<Either<Exception, List<AppNotification>>> getNotifications() async {
    throw UnimplementedError();
  }

  Future<Either<Exception, Unit>> sendNotification(AppNotification appNotification) async {
    throw UnimplementedError();
  }
}
