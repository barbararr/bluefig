import 'package:flutter/material.dart';

class MyExpansionTile extends StatefulWidget {
  const MyExpansionTile({Key? key}) : super(key: key);

  @override
  State<MyExpansionTile> createState() => _MyExpansionTileState();
}

class _MyExpansionTileState extends State<MyExpansionTile> {
  final List<Map<String, dynamic>> _users = List.generate(
      20,
      (index) => {
            "id": index,
            "name": "User $index",
            "detail":
                "User with id $index. You can write detial for expansion tile here."
          });

  void _deleteUser(int id) {
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
            // Expanded Contents
            children: [
              ListTile(
                  leading: const CircleAvatar(
                    child: Icon(Icons.person),
                    backgroundColor: Colors.white,
                  ),
                  title: Text(item['detail'])),

              //Delete Button
              IconButton(
                onPressed: () => _deleteUser(item['id']),
                icon: const Icon(Icons.delete_outline),
                color: Colors.red,
              ),
            ],
          ),
        );
      },
    );
  }
}
