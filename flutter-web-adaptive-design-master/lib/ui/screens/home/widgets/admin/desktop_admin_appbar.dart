import 'package:flutter/material.dart';
import '../../../../common/app_colors.dart';
import '../patient/desktop_notification_page_patient.dart';
import '../patient/desktop_replies_page.dart';
import '../log_in_page.dart';
import '../modules_patient_expansion_tile.dart';
import '../../../../common/globals.dart' as globals;
import 'desktop_doctors_admin.dart';
import 'desktop_patients_admin.dart';

class AdminAppbar extends StatefulWidget implements PreferredSizeWidget {
  const AdminAppbar({Key? key}) : super(key: key);

  @override
  State<AdminAppbar> createState() => _AdminAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}

class _AdminAppbarState extends State<AdminAppbar> {
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
    );
  }
}
