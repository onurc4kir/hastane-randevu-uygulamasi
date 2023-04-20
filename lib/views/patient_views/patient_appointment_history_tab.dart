import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/controllers/patient_controller.dart';

import '../../components/appointment_card.dart';

class PatientAppointmentHistoryTab extends StatelessWidget {
  const PatientAppointmentHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final patientController = Get.find<PatientController>();
    return Obx(() {
      return ListView.builder(
        itemCount: patientController.appointments.length,
        itemBuilder: (context, index) {
          final item = patientController.appointments[index];

          return AppointmentCard(
            appointment: item,
            onCancelTap: () async {
              await patientController.cancelAppointment(item.appointmentId!);
            },
          );
        },
      );
    });
  }
}
