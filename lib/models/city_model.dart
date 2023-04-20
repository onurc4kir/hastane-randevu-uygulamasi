class CityModel {
  int? cityId;
  String? name;
  String? description;

  CityModel({this.cityId, this.name, this.description});

  CityModel.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    name = json['name'];
    description = json['description'];
  }
}
