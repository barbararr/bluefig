import 'package:adaptive_design/ui/screens/home/widgets/desktop_doctors_admin.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_main_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_modules_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_notification_page_patient.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patient_last_records.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_patients_list_doctor.dart';
import 'package:adaptive_design/ui/screens/home/widgets/desktop_user_registration.dart';
import 'package:adaptive_design/ui/screens/home/widgets/log_in_page.dart';
import 'package:adaptive_design/ui/screens/home/widgets/mobile_home_page.dart';
import 'package:adaptive_design/ui/widgets/adaptive_page_builder.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptivePageBuilder(builder: (context, type) {
      if (type == DeviceTypeEnum.mobile) {
        return MobileHomePage();
      }
      //return DesktopNotificationPage();
      return Login();
    });
  }
}

/*import 'package:adaptive_design/ui/screens/home/widgets/api_data_provider.dart';
import 'package:flutter/material.dart';

import '../../common/models/user_model.dart';
import '../../common/globals.dart' as globals;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late UserModel _userModel = UserModel(
      id: '',
      username: '',
      firstname: '',
      lastname: '',
      //fathername: '',
      email: '',
      password: '',
      roleId: '',
      birthday: DateTime.now(),
      sex: '');

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    //ApiDataProvider().createUser();

    globals.user = (await ApiDataProvider().getUser());

    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    /* return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Example'),

      ),
      body: _userModel == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_userModel.id.toString()),
                          Text(_userModel.username),
                          //Text(_userModel![index].id.toString()),
                          //Text(_userModel![index].username),
                        ],
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(_userModel.email),
                          Text(_userModel.sex),
                          //Text(_userModel![index].email),
                          //Text(_userModel![index].sex),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );*/
    return AdaptivePageBuilder(builder: (context, type) {
      if (type == DeviceTypeEnum.mobile) {
        return MobileHomePage();
      }
      //return DesktopNotificationPage();
      return DesktopPatientListPageDoctor();
    });
  }
}*/
