import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/globals.dart' as globals;

class LastRecordsExpansionTile extends StatefulWidget {
  const LastRecordsExpansionTile({Key? key}) : super(key: key);

  @override
  State<LastRecordsExpansionTile> createState() =>
      _LastRecordsExpansionTileState();
}

class _LastRecordsExpansionTileState extends State<LastRecordsExpansionTile> {
  // Generate a list of Users, You often use API or database for creation of this list
  final List<Map<String, dynamic>> _users = List.generate(
      20,
      (index) => {
            "id": index,
            "name": "Запись $index",
            "detail": "Запись $index. Параметры: ..."
          });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> records = [
      {
        "id": "2024-03-10 Антропометрия",
        "name": "Запись 2024-03-10 Антропометрия",
        "detail": "Параметры: \n Вес: 50 \n Рост: 165 \n Окружность плеча: 20"
      },
      {
        "id": "2024-03-03 Антропометрия",
        "name": "Запись 2024-03-03 Антропометрия",
        "detail": "Параметры: \n Вес: 49 \n Рост: 165 \n Окружность плеча: 20"
      },
    ];

    List<Map<String, dynamic>> newrecords = [
      {
        "id": "2024-03-21 Гастроинтестинальные симптомы",
        "name": "Запись 2024-03-21 Гастроинтестинальные симптомы",
        "detail":
            "Параметры: \n Тошнота: до еды, после еды \n Рвота: нет \n Аппетит: обычный \n Кожная сыпь: нет"
      },
      {
        "id": "2024-03-21 Антропометрия",
        "name": "Запись 2024-03-21 Антропометрия",
        "detail": "Параметры: \n Вес: 52 \n Рост: 165 \n Окружность плеча: 20"
      },
      {
        "id": "2024-03-10 Антропометрия",
        "name": "Запись 2024-03-10 Антропометрия",
        "detail": "Параметры: \n Вес: 50 \n Рост: 165 \n Окружность плеча: 20"
      },
      {
        "id": "2024-03-03 Антропометрия",
        "name": "Запись 2024-03-03 Антропометрия",
        "detail": "Параметры: \n Вес: 49 \n Рост: 165 \n Окружность плеча: 20"
      },
    ];
    List<Map<String, dynamic>> lastRecods;
    if (globals.addNew)
      lastRecods = newrecords;
    else
      lastRecods = records;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: lastRecods.length,
      itemBuilder: (_, index) {
        final item = lastRecods[index];
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
                    child: Icon(Icons.comment),
                    backgroundColor: Colors.white,
                    foregroundColor: firstColor,
                  ),
                  title: Text(item['detail'])),
            ],
          ),
        );
      },
    );
  }
}
