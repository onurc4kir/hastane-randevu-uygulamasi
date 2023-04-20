class DoctorModel {
  int? userId;
  String? name;
  String? title;
  bool? gender;

  DoctorModel({
    this.userId,
    this.name,
    this.title,
    this.gender,
  });

  DoctorModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    title = json['title'];
    gender = json['gender'];
  }
}
