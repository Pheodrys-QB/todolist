import 'package:get_it/get_it.dart';
import 'package:test_drive/stores/task_store.dart';
import 'package:flutter/foundation.dart';
import 'package:test_drive/services/notification_service.dart';

final serviceLocator = GetIt.instance;

Future<void> setup() async {
  serviceLocator.registerSingleton<TaskStore>(TaskStore());
  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    NotificationService notifi = NotificationService();
    await notifi.initNotification();
    serviceLocator
        .registerSingleton<NotificationService>(notifi);
  }
}
