import 'dart:html';

import 'package:adaptive_design/ui/screens/home/widgets/desktop_add_doctor_to_user.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_doctor_recomendation.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_last_records_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_modules_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/models/user_model.dart';
import 'api_data_provider.dart';
import 'desktop_doctors_admin.dart';
import 'desktop_notification_page_doctor.dart';
import 'desktop_notification_page_patient.dart';
import 'desktop_patients_admin.dart';
import 'desktop_replies_page.dart';

import '../../../common/globals.dart' as globals;
import 'log_in_page.dart';

class DesktopMainPatientPageAdmin extends StatefulWidget {
  const DesktopMainPatientPageAdmin({Key? key}) : super(key: key);

  @override
  State<DesktopMainPatientPageAdmin> createState() =>
      _DesktopMainPatientPageAdminState();
}

class _DesktopMainPatientPageAdminState
    extends State<DesktopMainPatientPageAdmin> {
  List<String> categories = [
    'Данные',
    'Статистика',
    'Последние записи',
    'Назначить модуль',
    'Дать рекомендацию',
  ];

  Map<String, String> patientData = {};

  String selectedCategory = '';

  UserModel patient = UserModel(
      id: '',
      username: "",
      firstname: "",
      lastname: "",
      email: "",
      fathername: "",
      password: "",
      roleId: "",
      birthday: "",
      sex: "");

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    patient = (await ApiDataProvider().getUser(globals.currentPatientID));
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Map<String, String>? getPatientData() {
    return patient.getData();
  }

  List<TextSpan> createListText() {
    patientData = getPatientData()!;
    List<TextSpan> list = [];
    for (var v in patientData.keys) {
      list.add(TextSpan(
          text: v + ':', style: const TextStyle(fontWeight: FontWeight.bold)));
      list.add(const TextSpan(text: " "));
      list.add(TextSpan(text: patientData[v]));
      list.add(const TextSpan(text: "\n\n"));
    }
    return list;
  }

  TextSpan patientDataToString() {
    var text = TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: const TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: createListText());
    //print()
    print(text);
    return text;
  }

  List<Widget> getChoiceChips() {
    return categories
        .map(
          (category) => ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              onSelected: (isSelected) {
                setState(() {
                  if (isSelected) {
                    selectedCategory = category;
                  } else {
                    selectedCategory = '';
                  }
                  if (selectedCategory == 'Назначить модуль') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (DesktopModulesPageDoctor())));
                  }
                  if (selectedCategory == 'Данные') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => (DesktopMainPatientPageAdmin())));
                  }
                  if (selectedCategory == 'Последние записи') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopPatientLastRecordsPageDoctor())));
                  }
                  if (selectedCategory == 'Дать рекомендацию') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopRecomendationPageDoctor())));
                  }
                });
              }),
        )
        .toList();
  }

  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: firstColor,
        title: Text(
          "BlueFig",
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: MaterialButton(
              child: Text(
                'Пациенты',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (DesktopPatientListPageAdmin())));
              },
              color: thirdColor,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            child: MaterialButton(
              child: Text(
                'Доктора',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (DesktopDoctorsListPageAdmin())));
              },
              color: thirdColor,
            ),
          ),
          const SizedBox(
            width: 12.0,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 10.0, 5.0, 10.0),
            child: MaterialButton(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_circle),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            child: MaterialButton(
              child: IconButton(
                onPressed: () {
                  globals.logedIn = false;
                  globals.user = null;
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => (Login())));
                },
                icon: Icon(Icons.logout_rounded),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(
                      child: RaisedButton(
                        child: Text(
                          'Прикрепить к врачу',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () => {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  (DesktopAddDoctorToPatient())))
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: thirdColor,
                      ),
                      width: MediaQuery.of(context).size.width / 5,
                      height: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Container(
                      child: RaisedButton(
                        child: Text(
                          'Редактировать',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        onPressed: () => {},
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: thirdColor,
                      ),
                      width: MediaQuery.of(context).size.width / 5,
                      height: 30,
                    ),
                  ),
                ],
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
                              // Here add the widget you created for the single item...
                              // e.g.
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Card(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RichText(
                                              text: patientDataToString()),
                                        ),
                                      ],
                                    ),
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
      ),
    );
  }
}
