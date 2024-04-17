/*import 'package:flutter/material.dart';

import '../../../common/models/module_model.dart';

class _MyCheckBox extends State<MyWidget>{
  bool _isChecked = false;

  bool getValue() {
    return _isChecked;
  }

  @override
  Widget build(List<ModuleModel> modules, int index, int i) {
    return StatefulBuilder(builder: (context, setState) {
      return Checkbox(
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
          });
    });
  }
}*/
