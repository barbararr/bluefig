import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/models/module_model.dart';
import 'package:flutter/material.dart';

import 'api_data_provider.dart';

import '../../../common/globals.dart' as globals;

class ModulesExpansionTile extends StatefulWidget {
  const ModulesExpansionTile({Key? key}) : super(key: key);

  @override
  State<ModulesExpansionTile> createState() => _ModulesExpansionTileState();
}

class _ModulesExpansionTileState extends State<ModulesExpansionTile> {
  // Generate a list of Users, You often use API or database for creation of this list
  List<Map<String, dynamic>> modulesToPrint = [];
  /*List.generate(
          5,
          (index) => {
                "id": index,
                "name": "Модуль $index",
                "detail": "Модуль $index. \nПараметры: ..."
              });*/

  List<ModuleModel> modules = [];

  void addModule(int id) {
    setState(() {
      ApiDataProvider().giveModuleToPatient(globals.currentPatientID,
          globals.user!.id, modules[id].id, int.parse(frequency));
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('Модуль назначен')));
  }

  void getModulesToPrint() {
    for (var i = 0; i < modules.length; i++) {
      modulesToPrint.add({
        "id": i,
        "name": "Модуль " + modules[i].name,
        "detail": "\nПараметры: " + modules[i].parametersToString()
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    modules = (await ApiDataProvider().getAllModules());
    getModulesToPrint();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  String frequency = "";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: modulesToPrint.length,
      itemBuilder: (_, index) {
        final item = modulesToPrint[index];
        return Card(
          //Remember
          //Here key is required to save and restore ExpansionTile expanded state
          key: PageStorageKey(item['id']),

          child: ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            childrenPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            expandedCrossAxisAlignment: CrossAxisAlignment.end,
            maintainState: true,
            title: Text(item['name']),
            textColor: firstColor,
            iconColor: firstColor,
            // Expanded Contents
            children: [
              ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.extension),
                    backgroundColor: Colors.white,
                    foregroundColor: firstColor,
                  ),
                  title: Text(item['detail'])),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Частота: ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  /*DropdownButton<String>(
                    items: <String>['1 день', '3 дня', '1 неделя', '2 недели']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),*/
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 30,
                    child: TextFormField(
                      onChanged: (value) => frequency = value,
                      cursorColor: secondColor,
                      decoration: InputDecoration(
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: fourthColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: secondColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(9.0))),
                      ),
                    ),
                    //),
                  ),
                  /*TextFormField(
                    onChanged: (value) => frequency = value as int,
                  ),*/
                  Text(
                    " дней",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  Spacer(),
                  Container(
                    child: RaisedButton(
                      child: Text(
                        'Добавить модуль',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () => addModule(item['id']),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: firstColor,
                    ),
                    width: MediaQuery.of(context).size.width / 5,
                    height: 25,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
