import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

DoctorParameterModel doctorParameterModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return DoctorParameterModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

/*List<ParameterModel> parameterModelListFromJson(String str) =>
    List<ParameterModel>.from(
        json.decode(str).map((x) => ParameterModel.fromJson(x)));*/

List<DoctorParameterModel> doctorParameterModelListFromJson(String str) =>
    List<DoctorParameterModel>.from(
        json.decode(str).map((x) => DoctorParameterModel.fromJson(x)));

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

String doctorParameterModelToJson(DoctorParameterModel data) =>
    json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DoctorParameterModel {
  DoctorParameterModel({
    required this.id,
    required this.dataType,
    required this.name,
    required this.moduleId,
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
  String moduleId;
  String value = "";
  List<String> options = [];
  List<String> selectedOptions = [];
  bool isChecked = false;

  factory DoctorParameterModel.fromJson(Map<String, dynamic> json) {
    return DoctorParameterModel(
      id: json["id"],
      dataType: json["dataType"],
      name: json["name"],
      moduleId: json["moduleId"],
    );
  }

  Map<String, String> toJson() => {
        "id": id,
        "dataType": dataType,
        "name": name,
        "moduleId": moduleId,
      };
}
