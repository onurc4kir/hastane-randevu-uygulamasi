abstract class AppConstants {
  static const baseUrl = "https://eschedule.org";
  static const apiUrl = "https://eschedule.vercel.app/api/";
  static const localApiUrl = "http://localhost:3000/api/";
  static const supportEmail = "support@ucuzunubul.com";
  static const appVersion = "1.0.0";
  static const appName = "eSchedule";
  static const appDescription =
      "eSchedule is a simple app to manage your schedule";
  static const tokenString = "token";
}

abstract class DatabaseContants {
  static const String appointmentHistoryView = "appointment_history_view";
  static const String appointmentTable = "appointment";
  static const String profilesTable = "user";
  static const String cityTable = "city";
  static const String hospitalTable = "hospital";
  static const String branchTable = "branch";
  static const String profileView = "profile";
  static const String notificationsTable = "notification";
  static const String doctorView = "doctor_view";
}
