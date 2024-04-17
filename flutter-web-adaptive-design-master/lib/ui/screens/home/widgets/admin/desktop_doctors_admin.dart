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

class DesktopDoctorsListPageAdmin extends StatefulWidget {
  const DesktopDoctorsListPageAdmin({Key? key}) : super(key: key);

  @override
  State<DesktopDoctorsListPageAdmin> createState() =>
      _DesktopDoctorsListPageAdminState();
}

class _DesktopDoctorsListPageAdminState
    extends State<DesktopDoctorsListPageAdmin> {
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

  void doctorIdProfile(int index) {
    globals.currentDoctorID = doctors[index].id;
    // go to patients profile with this id
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => (DesktopMainDoctorPageAdmin())));
  }

  String getDoctorsName(int index) {
    return doctors[index].lastname +
        " " +
        doctors[index].firstname +
        " " +
        doctors[index].fathername;
  }

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
                        'Добавить',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => (Registration()))),
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
                  onTap: () => {doctorIdProfile(index)},
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
