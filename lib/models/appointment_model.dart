import 'package:flutter/material.dart';
import 'package:randevu_al/core/theme/colors.style.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentModel {
  int? appointmentId;
  int? doctorId;
  int? patientId;
  DateTime date;
  TimeOfDay time;
  int durationInMinutes;
  int? branchId;
  int? hospitalId;
  bool isCancelled;

  String? patientName;
  String? doctorName;
  String? hospitalName;
  String? branchName;

  AppointmentModel(
      {this.appointmentId,
      this.doctorId,
      this.patientId,
      required this.date,
      required this.time,
      required this.durationInMinutes,
      this.branchId,
      this.hospitalId,
      this.patientName,
      this.doctorName,
      this.hospitalName,
      this.branchName,
      required this.isCancelled});

  DateTime get from => DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );

  DateTime get to => from.add(Duration(minutes: durationInMinutes));

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      appointmentId: json['appointment_id'],
      doctorId: json['doctor_id'],
      patientId: json['patient_id'],
      date: DateTime.parse(json['date']),
      time: TimeOfDay(
        hour: int.parse(json['time'].toString().split(":")[0]),
        minute: int.parse(json['time'].toString().split(":")[1]),
      ),
      isCancelled: json['is_cancelled'],
      durationInMinutes: json['duration_in_min'],
      branchId: json['branch_id'],
      hospitalId: json['hospital_id'],
      patientName: json['patient_name'],
      doctorName: json['doctor_name'],
      hospitalName: json['hospital_name'],
      branchName: json['branch_name'],
    );
  }

  //generate toMap
  Map<String, dynamic> toMap() {
    return {
      'doctor_id': doctorId,
      'patient_id': patientId,
      'date': date.toString(),
      'time': "${time.hour}:${time.minute}:00",
      'branch_id': branchId,
      'hospital_id': hospitalId,
      'is_cancelled': isCancelled,
    };
  }
}

class AppointmentDataSource extends CalendarDataSource<AppointmentModel> {
  AppointmentDataSource(List<AppointmentModel> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return "Dolu";
  }

  @override
  Color getColor(int index) {
    return IColors.primary;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
