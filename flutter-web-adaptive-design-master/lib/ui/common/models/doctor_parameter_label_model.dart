import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

DoctorParameterLabelModel doctorParameterLabelModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return DoctorParameterLabelModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

List<DoctorParameterLabelModel> doctorParameterLabelModelListFromJson(
        String str) =>
    List<DoctorParameterLabelModel>.from(
        json.decode(str).map((x) => DoctorParameterLabelModel.fromJson(x)));

String doctorParameterLabelModelToJson(DoctorParameterLabelModel data) =>
    json.encode(data.toJson());

class DoctorParameterLabelModel {
  DoctorParameterLabelModel({
    required this.id,
    required this.name,
    required this.parameterId,
  });

  String id;
  String name;
  String parameterId;

  factory DoctorParameterLabelModel.fromJson(Map<String, dynamic> json) {
    return DoctorParameterLabelModel(
      id: json["id"],
      name: json["name"],
      parameterId: json["parameterId"],
    );
  }

  Map<String, String> toJson() => {
        "id": id,
        "name": name,
        "parameterId": parameterId,
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