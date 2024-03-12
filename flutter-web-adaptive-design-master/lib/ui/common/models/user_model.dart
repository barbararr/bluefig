import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.fathername,
    required this.email,
    required this.password_hash,
    required this.role_id,
    required this.birthday,
    required this.sex,
  });

  String id;
  String username;
  String firstname;
  String lastname;
  String fathername;
  String email;
  String password_hash;
  String role_id;
  DateTime birthday;
  String sex;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        fathername: json["fathername"],
        email: json["email"],
        password_hash: json["password_hash"],
        role_id: json["role_id"],
        birthday: json["birthday"],
        sex: json["sex"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "fathername": fathername,
        "email": email,
        "password_hash": password_hash,
        "role_id": role_id,
        "birthday": birthday,
        "sex": sex,
      };
}
