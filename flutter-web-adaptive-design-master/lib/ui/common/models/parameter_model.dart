import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

ParameterModel parameterModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return ParameterModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

/*List<ParameterModel> parameterModelListFromJson(String str) =>
    List<ParameterModel>.from(
        json.decode(str).map((x) => ParameterModel.fromJson(x)));*/

List<ParameterModel> parameterModelListFromJson(String str) =>
    List<ParameterModel>.from(
        json.decode(str).map((x) => ParameterModel.fromJson(x)));

/*List<ParameterModel> parameterModelListFromJson(String str) {
  log("bly " + str);
  print(str);
  //json.decode(utf8.decode(data.bodyBytes));
  var param = json.decode(str).map((x) => ParameterModel.fromJson(x));
  return List<ParameterModel>.from(param);
}*/

/*List<ParameterModel> parameterModelListFromJson(String str) {
  log("bly " + str);
  print(str);
  //json.decode(utf8.decode(data.bodyBytes));
  var param =
      json.decode(jsonEncode(str)).map((x) => ParameterModel.fromJson(x));
  return List<ParameterModel>.from(param);
}*/

String parameterModelToJson(ParameterModel data) => json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ParameterModel {
  ParameterModel({
    required this.id,
    required this.dataType,
    required this.name,
    required this.description,
    required this.moduleId,
    required this.value,
  });

  /*UserModel(Map<String, String> userData) {
    username = userData['username'].toString();
    firstname = userData['firstname'].toString();
    lastname = userData['lastname'].toString();
    fathername = userData['fathername'].toString();
    email = userData['email'].toString();
    password = userData['password'].toString();
    roleId = userData['roleId'].toString();
    birthday = userData['birthday'].toString();
    sex = userData['sex'].toString();
  }*/

  String id;
  String dataType;
  String name;
  String description;
  String moduleId;
  String value;

  factory ParameterModel.fromJson(Map<String, dynamic> json) {
    return ParameterModel(
      id: json["id"],
      dataType: json["dataType"],
      name: json["name"],
      description: json["description"],
      moduleId: json["moduleId"],
      value: json["value"],
    );
  }

  Map<String, String> toJson() => {
        "id": id,
        "dataType": dataType,
        "name": name,
        "description": description,
        "moduleId": moduleId,
        "value": value,
      };

  /* Map<String, String> getData() => {
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "birthday": birthday,
        //"birthday": birthday.toString(),
        "sex": sex,
        //"fathername": fathername,
      };*/
}
