import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/notification_list.dart';
import 'package:adaptive_design/ui/screens/home/widgets/admin/desktop_admin_appbar.dart';
import 'package:adaptive_design/ui/screens/home/widgets/admin/desktop_doctor_main_admin.dart';
import 'package:adaptive_design/ui/screens/home/widgets/doctor/desktop_notification_page_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/admin/desktop_patients_admin.dart';
import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_replies_page.dart';
import 'package:adaptive_design/ui/screens/home/widgets/admin/desktop_user_registration.dart';
import 'package:flutter/material.dart';

import '../../../../common/models/user_model.dart';
import '../api_data_provider.dart';
import '../../../../common/globals.dart' as globals;
import '../log_in_page.dart';

class DesktopAddDoctorToPatient extends StatefulWidget {
  const DesktopAddDoctorToPatient({Key? key}) : super(key: key);

  @override
  State<DesktopAddDoctorToPatient> createState() =>
      _DesktopAddDoctorToPatientState();
}

class _DesktopAddDoctorToPatientState extends State<DesktopAddDoctorToPatient> {
  List<UserModel> doctors = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    doctors = await ApiDataProvider().getDoctorsAdmin();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  Future<void> linkDoctorToPatient(int index) async {
    // go to patients profile with this id

    if (!(await ApiDataProvider()
        .linkPatientDoctor(globals.currentPatientID, doctors[index].id)))
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Ошибка! Проверьте корректность введенных значений!'),
        backgroundColor: Colors.red,
      ));
  }

  String getDoctorsName(int index) {
    return doctors[index].lastname +
        " " +
        doctors[index].firstname +
        " " +
        doctors[index].fathername;
  }

  Color color = fourthColor;
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AdminAppbar(),
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
                      'Доктора',
                      style: TextStyle(color: firstColor, fontSize: 22),
                    ),
                    width: MediaQuery.of(context).size.width / 3,
                    height: 30,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Container(
                    child: RaisedButton(
                      child: Text(
                        'Прикрепить',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () => {
                        linkDoctorToPatient(selectedIndex!),
                        setState(() {
                          selectedIndex = -1;
                        }),
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(milliseconds: 600),
                            content: Text('Доктор прикреплен')))
                      },
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
            ListView.builder(
              shrinkWrap: true,
              itemCount: doctors.length,
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
                            color: selectedIndex == index ? thirdColor : null,
                            child: Center(
                              child: Text(getDoctorsName(index),
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.6)),
                                  textAlign: TextAlign.justify),
                            ),
                          ),
                        ),
                      ),
                    )
                  ]),
                  onTap: () => {
                    setState(() {
                      selectedIndex = index;
                    })
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
