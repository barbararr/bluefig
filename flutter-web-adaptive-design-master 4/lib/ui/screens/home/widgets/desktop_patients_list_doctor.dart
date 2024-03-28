import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/models/user_model.dart';
import 'package:adaptive_design/ui/common/notification_list.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_notification_page_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patient_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_replies_page.dart';
import 'package:flutter/material.dart';

import 'api_data_provider.dart';
import '../../../common/globals.dart' as globals;
import 'log_in_page.dart';

class DesktopPatientListPageDoctor extends StatefulWidget {
  const DesktopPatientListPageDoctor({Key? key}) : super(key: key);

  @override
  State<DesktopPatientListPageDoctor> createState() =>
      _DesktopPatientListPageDoctorState();
}

class _DesktopPatientListPageDoctorState
    extends State<DesktopPatientListPageDoctor> {
  List<UserModel> patients = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    patients = await ApiDataProvider().getPatientsDoctor(globals.user!.id);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void patientIdProfile(int index) {
    globals.currentPatientID = patients[index].id;
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => (DesktopMainPatientPageDoctor())));
  }

  String getPatientsName(int index) {
    return patients[index].lastname +
        " " +
        patients[index].firstname +
        " " +
        patients[index].fathername;
  }

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    child: Text(
                      'Пациенты',
                      style: TextStyle(color: firstColor, fontSize: 22),
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: 30,
                  ),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: patients.length,
              itemBuilder: (ctx, index) {
                return GestureDetector(
                  child: Row(children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.2),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: 50,
                          child: Card(
                            child: Center(
                              child: Text(getPatientsName(index),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                  textAlign: TextAlign.justify),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  onTap: () => patientIdProfile(index),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
