import 'package:adaptive_design/ui/screens/home/widgets/patient/desktop_main_patient.dart';
import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';
import 'desktop_notification_page_patient.dart';
import '../doctor/desktop_patient_doctor.dart';
import '../doctor/desktop_patients_list_doctor.dart';
import 'desktop_replies_page.dart';
import '../log_in_page.dart';
import '../modules_patient_expansion_tile.dart';
import '../../../../common/globals.dart' as globals;

class PatientAppbar extends StatefulWidget implements PreferredSizeWidget {
  const PatientAppbar({Key? key}) : super(key: key);

  @override
  State<PatientAppbar> createState() => _PatientAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _PatientAppbarState extends State<PatientAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              'Данные',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (DesktopMainPatientPagePatient())));
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
                  builder: (context) => (DesktopNotificationPagePatient())));
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
              'Ответы',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => (DesktopRepliesPage())));
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
    );
  }
}
