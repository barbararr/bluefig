import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/last_records_expansion_tile.dart';
import 'package:adaptive_design/ui/screens/home/widgets/modules_expansion_tile.dart';
import 'package:adaptive_design/ui/screens/home/widgets/replies_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import 'desktop_notification_page_patient.dart';
import 'desktop_patient_doctor.dart';
import 'desktop_replies_page.dart';
import 'log_in_page.dart';
import 'modules_patient_expansion_tile.dart';
import '../../../common/globals.dart' as globals;

class DesktopModulesPageDoctor extends StatefulWidget {
  const DesktopModulesPageDoctor({Key? key}) : super(key: key);

  @override
  State<DesktopModulesPageDoctor> createState() =>
      _DesktopModulesPageDoctorState();
}

class _DesktopModulesPageDoctorState extends State<DesktopModulesPageDoctor> {
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
              onPressed: () {},
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
                'Уведомления',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (DesktopNotificationPagePatient())));
              },
              color: thirdColor,
            ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 0),
              child: Row(
                  children: /*categories
                    .map((category) => ChoiceChip(
                        avatar: Icon(Icons.arrow_back),
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedCategory = category;
                            } else {
                              selectedCategory = '';
                            }

                          });
                        }))
                    .toList(),*/
                      [
                    Container(
                      child: RaisedButton.icon(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        label: Text(
                          'к пациенту',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    ((DesktopMainPatientPageDoctor())))),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        color: firstColor,
                      ),
                      width: MediaQuery.of(context).size.width / 5,
                      height: 30,
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
                            // Here add the widget you created for the single item...
                            // e.g.
                            Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ModulesExpansionTile()),
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