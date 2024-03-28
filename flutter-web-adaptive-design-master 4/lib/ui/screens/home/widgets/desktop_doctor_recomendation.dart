import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/last_records_expansion_tile.dart';
import 'package:adaptive_design/ui/screens/home/widgets/replies_expansion_tile.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import 'desktop_last_records_doctor.dart';
import 'desktop_modules_doctor.dart';
import 'desktop_notification_page_doctor.dart';
import 'desktop_notification_page_patient.dart';
import 'desktop_patient_doctor.dart';
import 'desktop_replies_page.dart';
import 'log_in_page.dart';
import '../../../common/globals.dart' as globals;

class DesktopRecomendationPageDoctor extends StatefulWidget {
  const DesktopRecomendationPageDoctor({Key? key}) : super(key: key);

  @override
  State<DesktopRecomendationPageDoctor> createState() =>
      _DesktopRecomendationPageDoctorState();
}

class _DesktopRecomendationPageDoctorState
    extends State<DesktopRecomendationPageDoctor> {
  List<String> categories = [
    'Данные',
    'Статистика',
    'Последние записи',
    'Назначить модуль',
    'Дать рекомендацию',
  ];
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
                        builder: (context) =>
                            (DesktopMainPatientPageDoctor())));
                  }
                  if (selectedCategory == 'Последние записи') {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            (DesktopPatientLastRecordsPageDoctor())));
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
                    builder: (context) => (DesktopPatientListPageDoctor())));
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
                'Уведомления',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (DesktopNotificationPageDoctor())));
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              width: 60,
              height: 60,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: 
                    getChoiceChips()),
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
                                child: TextFormField(
                                  minLines: 1,
                                  maxLines: 20,
                                  cursorColor: secondColor,
                                  decoration: InputDecoration(
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: fourthColor,
                                        width: 1.0,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: secondColor),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(9.0))),
                                  ),
                                )),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                  child: RaisedButton(
                                    child: Text(
                                      'отправить',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    onPressed: () => {
                                      globals.addNewRecomendation = true,
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ((DesktopMainPatientPageDoctor()))))
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    color: firstColor,
                                  ),
                                  width: MediaQuery.of(context).size.width / 5,
                                  height: 25,
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
