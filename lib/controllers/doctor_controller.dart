import 'dart:async';

import 'package:get/get.dart';
import 'package:randevu_al/controllers/auth_controller.dart';
import 'package:randevu_al/core/helpers/custom_logger.dart';
import 'package:randevu_al/models/appointment_model.dart';
import 'package:randevu_al/services/supabase_database_service.dart';

class DoctorController extends GetxController {
  late final _authController = Get.find<AuthController>();
  late final _dbService = Get.find<SupabaseDatabaseService>();

  final RxList<AppointmentModel> appointments = RxList<AppointmentModel>([]);
  final Rx<DateTime> selectedDate = Rx<DateTime>(DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  ));

  StreamSubscription? _appointmentStream;

  DoctorController() {
    getAppointmentOfUser();
    _appointmentStream = _dbService
        .listenToAppointmentHistory(
      userId: _authController.user!.userId!,
      isDoctor: true,
    )
        .listen((event) {
      printI("Randevular Dinleniyor");
      printI("Event: $event");
      getAppointmentOfUser();
    });
  }

  @override
  void onClose() {
    _appointmentStream?.cancel();
    super.onClose();
  }

  Future<List<AppointmentModel>> getAppointmentOfUser() async {
    try {
      final data = await _dbService.getAppointmentHistory(
          userId: _authController.user!.userId!, isDoctor: true);
      appointments.value = data;
      return appointments;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<void> cancelAppointment(int appointmentId) async {
    try {
      await _dbService.cancelAppointment(appointmentId);
    } catch (e) {
      printE(e);
    }
  }
}
