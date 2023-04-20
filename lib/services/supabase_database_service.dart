import 'dart:async';
import 'package:get/get_utils/get_utils.dart';
import 'package:randevu_al/core/helpers/custom_logger.dart';
import 'package:randevu_al/models/appointment_model.dart';
import 'package:randevu_al/models/branch_model.dart';
import 'package:randevu_al/models/city_model.dart';
import 'package:randevu_al/models/doctor_model.dart';
import 'package:randevu_al/models/hospital_model.dart';
import 'package:randevu_al/models/notification_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supa;
import 'package:randevu_al/core/utilities/app_constants.dart';
import '../models/user_model.dart';
import 'package:randevu_al/core/utilities/extensions.dart';

class SupabaseDatabaseService {
  final _database = supa.Supabase.instance.client;

  Future<User?> getProfile({
    required String id,
  }) async {
    try {
      final data = await _database
          .from(DatabaseContants.profileView)
          .select()
          .eq('user_uid', id)
          .maybeSingle();
      if (data != null) {
        return User.fromMap(data);
      } else {
        return null;
      }
    } catch (e) {
      printError(info: "SupabaseDatabaseService GetProfile Error: $e");
      rethrow;
    }
  }

  Future<void> updateProfile(User user) async {
    try {
      await _database
          .from(DatabaseContants.profilesTable)
          .update(user.toMap())
          .eq('id', user.userId);
    } catch (e) {
      printError(info: "SupabaseDatabaseService UpdateProfile Error: $e");
      rethrow;
    }
  }

  Future<void> markProfileCompleted(String id) async {
    try {
      await _database
          .from(DatabaseContants.profilesTable)
          .update({'is_profile_completed': true}).eq('id', id);
    } catch (e) {
      printError(info: "SupabaseDatabaseService UpdateProfile Error: $e");
      rethrow;
    }
  }

  Future<bool?> fillYourProfile({
    required id,
    required String surName,
    required String name,
    required String? countryCode,
  }) async {
    try {
      await _database.from(DatabaseContants.profilesTable).update({
        'full_name': '$name $surName',
        'country_code': countryCode,
        'is_profile_completed': true,
      }).eq('id', id);
      return true;
    } catch (e) {
      printError(info: "SupabaseDatabaseService FillYourProfile Error: $e");
      rethrow;
    }
  }

  Future<void> disableAccount({required String id}) async {
    try {
      await _database
          .from(DatabaseContants.profilesTable)
          .update({'is_active': false}).eq(
        'id',
        id,
      );
    } catch (e) {
      printError(info: "SupabaseDatabaseService DisableAccount Error: $e");
      rethrow;
    }
  }

  Future<List<CityModel>> getCities() async {
    final data = await _database
        .from(DatabaseContants.cityTable)
        .select()
        .order('name', ascending: true);
    if (data != null) {
      printInfo(info: "SupabaseDatabaseService GetCities: $data");
      return data.map((e) => CityModel.fromJson(e)).toList().cast<CityModel>();
    } else {
      return [];
    }
  }

  Future<List<HospitalModel>> getHospitalsByCity(int cityId) {
    return _database
        .from(DatabaseContants.hospitalTable)
        .select()
        .eq('city_id', cityId)
        .order('name', ascending: true)
        .then((value) {
      if (value != null) {
        printInfo(info: "SupabaseDatabaseService GetHospitalByCity: $value");
        return value
            .map((e) => HospitalModel.fromJson(e))
            .toList()
            .cast<HospitalModel>();
      } else {
        return [];
      }
    });
  }

  Future<List<DoctorModel>> getDoctorsByBranchAndHospital(
      int branchId, int hospitalId) {
    printI("Searching doctor for branch: $branchId and hospital: $hospitalId");
    return _database
        .from(DatabaseContants.doctorView)
        .select()
        .eq('branch_id', branchId)
        .eq('hospital_id', hospitalId)
        .order('name', ascending: true)
        .then((value) {
      if (value != null) {
        printInfo(info: "SupabaseDatabaseService GetDoctorsByBranch: $value");
        return value
            .map((e) => DoctorModel.fromJson(e))
            .toList()
            .cast<DoctorModel>();
      } else {
        return [];
      }
    });
  }

  Future<List<BranchModel>> getBranches() {
    return _database
        .from(DatabaseContants.branchTable)
        .select()
        .order('name', ascending: true)
        .then((value) {
      if (value != null) {
        printInfo(
            info: "SupabaseDatabaseService GetBranchesByHospital: $value");
        return value
            .map((e) => BranchModel.fromJson(e))
            .toList()
            .cast<BranchModel>();
      } else {
        return [];
      }
    });
  }

  Future<List<AppointmentModel>> getDoctorAvailability(int doctorId) async {
    final data = await _database
        .from(DatabaseContants.appointmentTable)
        .select()
        .eq('doctor_id', doctorId)
        .gte("date", DateTime.now().formattedDateForQuery)
        .lte("date",
            DateTime.now().add(const Duration(days: 7)).formattedDateForQuery)
        .order('date', ascending: true);
    if (data != null) {
      printInfo(info: "SupabaseDatabaseService GetDoctorAvailability: $data");
      return data
          .map((e) => AppointmentModel.fromJson(e))
          .toList()
          .cast<AppointmentModel>();
    } else {
      return [];
    }
  }

  Future<void> createAppointment(AppointmentModel appointmentModel) async {
    try {
      await _database
          .from(DatabaseContants.appointmentTable)
          .insert(appointmentModel.toMap());
    } catch (e) {
      printError(info: "SupabaseDatabaseService CreateAppointment Error: $e");
      rethrow;
    }
  }

  Stream listenToAppointmentHistory(
      {required int userId, bool isDoctor = false}) {
    return _database
        .from(DatabaseContants.appointmentTable)
        .stream(primaryKey: ['appointment_id']).eq(
            isDoctor ? "doctor_id" : "patient_id", userId);
  }

  Future<List<AppointmentModel>> getAppointmentHistory(
      {required int userId, bool isDoctor = false}) {
    return _database
        .from(DatabaseContants.appointmentHistoryView)
        .select()
        .eq(isDoctor ? 'doctor_id' : 'patient_id', userId)
        .order('date', ascending: false)
        .then((value) {
      if (value != null) {
        printW(value);
        printInfo(
            info: "SupabaseDatabaseService GetAppointmentHistory: $value");
        return value
            .map((e) => AppointmentModel.fromJson(e))
            .toList()
            .cast<AppointmentModel>();
      } else {
        return [];
      }
    });
  }

  Future<void> cancelAppointment(int appointmentId) async {
    try {
      await _database
          .from(DatabaseContants.appointmentTable)
          .update({'is_cancelled': true}).eq('appointment_id', appointmentId);
    } catch (e) {
      printError(info: "SupabaseDatabaseService CancelAppointment Error: $e");
      rethrow;
    }
  }

  Stream listenUserNotifications(int userId) {
    return _database
        .from(DatabaseContants.notificationsTable)
        .stream(primaryKey: ['id']).eq('user_id', userId);
  }

  Future<List<NotificationModel>> getUserNotifications(int userId) async {
    final data = await _database
        .from(DatabaseContants.notificationsTable)
        .select()
        .eq('user_id', userId)
        .order('created_at', ascending: false);
    if (data != null) {
      printInfo(info: "SupabaseDatabaseService GetUserNotifications: $data");
      return data
          .map((e) => NotificationModel.fromMap(e))
          .toList()
          .cast<NotificationModel>();
    } else {
      return [];
    }
  }
}
