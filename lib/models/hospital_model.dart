class HospitalModel {
  int? id;
  String? name;
  String? description;
  int? cityId;

  HospitalModel({this.id, this.name, this.description, this.cityId});

  HospitalModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    cityId = json['city_id'];
  }
}
