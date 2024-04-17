import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'package:adaptive_design/ui/common/models/gastro_label_model.dart';
import 'package:adaptive_design/ui/common/models/module_model.dart';
import 'package:adaptive_design/ui/common/models/module_with_parameters.dart';
import 'package:adaptive_design/ui/common/models/notification_model.dart';
import 'package:adaptive_design/ui/common/models/recomendation_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../common/models/user_model.dart';
import 'api_constants.dart';
import '../../../common/globals.dart' as globals;

class ApiDataProvider {
  Future<UserModel> getUser(String id) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.usersEndpoint + '/' + id);
      //"/b6a141f0-b4bb-11ee-8c0c-00f5f80cf8ae");
      var response = await http.get(url);
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        log("bruh1");
        String source = utf8.decode(response.bodyBytes);
        UserModel _model = userModelFromJson(source);
        log("bruh");
        return _model;
      }
    } catch (e) {
      log(e.toString());
    }
    UserModel userModel = UserModel(
        id: '2',
        username: '2',
        firstname: '2',
        lastname: '2',
        fathername: '2',
        email: '2',
        password: '2',
        roleId: '2',
        // birthday: DateTime.now(),
        birthday: '2222-2-2',
        sex: '2');
    return userModel;
  }

  //Future<UserModel?> createUser() async {
  Future<bool> createUser(UserModel userModel) async {
    try {
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
      var formatter = new DateFormat('yyyy-MM-dd');

      /*UserModel userModel = UserModel(
          //id: '2',
          username: '2',
          firstname: '2',
          lastname: '2',
          fathername: '2',
          email: '2',
          password: '2',
          roleId: '49e6f33b-b4bb-11ee-8c0c-00f5f80cf8ae',
          birthday: DateTime(2024, 3, 13),
          sex: '2');*/

      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.usersEndpoint);

      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: userModelToJson(userModel)
          //"{\"id\": \"2\", \"username\": \"2\", \"firstname\": \"2\", \"lastname\": \"2\", \"fathername\": \"2\", \"email\": \"2\", \"passwordHash\": \"2\", \"roleId\": \"49e6f33b-b4bb-11ee-8c0c-00f5f80cf8ae\", \"birthday\": \"2024-03-13 00:00:00.000\", \"sex\": \"2\"}",
          );
      log(userModel.toJson().toString());
      print(userModel.toJson().toString());
      log(response.statusCode.toString() + "\n");
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<UserModel?> login(String login, String password) async {
    try {
      Map<String, String> data = {
        "\"username\"": "\"$login\"",
        "\"password\"": "\"$password\"",
      };
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndpoint);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data.toString());
      print(data.toString());
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        UserModel _model = userModelFromJson(source);
        globals.user = _model;
        print(_model.id.toString());
        print(globals.user?.id.toString());
        globals.logedIn = true;
        return _model;
      } else {
        globals.user = null;
        return null;
      }
    } catch (e) {
      log(e.toString());
      globals.user = null;
      return null;
    }
  }

  Future<List<UserModel>> getPatientsDoctor(String doctorId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.getPatientsDoctorEndpoint +
          doctorId);
      var response = await http.get(url);
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<UserModel> patients = userModelListFromJson(source);
        return patients;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  Future<List<ModuleModel>> getAllModules() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getAllModulesEndpoint);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        log("slovo");
        String source = utf8.decode(response.bodyBytes);
        print(source);
        List<ModuleModel> modules = moduleModelListFromJson(source);
        return modules;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString() + "nen");
      //return null;
      throw Exception();
    }
  }

  void giveModuleToPatient(
      String patientId, String doctorId, String moduleId, int frequency) async {
    try {
      Map<String, Object> data = {
        "\"patientId\"": "\"$patientId\"",
        "\"doctorId\"": "\"$doctorId\"",
        "\"moduleId\"": "\"$moduleId\"",
        "\"frequency\"": frequency,
      };
      print(data.toString());
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.giveModulesToPatient);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data.toString());
      print(data.toString());
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ModuleModel>> getPatientModules(String patientId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getPatientModules + patientId);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        log("slovo");
        String source = utf8.decode(response.bodyBytes);
        print(source);
        List<ModuleModel> modules = moduleModelListFromJson(source);
        return modules;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString() + "nen");
      //return null;
      throw Exception();
    }
  }

  Future<List<GastroLabelModel>> getGastroLables(String id) async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.getGastroLables + id);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        print(source);
        List<GastroLabelModel> lables = gastroLabelModelListFromJson(source);
        return lables;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString() + "nen");
      //return null;
      throw Exception();
    }
  }

  Future<List<NotificationModel>> getNotifications(String userId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getNotifications + userId);
      var response = await http.get(url);
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<NotificationModel> patients =
            notificationModelListFromJson(source);
        return patients;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  Future<List<UserModel>> getDoctorsAdmin() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getDoctors);
      var response = await http.get(url);
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<UserModel> patients = userModelListFromJson(source);
        return patients;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  Future<List<UserModel>> getPatientsAdmin() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.getPatients);
      var response = await http.get(url);
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<UserModel> patients = userModelListFromJson(source);
        return patients;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  void linkPatientDoctor(String patientId, String doctorId) async {
    try {
      Map<String, Object> data = {
        "\"patientId\"": "\"$patientId\"",
        "\"doctorId\"": "\"$doctorId\"",
      };
      print(data.toString());
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.linkPatientDoctor +
          patientId +
          "/" +
          doctorId);
      print(url.toString());
      var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  void sendModuleData(String data) async {
    try {
      print(data.toString());
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.sendModuleData);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data.toString());
      print(data.toString());
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ModuleWithParametersModel>> getLastRecordsPatient(
      String patientId) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl +
          ApiConstants.getLastRecordsPatient +
          patientId);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      log(response.statusCode.toString() + "\n");
      print(response.body.toString());
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<ModuleWithParametersModel> modules =
            moduleWithParametersModelListFromJson(source);
        return modules;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  Future<List<RecommendationModel>> getRecommendations(String patientId) async {
    try {
      var url = Uri.parse(
          ApiConstants.baseUrl + ApiConstants.getRecommendations + patientId);
      var response = await http.get(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      });
      log(response.statusCode.toString() + "\n");
      print(response.body.toString());
      if (response.statusCode == 200) {
        String source = utf8.decode(response.bodyBytes);
        List<RecommendationModel> recommendations =
            recomendationModelListFromJson(source);
        return recommendations;
      } else {
        //return null;
        throw Exception();
      }
    } catch (e) {
      log(e.toString());
      //return null;
      throw Exception();
    }
  }

  void sendRecommendation(String data) async {
    try {
      print(data.toString());
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.sendRecommendation);
      var response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: data.toString());
      print(data.toString());
      log(response.statusCode.toString() + "\n");
      print(response.body);
      if (response.statusCode == 200) {
      } else {}
    } catch (e) {
      log(e.toString());
    }
  }
}
