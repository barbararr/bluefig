import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_main_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_patient_appbar.dart';
import 'package:adaptive_design/ui/screens/home/widgets/doctor/desktop_patients_list_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/last_records_expansion_tile.dart';
import 'package:adaptive_design/ui/screens/home/widgets/modules_expansion_tile.dart';
import 'package:adaptive_design/ui/screens/home/widgets/replies_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../common/app_colors.dart';
import 'desktop_notification_page_patient.dart';
import '../doctor/desktop_patient_doctor.dart';
import 'desktop_replies_page.dart';
import '../log_in_page.dart';
import '../modules_patient_expansion_tile.dart';
import '../../../../common/globals.dart' as globals;

class DesktopModulesPagePatient extends StatefulWidget {
  const DesktopModulesPagePatient({Key? key}) : super(key: key);

  @override
  State<DesktopModulesPagePatient> createState() =>
      _DesktopModulesPagePatientState();
}

class _DesktopModulesPagePatientState extends State<DesktopModulesPagePatient> {
  List<String> categories = ['к пациенту'];
  List<String> elementsEnterPatient = [
    'ФИО',
    'Дата рождения',
    'Пол',
    'Вес',
    'Рост'
  ];
  List<String> elementsEnterDoctor = ['Email', 'Password', 'Name'];
  String selectedCategory = '';
  List<String> listOfElements = [];

  Map userData = {};
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PatientAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
              child: Row(children: [
                Container(
                  child: RaisedButton.icon(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    label: Text(
                      'на главную',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                ((DesktopMainPatientPagePatient())))),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    color: firstColor,
                  ),
                  width: MediaQuery.of(context).size.width / 5,
                  height: 25,
                ),
              ]),
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
                            Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ModulesPatientExpansionTile()),
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
