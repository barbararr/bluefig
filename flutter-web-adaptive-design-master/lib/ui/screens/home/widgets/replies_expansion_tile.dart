import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:flutter/material.dart';

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
