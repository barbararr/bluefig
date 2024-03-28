import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/models/gastro_label_model.dart';
import 'package:adaptive_design/ui/common/models/module_model.dart';
import 'package:adaptive_design/ui/common/models/parameter_model.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

import 'api_data_provider.dart';

import '../../../common/globals.dart' as globals;

class ModulesPatientExpansionTile extends StatefulWidget {
  const ModulesPatientExpansionTile({Key? key}) : super(key: key);

  @override
  State<ModulesPatientExpansionTile> createState() =>
      _ModulesPatientExpansionTileState();
}

class _ModulesPatientExpansionTileState
    extends State<ModulesPatientExpansionTile> {
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
  List<String> selectedValues = [];
  List<GastroLabelModel> lables = [];

  void addModule(int id) {
    setState(() {
      ApiDataProvider().giveModuleToPatient(globals.currentPatientID,
          globals.user!.id, modules[id].id, frequency);
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

  void getLables(String id) async {
    lables = (await ApiDataProvider().getGastroLables(id));
    Future.delayed(const Duration(milliseconds: 100))
        .then((value) => setState(() {}));
  }

  List<List<String>> list_names = [];
  List<List<String>> list_selected_values = [];
  List<String> apetit = [
    "обычный",
    "снижен",
    "отсутствует",
    "повышен",
    "изменились предпочтения в еде"
  ];
  List<String> apetit_selected = [];
  List<String> rvota_selected = [];
  List<String> toshnota_selected = [];
  List<String> sip_selected = [];
  List<String> rvota = [
    "да",
    "нет",
  ];
  List<String> toshnota = [
    "после еды",
    "до еды",
    "не связана с приемом пищи",
    "препятствует приему пищи"
  ];
  List<String> sip = [
    "да",
    "нет",
  ];

  //List<Widget> buildChoices() {}

  List<Widget> buildModuleInput(int index) {
    List<Widget> fields = [];
    if (!globals.addNewRecomendation) {
      for (var i = 0; i < modules[index].parameterList.length; i++) {
        ParameterModel current = modules[index].parameterList[i];
        String current_name = current.name;
        List<Widget> row_widgets = [];

        if (current.name != "Стул") {
          row_widgets.add(Text(
            "$current_name: ",
            style: TextStyle(color: Colors.black, fontSize: 15),
          ));
        }
        if (current.dataType == "input") {
          row_widgets.add(Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            child: TextFormField(
              onChanged: (value) =>
                  modules[index].parameterList[i].value = value,
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
                    borderRadius: BorderRadius.all(Radius.circular(9.0))),
              ),
            ),
            //),
          ));
        }
        var result;
        if (current.dataType == "switch") {
          bool _isChecked = false;
          row_widgets.add(
              //SizedBox(
              // height: 20,
              // width: 40,
              // child:
              /* Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadioListTile(
                  title: const Text('есть рвота'),
                  value: true,
                  groupValue: result,
                  onChanged: (value) {
                    setState(() {
                      modules[index].parameterList[i].value = value.toString();
                    });
                  }),
            ],
          ),
        );*/
              //)
              /* Radio(value: result, groupValue: result, onChanged: (value) {
            setState(() {
              modules[index].parameterList[i].value = value.toString();
            });
          })
            Radio(
          groupValue: result,
          value: result,
          onChanged: (value) {
            setState(() {
              modules[index].parameterList[i].value = value.toString();
            });
          },modules[index].parameterList[i].value = "true";
        ))*/

              Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                      if (_isChecked) {
                        modules[index].parameterList[i].value = "true";
                      } else {
                        modules[index].parameterList[i].value = "false";
                      }
                    });
                  }));
          //row_widgets.add(Text("есть"));
        }
        if (current.dataType == "datalist") {
          // getLables(current.id);
          //List<String> names = [];
          //for (var i = 0; i < lables.length; i++) {
          //  names.add(lables[i].name);
          // }
          if (modules[index].parameterList[i].name == "Аппетит") {
            row_widgets.add(Expanded(
              child: DropDownMultiSelect(
                options: apetit,
                selectedValues: apetit_selected,
                onChanged: (value) {
                  print('selected $value');
                  setState(() {
                    apetit_selected = value;
                  });
                  current.value = apetit_selected.toString();
                  modules[index].parameterList[i].value =
                      apetit_selected.toString();
                },
                whenEmpty: 'Выберите',
              ),
            ));
          }
          if (modules[index].parameterList[i].name == "Тошнота") {
            row_widgets.add(Expanded(
              child: DropDownMultiSelect(
                options: toshnota,
                selectedValues: toshnota_selected,
                onChanged: (value) {
                  print('selected $value');
                  setState(() {
                    toshnota_selected = value;
                  });
                  current.value = toshnota_selected.toString();
                  modules[index].parameterList[i].value =
                      toshnota_selected.toString();
                },
                whenEmpty: 'Выберите',
              ),
            ));
          }
          if (modules[index].parameterList[i].name == "Рвота") {
            row_widgets.add(Expanded(
              child: DropDownMultiSelect(
                options: rvota,
                selectedValues: rvota_selected,
                onChanged: (value) {
                  print('selected $value');
                  setState(() {
                    rvota_selected = value;
                  });
                  current.value = rvota_selected.toString();
                  modules[index].parameterList[i].value =
                      rvota_selected.toString();
                },
                whenEmpty: 'Выберите',
              ),
            ));
          }

          /*list_names.add(names);
        int iter = list_names.length - 1;
        List<String> selected = [];
        list_selected_values.add(selected);
        int iter2 = list_selected_values.length - 1;
        row_widgets.add(Expanded(
          child: DropDownMultiSelect(
            options: list_names[iter],
            selectedValues: list_selected_values[iter2],
            onChanged: (value) {
              print('selected fruit $value');
              setState(() {
                list_selected_values[iter2] = value;
              });
              current.value = list_selected_values[iter2].toString();
            },
            whenEmpty: 'Select your favorite fruits',
          ),
        ));*/

        }
        Row row = Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: row_widgets);
        fields.add(row);
        /*fields.add(Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Text(
          "$current_name: ",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
        //Expanded(
        //child:

        Container(
          width: MediaQuery.of(context).size.width / 3,
          height: 40,
          child: TextFormField(
            onChanged: (value) => current.value = value,
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
                  borderRadius: BorderRadius.all(Radius.circular(9.0))),
            ),
          ),
          //),
        )
      ]));*/
        fields.add(SizedBox(
          height: 10,
        ));
      }
      fields.add(SizedBox(
        height: 10,
      ));
      fields.add(Container(
        child: RaisedButton(
          child: Text(
            'Добавить запись',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => {
            globals.addNew = true,
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(milliseconds: 600),
                content: Text('Запись добавлена')))
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: firstColor,
        ),
        width: MediaQuery.of(context).size.width / 5,
        height: 25,
      ));
    }
    return fields;
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    // TODO get modules from patient modules
    modules = (await ApiDataProvider().getPatientModules(globals.user!.id));
    getModulesToPrint();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  int frequency = 0;

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
            children:
                /*ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.extension),
                    backgroundColor: Colors.white,
                    foregroundColor: firstColor,
                  ),
                  title: Text(item['detail'])),*/
                /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Частота: ",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  DropdownButton<String>(
                    items: <String>['1 день', '3 дня', '1 неделя', '2 недели']
                        .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (_) {},
                  ),
                  /*TextFormField(
                    onChanged: (value) => frequency = value as int,
                  ),
                  Text(
                    " дней",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),*/
                  Spacer(),
                  Container(
                    child: RaisedButton(
                      child: Text(
                        'Добавить запись',
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
              ),*/
                buildModuleInput(item['id']),
          ),
        );
      },
    );
  }
}
