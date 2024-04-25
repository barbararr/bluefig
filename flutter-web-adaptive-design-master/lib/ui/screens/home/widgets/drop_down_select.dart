import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

import '../../../common/models/category_model.dart';
import '../../../common/models/product_model.dart';
import 'api_data_provider.dart';

class MyDropDownSelect extends StatefulWidget {
  const MyDropDownSelect({Key? key}) : super(key: key);

  @override
  State<MyDropDownSelect> createState() => _MyDropDownSelectState();
}

class _MyDropDownSelectState extends State<MyDropDownSelect> {
  // Generate a list of Users, You often use API or database for creation of this list
  final List<Map<String, dynamic>> _users = List.generate(
      20,
      (index) => {
            "id": index,
            "name": "User $index",
            "detail":
                "User with id $index. You can write detial for expansion tile here."
          });

  List<String> selected = [];
  List<String> options = [];

  //Function use to delete the user from the list
  void _deleteUser(int id) {
    setState(() {
      _users.removeWhere((element) => element['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(milliseconds: 600),
        content: Text('User with id $id has been deleted')));
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    /* List<CategoryModel> cat = (await ApiDataProvider().getCategories());
    for (var k = 0; k < cat.length; k++) {
      options.add(cat[k].name);
      List<ProductModel> prod =
          (await ApiDataProvider().getProducts(cat[k].id));
      List<String> prodNames = [];
      for (var n = 0; n < prod.length; n++) {
        prodNames.add(prod[n].name);
      }
    }
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));*/
  }

  @override
  Widget build(BuildContext context) {
    return DropDownMultiSelect(
      options: options,
      selectedValues: selected,
      onChanged: (value) {
        print('выбрано $value');
        setState(() {
          selected = value;
        });
      },
      whenEmpty: 'Выберите',
    );
  }
}
