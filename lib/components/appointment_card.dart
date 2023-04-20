import 'package:flutter/material.dart';
import 'package:randevu_al/components/custom_shaped_button.dart';
import 'package:randevu_al/core/theme/colors.style.dart';
import 'package:randevu_al/core/utilities/extensions.dart';
import 'package:randevu_al/models/appointment_model.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentModel appointment;
  final bool isRenderForDoctor;
  final VoidCallback onCancelTap;
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onCancelTap,
    this.isRenderForDoctor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          if (!isRenderForDoctor)
            ListTile(
              leading: const Icon(Icons.vaccines_outlined),
              title: Text(appointment.doctorName ?? "Doktor Adı Yok"),
              subtitle: Text(appointment.branchName ?? "Branş Adı Yok"),
            ),
          if (isRenderForDoctor)
            ListTile(
              leading: const Icon(Icons.vaccines_outlined),
              title: Text(appointment.patientName ?? "Hasta Adı Yok"),
              subtitle: Text(appointment.branchName ?? "Branş Adı Yok"),
            ),
          ListTile(
            leading: Icon(
              Icons.dark_mode,
              color: Colors.red.shade700,
            ),
            title: Text(appointment.hospitalName ?? "Hastane Adı Yok"),
          ),
          ListTile(
            leading: const Icon(
              Icons.event,
            ),
            title: Text(appointment.date.formattedDateForUI),
            trailing: Text(appointment.time.timeForUi),
          ),
          _buildAppointmentStateAction()
        ],
      ),
    );
  }

  Widget _buildAppointmentStateAction() {
    if (appointment.isCancelled) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Randevu İptal Edildi",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    if (appointment.from.isBefore(DateTime.now())) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Randevu Tarihi Geçmiş",
            style: TextStyle(
              color: IColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CustomShapedButton(
        type: ButtonType.danger,
        text: "Randevuyu İptal Et",
        onPressed: onCancelTap,
      ),
    );
  }
}
