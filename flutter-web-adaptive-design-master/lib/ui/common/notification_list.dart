import 'package:flutter/material.dart';

class ListViewHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: <Widget>[
        Container(
          height: 50,
          width: 10,
          color: Colors.orange[600],
          child: const Center(child: Text('List 1')),
        ),
        Container(
          height: 50,
          width: 100,
          color: Colors.red[500],
          child: const Center(child: Text('List 2')),
        ),
        Container(
          height: 50,
          width: 100,
          color: Colors.blue[500],
          child: const Center(child: Text('List 3')),
        ),
      ],
    );
  }
}
