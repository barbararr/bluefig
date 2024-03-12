import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import 'desktop_replies_page.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  List<String> categories = ['Доктор', 'Пациент'];
  List<String> elementsEnterPatient = [
    'Email',
    'Password',
    'Name',
    'Surname',
    'Doctor'
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
        title: Text('Registration'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(color: Colors.blueGrey)),
                  // child: Image.asset('assets/logo.png'),
                ),
              ),
            ),
            Row(
              children: categories
                  .map((category) => ChoiceChip(
                        label: Text(category),
                        selected: selectedCategory == category,
                        onSelected: (isSelected) {
                          setState(() {
                            if (isSelected) {
                              selectedCategory = category;
                              if (selectedCategory == 'Доктор') {
                                listOfElements =
                                    List<String>.from(elementsEnterDoctor);
                              } else {
                                listOfElements =
                                    List<String>.from(elementsEnterPatient);
                              }
                            } else {
                              selectedCategory = '';
                            }
                          });
                        },
                      ))
                  .toList(),
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
                            for (int i = 0; i < listOfElements.length; i++)
                              // Here add the widget you created for the single item...
                              // e.g.
                              Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextFormField(
                                      cursorColor: secondColor,
                                      decoration: InputDecoration(
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: secondColor,
                                            width: 2.0,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        hintText: listOfElements[i],
                                        labelText: listOfElements[i],
                                        //focusedBorder: OutlineInputBorder(
                                        //  borderSide:
                                        //     BorderSide(color: firstColor),
                                        //  borderRadius: BorderRadius.all(
                                        //    Radius.circular(9.0))),
                                        hintStyle: TextStyle(
                                            fontSize: 16.0, color: secondColor),
                                        labelStyle: TextStyle(
                                            fontSize: 16.0, color: secondColor),
                                        errorStyle: TextStyle(fontSize: 18.0),
                                        border: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: secondColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(9.0))),
                                      ))),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: Container(
                                  child: RaisedButton(
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                    onPressed: () {
                                      // if (_formkey.currentState!.validate()) {
                                      //  print('form submiitted');
                                      //  }
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) =>
                                              ((DesktopPatientListPageDoctor()))));
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    color: firstColor,
                                  ),
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: 50,
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
