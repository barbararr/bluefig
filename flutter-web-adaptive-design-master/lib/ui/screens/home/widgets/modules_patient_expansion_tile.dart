import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/models/category_model.dart';
import 'package:adaptive_design/ui/common/models/gastro_label_model.dart';
import 'package:adaptive_design/ui/common/models/module_model.dart';
import 'package:adaptive_design/ui/common/models/module_with_parameters.dart';
import 'package:adaptive_design/ui/common/models/parameter_model.dart';
import 'package:adaptive_design/ui/common/models/product_model.dart';
import 'package:adaptive_design/ui/screens/home/widgets/drop_down_select.dart';
import 'package:adaptive_design/ui/screens/home/widgets/food_diary_page.dart';
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
  List<Map<String, dynamic>> modulesToPrint = [];

  List<ModuleModel> modules = [];
  List<String> selectedValues = [];
  List<GastroLabelModel> lables = [];
  Map<String, List<String>> categories = {};
  List<String> selectedCategories = [];
  List<String> selectedCProducts = [];
  List<String> selectedWeights = [];

  /*void addModule(int id) {
    setState(() {
      ApiDataProvider().giveModuleToPatient(globals.currentPatientID,
          globals.user!.id, modules[id].id, frequency);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('Модуль назначен')));
  }*/

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
    /*Future.delayed(const Duration(milliseconds: 100))
        .then((value) => setState(() {}));*/
    Future.delayed(const Duration(milliseconds: 100));
  }

  /*List<List<String>> list_names = [];
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
  List<String> stul_selected = [];
  List<String> bristol_selected = [];
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
  List<String> stul = ["нет", "кровь", "слизь", "кусочки пищи", "другое"];
  List<String> bristol = [
    "Отдельные жёсткие куски, похожие на орехи",
    "Колбасовидный комковатый",
    "Колбасовидный с трещинами на поверхности",
    "Колбасовидный с гладкой поверхностью",
    "Мягкие комочки с чёткими краями",
    "Рыхлые, мягкие пушистые комочки с рваными краями",
    "Водянистый без твёрдых кусочков"
  ];
  bool _isChecked = false;*/
  //List<Widget> buildChoices() {}

  Future<void> sendModuleData(String moduleID, String datetime,
      List<ParameterModel> parameterList) async {
    String datetime = DateTime.now().toString().replaceAll(" ", "T");
    String json =
        "{ \"questionaryId\": \"$moduleID\", \"datetime\": \"$datetime\", \"fillIn\": [";
    for (var i = 0; i < parameterList.length; i++) {
      String value = parameterList[i].value;
      String id = parameterList[i].id;
      json +=
          "{\"value\": \"$value\", \"answerIdJpa\": {\"fillIn\" : \"\", \"parameterId\": \"$id\"}}";
      if (i != parameterList.length - 1)
        json += ",";
      else
        json += "]}";
    }
    print(json);

    if (!(await ApiDataProvider().sendModuleData(json)))
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Проверьте корректность введенных значений!'),
        backgroundColor: Colors.red,
      ));
  }

  /*void buildFood(String current_name) {
    List<Widget> row_widgets = [];
    row_widgets.add(Text(
      "Категория: ",
      style: TextStyle(color: Colors.black, fontSize: 15),
    ));
    row_widgets.add(Expanded(
      child: DropDownMultiSelect(
        options: current.options,
        selectedValues: current.selectedOptions,
        onChanged: (value) {
          print('выбрано $value');
          setState(() {
            current.selectedOptions = value;
          });
          current.value = current.selectedOptions.toString();
        },
        whenEmpty: 'Выберите',
      ),
    ));
  }*/

  List<Widget> buildModuleInput(int index) {
    List<Widget> fields = [];
    List<Widget> row_widgets = [];
    Row row_food;
    if (modules[index].name == "Дневник питания") {
      globals.questtionaryID = modules[index].questionaryId;
      fields.add(Container(
        child: RaisedButton(
          child: Text(
            'Добавить запись',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => (DesktopFoodDiary())))
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: firstColor,
        ),
        width: MediaQuery.of(context).size.width / 5,
        height: 25,
      ));
    } else {
      for (var i = 0; i < modules[index].parameterList.length; i++) {
        ParameterModel current = modules[index].parameterList[i];
        String current_name = current.name;
        row_widgets = [];

        row_widgets.add(Text(
          "$current_name: ",
          style: TextStyle(color: Colors.black, fontSize: 15),
        ));
        if (current.dataType == "input") {
          row_widgets.add(Container(
            width: MediaQuery.of(context).size.width / 3,
            height: 40,
            child: TextFormField(
              onChanged: (value) =>
                  modules[index].parameterList[i].value = value,
              cursorColor: secondColor,
              decoration: InputDecoration(
                labelText: modules[index].parameterList[i].description,
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
          ));
        }
        // var result;
        if (current.dataType == "switch") {
          modules[index].parameterList[i].value = "нет";
          row_widgets.add(StatefulBuilder(builder: (context, setState) {
            return Checkbox(
                value: modules[index].parameterList[i].isChecked,
                onChanged: (value) {
                  setState(() {
                    modules[index].parameterList[i].isChecked = value!;
                    if (modules[index].parameterList[i].isChecked) {
                      modules[index].parameterList[i].value = "есть";
                    } else {
                      modules[index].parameterList[i].value = "нет";
                    }
                  });
                });
          }));
          //row_widgets.add(Text("есть"));
        }
        if (current.dataType == "datalist" || current.dataType == "select") {
          /*getLables(current.id);
          List<String> names = [];
          for (var i = 0; i < lables.length; i++) {
            names.add(lables[i].name);
          }
          List<String> selected_names = [];*/

          row_widgets.add(Expanded(
            child: DropDownMultiSelect(
              options: current.options,
              selectedValues: current.selectedOptions,
              onChanged: (value) {
                print('выбрано $value');
                setState(() {
                  current.selectedOptions = value;
                });
                current.value = current.selectedOptions.toString();
              },
              whenEmpty: 'Выберите',
            ),
          ));

          /*if (modules[index].parameterList[i].name == "Группа продуктов") {
          row_widgets.add(Expanded(child: MyDropDownSelect()));
        }*/
          /*if (modules[index].parameterList[i].name == "Тошнота") {
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
          if (modules[index].parameterList[i].name == "Примеси в стуле") {
            row_widgets.add(Expanded(
              child: DropDownMultiSelect(
                options: stul,
                selectedValues: stul_selected,
                onChanged: (value) {
                  print('selected $value');
                  setState(() {
                    stul_selected = value;
                  });
                  current.value = stul_selected.toString();
                  modules[index].parameterList[i].value =
                      stul_selected.toString();
                },
                whenEmpty: 'Выберите',
              ),
            ));
          }
          if (modules[index].parameterList[i].name == "Стул") {
            row_widgets.add(Expanded(
              child: DropDownMultiSelect(
                options: bristol,
                selectedValues: bristol_selected,
                onChanged: (value) {
                  print('selected $value');
                  setState(() {
                    bristol_selected = value;
                  });
                  current.value = bristol_selected.toString();
                  modules[index].parameterList[i].value =
                      bristol_selected.toString();
                },
                whenEmpty: 'Выберите',
              ),
            ));
          }*/
        }
        //if (modules[index].name != "Дневник питания") {
        Row row = Row(
            //mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: row_widgets);
        fields.add(row);
        fields.add(SizedBox(
          height: 10,
        ));
      }

      /*if (modules[index].name == "Дневник питания") {
      Row row = Row(
          //mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: row_widgets);
      fields.add(row);
      fields.add(SizedBox(
        height: 10,
      ));
      row_food = row;

      fields.add(Container(
        child: RaisedButton(
          child: Text(
            'Добавить продукт',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          onPressed: () => setState(() => {fields.add(row_food)}),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: firstColor,
        ),
        width: MediaQuery.of(context).size.width / 5,
        height: 25,
      ));
    }*/
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
            sendModuleData(modules[index].questionaryId,
                DateTime.now().toString(), modules[index].parameterList),
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
    modules = (await ApiDataProvider().getPatientModules(globals.user!.id));
    for (var i = 0; i < modules.length; i++) {
      if (modules[i].name != "Дневник питания") {
        for (var j = 0; j < modules[i].parameterList.length; j++) {
          if (modules[i].parameterList[j].dataType == "datalist" ||
              modules[i].parameterList[j].dataType == "select") {
            if (modules[i].parameterList[j].name == "Наименование смеси") {
              modules[i].parameterList[j].options =
                  (await ApiDataProvider().getFormula());
            } else {
              if (modules[i].parameterList[j].name == "Группа продуктов") {
                List<CategoryModel> cat =
                    (await ApiDataProvider().getCategories());
                List<String> catNames = [];
                for (var k = 0; k < cat.length; k++) {
                  catNames.add(cat[k].name);
                  /* List<ProductModel> prod =
                      (await ApiDataProvider().getProducts(cat[k].id));
                  List<String> prodNames = [];
                  for (var n = 0; n < prod.length; n++) {
                    prodNames.add(prod[n].name);
                  }
                  categories.addAll({cat[k].name: prodNames});
                  modules[i].parameterList[j].options = catNames;*/
                }
              }

              List<GastroLabelModel> lables = (await ApiDataProvider()
                  .getGastroLables(modules[i].parameterList[j].id));
              List<String> names = [];
              for (var i = 0; i < lables.length; i++) {
                names.add(lables[i].name);
              }
              modules[i].parameterList[j].options = names;
            }
          }
        }
      } else {
        List<CategoryModel> cat = (await ApiDataProvider().getCategories());
        for (var k = 0; k < cat.length; k++) {
          /*List<ProductModel> prod =
              (await ApiDataProvider().getProducts(cat[k].id));
          List<String> prodNames = [];
          for (var n = 0; n < prod.length; n++) {
            prodNames.add(prod[n].name);
          }
          categories.addAll({cat[i].name: prodNames});*/
          //modules[i].parameterList[j].options =
          // (await ApiDataProvider().getFormula());
        }
      }
    }
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
            children: buildModuleInput(item['id']),
          ),
        );
      },
    );
  }
}
