import 'dart:convert';

import 'dart:developer';

import 'package:intl/intl.dart';

ProductModel productModelFromJson(String str) {
  log("str " + str);
  final user = jsonDecode(str) as Map<String, dynamic>;

  // return user.map((x) => UserModel.fromJson(x))
  return ProductModel.fromJson(user);
  //return jsonDecode(str).map((x) => UserModel.fromJson(x));
}

/*List<ParameterModel> parameterModelListFromJson(String str) =>
    List<ParameterModel>.from(
        json.decode(str).map((x) => ParameterModel.fromJson(x)));*/

List<ProductModel> productModelListFromJson(String str) =>
    List<ProductModel>.from(
        json.decode(str).map((x) => ProductModel.fromJson(x)));

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

String productModelToJson(ProductModel data) => json.encode(data.toJson());
//json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  ProductModel({
    required this.id,
    required this.name,
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
  List<String> products = [];

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json["id"],
      name: json["name"],
    );
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
