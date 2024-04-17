import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

import 'parameter_model.dart';

ModuleWithParametersModel moduleWithParametersModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return ModuleWithParametersModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

/*List<ModuleModel> moduleModelListFromJson(String str) => List<ModuleModel>.from(
    json.decode(str).map((x) => ModuleModel.fromJson(x)));*/

List<ModuleWithParametersModel> moduleWithParametersModelListFromJson(
        String str) =>
    List<ModuleWithParametersModel>.from(
        json.decode(str).map((x) => ModuleWithParametersModel.fromJson(x)));

/*List<ModuleModel> moduleModelListFromJson(String str) => List<ModuleModel>.from(
    jsonDecode(jsonEncode(str)).map((x) => ModuleModel.fromJson(x)));*/

String moduleWithParametersModelToJson(ModuleWithParametersModel data) =>
    json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleWithParametersModel {
  ModuleWithParametersModel({
    required this.id,
    required this.name,
    required this.frequency,
    required this.dateTime,
    required this.parameterList,
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
  String name;
  int frequency;
  String dateTime;
  List<ParameterModel> parameterList;

  factory ModuleWithParametersModel.fromJson(Map<String, dynamic> json) {
    //print(parameterModelListFromJson(json["parameterList"]));
    return ModuleWithParametersModel(
        id: json["id"],
        name: json["name"],
        frequency: json["frequency"],
        dateTime: json["dateTime"],
        parameterList:
            parameterModelListFromJson(jsonEncode(json["parameterList"])));
  }

  String parametersToString() {
    String str = "";
    for (var i = 0; i < parameterList.length; i++) {
      str += parameterList[i].name;
      if (i != parameterList.length - 1) {
        str += ", ";
      }
    }
    return str;
  }

  Map<String, String> toJson() => {
        "id": id,
        "name": name,
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
