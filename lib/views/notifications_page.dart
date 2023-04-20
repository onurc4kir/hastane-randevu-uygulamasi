import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../components/custom_scaffold.dart';
import '../controllers/notifications_controller.dart';

class NotificationsPage extends StatefulWidget {
  static const route = "/notifications";
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late final NotificationsController notificationsController;
  final DateTime now = DateTime.now();
  @override
  void initState() {
    notificationsController = Get.find<NotificationsController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Bildirimler'.tr,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: ListView.builder(
          itemCount: notificationsController.items.length,
          itemBuilder: (context, index) {
            final item = notificationsController.items[index];

            return _buildNotificationsItem(
              title: item.title ?? "",
              desc: item.description,
              createdAt: item.createdAt,
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationsItem({
    required String title,
    String? desc,
    DateTime? createdAt,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Text(
          desc ?? '',
          style: const TextStyle(fontSize: 12),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat("HH:mm").format(createdAt!),
            style: const TextStyle(
              color: Color(0xff6F7070),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat("dd/MM/yy").format(createdAt),
            style: const TextStyle(
              color: Color(0xff6F7070),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
