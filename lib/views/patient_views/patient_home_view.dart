import 'package:flutter/material.dart';
import 'package:randevu_al/views/patient_views/make_appointment_tab.dart';
import 'package:randevu_al/views/patient_views/patient_appointment_history_tab.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Column(
        children: const [
          TabBar(
            tabs: [
              Tab(text: 'Randevu Al'),
              Tab(text: 'Randevularım'),
            ],
          ),
          Expanded(
            child: TabBarView(children: [
              MakeAppointmentTab(),
              PatientAppointmentHistoryTab(),
            ]),
          ),
        ],
      ),
    );
  }
}
