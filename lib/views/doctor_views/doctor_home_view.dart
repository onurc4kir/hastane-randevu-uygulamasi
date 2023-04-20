import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/components/appointment_card.dart';
import 'package:randevu_al/controllers/doctor_controller.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/appointment_model.dart';

class DoctorHomeView extends StatefulWidget {
  const DoctorHomeView({super.key});

  @override
  State<DoctorHomeView> createState() => _DoctorHomeViewState();
}

class _DoctorHomeViewState extends State<DoctorHomeView> {
  late final doctorController = Get.find<DoctorController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => SfCalendar(
            view: CalendarView.month,
            initialDisplayDate: DateTime.now(),
            dataSource:
                AppointmentDataSource(doctorController.appointments.value),
            minDate: DateTime.now(),
            maxDate: DateTime.now().add(const Duration(days: 7)),
            onTap: (details) async {
              if (details.targetElement == CalendarElement.calendarCell) {
                final date = details.date!;
                doctorController.selectedDate.value = date;
              }
            },
          ),
        ),
        Expanded(
          child: Obx(() {
            final selectedDate = doctorController.selectedDate;
            final filteredAppointments = doctorController.appointments
                .where((element) =>
                    element.date.year == selectedDate.value.year &&
                    element.date.month == selectedDate.value.month &&
                    element.date.day == selectedDate.value.day)
                .toList();
            return ListView.builder(
              itemCount: filteredAppointments.length,
              itemBuilder: (context, index) {
                final item = filteredAppointments[index];
                return AppointmentCard(
                    appointment: item,
                    isRenderForDoctor: true,
                    onCancelTap: () async {
                      await doctorController
                          .cancelAppointment(item.appointmentId!);
                    });
              },
            );
          }),
        ),
      ],
    );
  }
}
