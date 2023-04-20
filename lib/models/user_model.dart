class User {
  int? userId;
  String? userUid;
  String? nationalId;
  String? mail;
  String? name;
  String? phone;
  String? address;
  int? age;
  bool? gender;
  int? roleId;
  String? roleName;

  User({
    this.userId,
    this.userUid,
    this.nationalId,
    this.name,
    this.mail,
    this.phone,
    this.address,
    this.age,
    this.gender,
    this.roleId,
    this.roleName,
  });

  // generate from map method
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'],
      userUid: map['user_uid'],
      nationalId: map['national_id'],
      name: map['name'],
      mail: map['mail'],
      phone: map['phone'],
      address: map['address'],
      age: map['age'],
      gender: map['gender'],
      roleId: map['role_id'],
      roleName: map['role_name'],
    );
  }

  Map<String, dynamic> toMap() {
    final data = {
      'national_id': nationalId,
      'name': name,
      'mail': mail,
      'phone': phone,
      'address': address,
      'age': age,
      'gender': gender,
    };
    return data;
  }

  //copyWith method
  User copyWith({
    int? userId,
    String? name,
    String? mail,
    String? imageUrl,
    String? phone,
    int? point,
    String? role,
  }) {
    return User(
        userId: userId ?? this.userId,
        userUid: userUid ?? userUid,
        nationalId: nationalId ?? nationalId,
        name: name ?? this.name,
        mail: mail ?? this.mail,
        phone: phone ?? this.phone,
        address: address ?? address,
        age: age,
        gender: gender);
  }
}
