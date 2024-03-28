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
    
    List<Map<String, dynamic>> lastRecods = [];
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
