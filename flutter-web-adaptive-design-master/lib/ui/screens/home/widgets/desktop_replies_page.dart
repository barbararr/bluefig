import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/notification_list.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_notification_page_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/replies_expansion_tile.dart';
import 'package:flutter/material.dart';

import 'my_expansion_tile.dart';

class DesktopRepliesPage extends StatelessWidget {
  const DesktopRepliesPage({Key? key}) : super(key: key);

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
                  'Данные',
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
                      builder: (context) =>
                          (DesktopNotificationPagePatient())));
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
                onPressed: () {},
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
        body: ReplyExpansionTile());
  }
}
