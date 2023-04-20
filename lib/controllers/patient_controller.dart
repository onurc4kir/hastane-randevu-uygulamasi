import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:randevu_al/controllers/auth_controller.dart';
import 'package:randevu_al/core/helpers/custom_logger.dart';
import 'package:randevu_al/models/appointment_model.dart';
import 'package:randevu_al/models/branch_model.dart';
import 'package:randevu_al/models/city_model.dart';
import 'package:randevu_al/models/doctor_model.dart';
import 'package:randevu_al/models/hospital_model.dart';

import '../services/supabase_database_service.dart';

class PatientController extends GetxController {
  late final _authController = Get.find<AuthController>();
  late final _dbService = Get.find<SupabaseDatabaseService>();
  RxList<CityModel> cities = RxList<CityModel>([]);
  RxList<BranchModel> branches = RxList<BranchModel>([]);
  RxList<AppointmentModel> appointments = RxList<AppointmentModel>([]);

  Rx<int?> selectedCityId = Rx<int?>(null);
  Rx<int?> selectedHospitalId = Rx<int?>(null);
  Rx<int?> selectedBranchId = Rx<int?>(null);
  Rx<int?> selectedDoctorId = Rx<int?>(null);
  DateTime? selectedDate;
  StreamSubscription? _appointmentStream;
  PatientController() {
    _getCities();
    _getBranches();
    getAppointmentOfUser();
    _appointmentStream = getAppointmentStream().listen((event) {
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

  Future<List<CityModel>> _getCities() async {
    try {
      final cities = await _dbService.getCities();
      this.cities.value = cities;
      return cities;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<List<HospitalModel>> getHospitalsByCity(int cityId) async {
    try {
      final hospitals = await _dbService.getHospitalsByCity(cityId);
      return hospitals;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<List<BranchModel>> _getBranches() async {
    try {
      branches.value = await _dbService.getBranches();
      return branches;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<List<DoctorModel>> getDoctorsByBranch(
      int branchId, int hospitalId) async {
    try {
      final doctors =
          await _dbService.getDoctorsByBranchAndHospital(branchId, hospitalId);
      return doctors;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<List<AppointmentModel>> getDoctorAvailability(int doctorId) async {
    try {
      final appointments = await _dbService.getDoctorAvailability(doctorId);
      return appointments;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Future<dynamic> confirmAppointment() async {
    try {
      if (selectedDoctorId.value == null || selectedDate == null) {
        Get.rawSnackbar(
          message: "Lütfen randevu bilgilerini kontrol ediniz.",
        );
        return null;
      }

      await _dbService.createAppointment(
        AppointmentModel(
          patientId: _authController.user!.userId!,
          doctorId: selectedDoctorId.value!,
          branchId: selectedBranchId.value,
          hospitalId: selectedHospitalId.value,
          date: selectedDate!,
          isCancelled: false,
          time:
              TimeOfDay(hour: selectedDate!.hour, minute: selectedDate!.minute),
          durationInMinutes: 60,
        ),
      );
      return true;
    } catch (e) {
      printE(e);
      return null;
    }
  }

  Future<List<AppointmentModel>> getAppointmentOfUser() async {
    try {
      appointments.value = await _dbService.getAppointmentHistory(
          userId: _authController.user!.userId!, isDoctor: false);
      return appointments;
    } catch (e) {
      printE(e);
      return [];
    }
  }

  Stream getAppointmentStream() {
    return _dbService.listenToAppointmentHistory(
      userId: _authController.user!.userId!,
      isDoctor: false,
    );
  }

  Future<void> cancelAppointment(int appointmentId) async {
    try {
      await _dbService.cancelAppointment(appointmentId);
    } catch (e) {
      printE(e);
    }
  }
}
