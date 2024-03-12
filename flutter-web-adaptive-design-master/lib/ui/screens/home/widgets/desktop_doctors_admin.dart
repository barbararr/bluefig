import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/notification_list.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_notification_page_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_admin.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_replies_page.dart';
import 'package:flutter/material.dart';

class DesktopDoctorsListPageAdmin extends StatelessWidget {
  const DesktopDoctorsListPageAdmin({Key? key}) : super(key: key);

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
                icon: Icon(Icons.chat),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
            child: MaterialButton(
              child: IconButton(
                onPressed: () {},
                icon: Icon(Icons.account_circle),
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Container(
              child: RaisedButton(
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  print('form submiitted');
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: firstColor,
              ),
              width: MediaQuery.of(context).size.width / 3,
              height: 30,
            ),
          ),
          ListView.builder(
            itemCount: 50,
            itemBuilder: (ctx, index) {
              return GestureDetector(
                child: Row(children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.2),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 50,
                        child: Card(
                          child: Center(
                            child: Text("Doctor",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.6)),
                                textAlign: TextAlign.justify),
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => (DesktopRepliesPage()))),
              );
            },
          ),
        ],
      ),
    );
  }
}
