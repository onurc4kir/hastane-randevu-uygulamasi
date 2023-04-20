import 'dart:async';

import 'package:get/get.dart';
import 'package:randevu_al/core/helpers/custom_logger.dart';
import '../models/notification_model.dart';
import '../services/supabase_database_service.dart';
import 'auth_controller.dart';

class NotificationsController extends GetxController {
  final _authController = Get.find<AuthController>();
  final _dbService = Get.find<SupabaseDatabaseService>();

  RxList<NotificationModel> items = RxList([]);

  StreamSubscription? _notificationStream;
  NotificationsController() {
    _notificationStream = _listenNotifications().listen((event) {
      printI("Bildirimler Dinleniyor...");
      _dbService
          .getUserNotifications(_authController.user!.userId!)
          .then((value) => items.value = value);
    });
  }

  @override
  void onClose() {
    _notificationStream?.cancel();
    super.onClose();
  }

  Stream _listenNotifications() {
    return _dbService.listenUserNotifications(_authController.user!.userId!);
  }
}
