import 'dart:html';

import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

class ModulesExpansionTile extends StatefulWidget {
  const ModulesExpansionTile({Key? key}) : super(key: key);

  @override
  State<ModulesExpansionTile> createState() => _ModulesExpansionTileState();
}

class _ModulesExpansionTileState extends State<ModulesExpansionTile> {
  // Generate a list of Users, You often use API or database for creation of this list
  final List<Map<String, dynamic>> _users = List.generate(
      5,
      (index) => {
            "id": index,
            "name": "Модуль $index",
            "detail": "Модуль $index. \nПараметры: ..."
          });

  void _addModule(int id) {
    setState(() {
      _users.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('User with id $id has been deleted')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _users.length,
      itemBuilder: (_, index) {
        final item = _users[index];
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
                  Spacer(),
                  Container(
                    child: RaisedButton(
                      child: Text(
                        'Добавить модуль',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      onPressed: () => _addModule(item['id']),
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
