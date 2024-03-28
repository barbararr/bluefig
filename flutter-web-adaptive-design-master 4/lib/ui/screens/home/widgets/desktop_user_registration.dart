import 'package:adaptive_design/ui/common/models/users_model_ex.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_main_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../common/app_colors.dart';
import 'desktop_replies_page.dart';
import 'dart:developer';
import '../../../common/models/user_model.dart';
import 'api_data_provider.dart';
import 'date_formatter.dart';
import '../../../common/globals.dart' as globals;

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List<String> categories = ['Доктор', 'Пациент'];
  List<String> elementsEnterPatient = [
    'username',
    'firstname',
    'lastname',
    'email',
    'birthday',
    'sex',
    'password',
    'fathername',
  ];

  List<String> elementsEnterDoctor = [
    'username',
    'firstname',
    'lastname',
    'email',
    'birthday',
    'sex',
    'password',
    'fathername',
  ];

  String selectedCategory = '';

  List<String> listOfElements = [];

  Map<String, String> userData = {
    'username': '',
    'firstname': '',
    'lastname': '',
    'email': '',
    'birthday': '',
    'sex': '',
    'password': '',
    'fathername': '',
    'roleId': '',
  };
  final _formkey = GlobalKey<FormState>();

  void registerUser() {
    UserModel userModel = UserModel(
        id: "",
        username: userData['username'].toString(),
        firstname: userData['firstname'].toString(),
        lastname: userData['lastname'].toString(),
        fathername: userData['fathername'].toString(),
        email: userData['email'].toString(),
        password: userData['password'].toString(),
        roleId: userData['roleId'].toString(),
        birthday: userData['birthday'].toString(),
        //birthday: DateTime(2022, 2, 2),
        sex: userData['sex'].toString());
    bool completed = ApiDataProvider().createUser(userModel) as bool;
    if (completed == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Check the correctness of input data!'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (globals.user?.roleId == globals.doctorRoleId) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ((DesktopPatientListPageDoctor()))));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ((DesktopMainPatientPagePatient()))));
      }
    }
  }

  RegExp regExp = new RegExp(
    r"^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$",
    
    caseSensitive: true,
    multiLine: false,
  );


  var _controller = TextEditingController();

  // dispose it when the widget is unmounted
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String validate(String? value, String element) {
    String valid = "";
    if (value == null || value.isEmpty) {
      valid = 'please enter some text';
    } else if (element == "email" &&
        !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(value)) {
      valid = "please enter a valid email";
    } else if (element == "birthday" &&
        (value.length < 10 || !RegExp(r'^[0-9-]+$').hasMatch(value))) {
      valid = "please enter a valid birthday: yyyy-mm-dd";
    } else if (element == "sex" && (value != "female" && value != "male")) {
      valid = "please enter a valid sex: female/male";
    }
    return valid;
  }

  void showError(String error) {
    if (error != "") {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 1),
      ));
    }
  }


  bool isValid = true;
  String errorMessage = "";

  String currentValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text('Регистрация'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: categories
                  .map((category) => ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedCategory = category;
                              if (selectedCategory == 'Доктор') {
                                userData['roleId'] = globals.doctorRoleId;
                                listOfElements =
                                    List<String>.from(elementsEnterDoctor);
                              } else {
                                userData['roleId'] = globals.patientRoleId;
                                listOfElements =
                                    List<String>.from(elementsEnterPatient);
                              }
                            } else {
                              selectedCategory = '';
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
                      key: _formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int i = 0; i < listOfElements.length; i++)
                              // Here add the widget you created for the single item...
                              // e.g.
                              Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                      inputFormatters:
                                          listOfElements[i] == "birthday"
                                              ? [DateTextFormatter()]
                                              : [],
                                      onChanged: (value) {
                                        setState(() {
                                          errorMessage = "";
                                          errorMessage = validate(
                                              value, listOfElements[i]);
                                          isValid =
                                              errorMessage == "" ? true : false;
                                          userData[listOfElements[i]] = value;
                                          if (errorMessage != "") {
                                            showError(errorMessage);
                                          }
                                        });
                                      },

                                      cursorColor: secondColor,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: secondColor,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText: listOfElements[i],
                                        labelText: listOfElements[i],
                                        hintStyle: TextStyle(
                                            fontSize: 16.0, color: secondColor),
                                        labelStyle: TextStyle(
                                            fontSize: 16.0, color: secondColor),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: secondColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9.0))),
                                      ))),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Container(
                                  child: RaisedButton(
                                    child: Text(
                                      'Зарегистрировать',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    onPressed: () {
                                      log(userData.toString());
                                      registerUser();
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    color: firstColor,
                                  ),
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50,
                                ),
                              ),
                            ),
                          ]),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
