class UserModel {
  int? avatar;
  String? name;
  String? email;
  String? id;
  String? phone;

  UserModel({
    required this.avatar,
    required this.name,
    required this.email,
    required this.id,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      avatar: json["avatar"] ?? 0,
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "avatar": avatar ?? 0,
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}