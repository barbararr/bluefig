import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../common/globals.dart' as globals;

class ReplyExpansionTile extends StatefulWidget {
  const ReplyExpansionTile({Key? key}) : super(key: key);

  @override
  State<ReplyExpansionTile> createState() => _ReplyExpansionTileState();
}

class _ReplyExpansionTileState extends State<ReplyExpansionTile> {
  // Generate a list of Users, You often use API or database for creation of this list
  final List<Map<String, dynamic>> _users = List.generate(
      20,
      (index) => {
            "id": index,
            "name": "Ответ $index",
            "detail": "Ответ $index. Текст ответа."
          });

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> records = [
      {
        "id": "2024-03-10",
        "name": "Ответ 2024-03-10",
        "detail": "Добавьте больше белка в рацион"
      },
      {
        "id": "2024-03-03",
        "name": "Ответ 2024-03-03",
        "detail": "Продолжайте следовать рекомендациям"
      },
    ];

    List<Map<String, dynamic>> newrecords = [
      {
        "id": "2024-03-21",
        "name": "Ответ 2024-03-21",
        "detail": "Продолжайте следовать рекомендациям"
      },
      {
        "id": "2024-03-10",
        "name": "Ответ 2024-03-10",
        "detail": "Добавьте больше белка в рацион"
      },
      {
        "id": "2024-03-03",
        "name": "Ответ 2024-03-03 ",
        "detail": "Продолжайте следовать рекомендациям"
      },
    ];
    List<Map<String, dynamic>> lastRecods = newrecords;
    if (globals.addNewRecomendation)
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
                    child: Icon(Icons.comment_bank_outlined),
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
