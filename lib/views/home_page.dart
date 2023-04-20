import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/components/custom_scaffold.dart';
import 'package:randevu_al/components/user_activity_detector.dart';
import 'package:randevu_al/controllers/auth_controller.dart';
import 'package:randevu_al/controllers/home_controller.dart';
import 'package:randevu_al/core/helpers/custom_logger.dart';
import 'package:randevu_al/views/notifications_page.dart';
import 'package:randevu_al/views/patient_views/patient_home_view.dart';
import 'package:randevu_al/views/login_page.dart';
import 'package:randevu_al/views/doctor_views/doctor_home_view.dart';

class HomePage extends GetView<HomeController> {
  static const route = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return UserActivityDetector(
      child: CustomScaffold(
        appBar: AppBar(
          title: Text('Hoşgeldiniz, ${authController.user?.name}'),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(
                  NotificationsPage.route,
                );
              },
              icon: const Icon(Icons.notifications),
            ),
            IconButton(
              onPressed: () {
                authController.logout().then(
                      (value) => Get.offAllNamed(
                        LoginPage.route,
                      ),
                    );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        isShowBackButton: false,
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    final authController = Get.find<AuthController>();
    printI("User Role: ${authController.user?.roleName}");
    if (authController.user?.roleName == "DOCTOR") {
      return const DoctorHomeView();
    }
    if (authController.user?.roleName == "USER") {
      return const PatientHomeView();
    }

    return const Center(
      child: Text('Rolünüz belirlenmemiş'),
    );
  }
}
