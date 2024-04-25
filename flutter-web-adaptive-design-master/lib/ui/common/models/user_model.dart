import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

UserModel userModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return UserModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

List<UserModel> userModelListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(UserModel data) => json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.fathername,
    required this.email,
    required this.password,
    required this.roleId,
    required this.birthday,
    required this.sex,
  });

  String id = "";
  String username;
  String firstname;
  String lastname;
  String email;
  String birthday;
  String sex;
  String password;
  String fathername;
  String roleId;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    return UserModel(
      id: json["id"],
      username: json["username"],
      firstname: json["firstname"],
      lastname: json["lastname"],
      fathername: json["fathername"],
      email: json["email"],
      password: json["passwordHash"],
      roleId: json["roleId"],
      birthday: json["birthday"],
      sex: json["sex"],
    );
  }

  Map<String, String> toJson() => {
        "id": id,
        "username": username,
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "birthday": birthday,
        //"birthday": birthday.toString(),
        "sex": sex,
        "passwordHash": password,
        "fathername": fathername,
        "roleId": roleId,
      };

  Map<String, String> getData() => {
        "имя": firstname,
        "фамилия": lastname,
        "отчество": fathername,
        "почта": email,
        "дата рождения": birthday,
        //"birthday": birthday.toString(),
        "пол": sex,
      };
}
