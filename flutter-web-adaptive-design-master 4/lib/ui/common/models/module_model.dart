import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

import 'parameter_model.dart';

ModuleModel moduleModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return ModuleModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

/*List<ModuleModel> moduleModelListFromJson(String str) => List<ModuleModel>.from(
    json.decode(str).map((x) => ModuleModel.fromJson(x)));*/

List<ModuleModel> moduleModelListFromJson(String str) => List<ModuleModel>.from(
    json.decode(str).map((x) => ModuleModel.fromJson(x)));

/*List<ModuleModel> moduleModelListFromJson(String str) => List<ModuleModel>.from(
    jsonDecode(jsonEncode(str)).map((x) => ModuleModel.fromJson(x)));*/

String moduleModelToJson(ModuleModel data) => json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModuleModel {
  ModuleModel({
    required this.id,
    required this.name,
    required this.frequency,
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
  List<ParameterModel> parameterList;

  factory ModuleModel.fromJson(Map<String, dynamic> json) {
    //print(parameterModelListFromJson(json["parameterList"]));
    return ModuleModel(
        id: json["id"],
        name: json["name"],
        frequency: json["frequency"],
        parameterList:
            parameterModelListFromJson(jsonEncode(json["parameterList"])));
  }

  String parametersToString() {
    String str = "";
    for (var i = 0; i < parameterList.length; i++) {
      if (parameterList[i].name != "Стул") {
        str += parameterList[i].name;
        if (i != parameterList.length - 1) {
          str += ", ";
        }
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
