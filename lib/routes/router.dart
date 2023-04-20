import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:randevu_al/controllers/auth_controller.dart';
import 'package:randevu_al/controllers/home_controller.dart';
import 'package:randevu_al/controllers/notifications_controller.dart';
import 'package:randevu_al/views/home_page.dart';
import 'package:randevu_al/views/login_page.dart';
import 'package:randevu_al/views/notifications_page.dart';
import 'package:randevu_al/views/onboard_page.dart';
import 'package:randevu_al/views/register_page.dart';

import '../controllers/doctor_controller.dart';
import '../controllers/patient_controller.dart';

abstract class GetPages {
  static const String initialRoute = OnboardPage.route;
  static const String unknownRoute = LoginPage.route;

  static final pages = <GetPage>[
    GetPage(
      name: OnboardPage.route,
      page: () => const OnboardPage(),
    ),
    GetPage(
      name: LoginPage.route,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: RegisterPage.route,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: NotificationsPage.route,
      page: () => const NotificationsPage(),
    ),
    GetPage(
      name: HomePage.route,
      page: () => const HomePage(),
      binding: BindingsBuilder(() {
        final user = Get.find<AuthController>().user;
        if (user?.roleName == "DOCTOR") {
          Get.put(DoctorController());
        }

        if (user?.roleName == "USER") {
          Get.put(PatientController());
        }

        Get.put(NotificationsController());
        Get.put(HomeController());
      }),
    ),
  ];
}
