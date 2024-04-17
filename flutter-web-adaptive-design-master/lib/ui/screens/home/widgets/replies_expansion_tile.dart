import 'package:adaptive_design/ui/common/app_colors.dart';
import 'package:adaptive_design/ui/common/models/recomendation_model.dart';
import 'package:adaptive_design/ui/common/models/user_model.dart';
import 'package:flutter/material.dart';
import '../../../common/globals.dart' as globals;
import 'api_data_provider.dart';

class ReplyExpansionTile extends StatefulWidget {
  const ReplyExpansionTile({Key? key}) : super(key: key);

  @override
  State<ReplyExpansionTile> createState() => _ReplyExpansionTileState();
}

class _ReplyExpansionTileState extends State<ReplyExpansionTile> {
  final List<Map<String, dynamic>> _users = List.generate(
      20,
      (index) => {
            "id": index,
            "name": "Ответ $index",
            "detail": "Ответ $index. Текст ответа."
          });

  List<Map<String, dynamic>> records = [];
  List<RecommendationModel> recommendations = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    recommendations =
        await ApiDataProvider().getRecommendations(globals.user!.id);
    buildString();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
    print(recommendations.length.toString() + "pop");
  }

  Future<String> getDoctorName(String id) async {
    UserModel doctor = await ApiDataProvider().getUser(id);
    return doctor.lastname + " " + doctor.firstname + " " + doctor.fathername;
  }

  Future<void> buildString() async {
    for (var i = 0; i < recommendations.length; i++) {
      String doctorName = await getDoctorName(recommendations[i].doctorId);

      Map<String, dynamic> recordString = {};
      recordString.addAll({
        "id": recommendations[i].datetime,
        "name": "Рекомендация " +
            recommendations[i].datetime.replaceAll("T", " ") +
            " " +
            doctorName,
        "detail": recommendations[i].recommendation
      });
      records.add(recordString);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(recommendations.toString());
    return ListView.builder(
      shrinkWrap: true,
      itemCount: records.length,
      itemBuilder: (_, index) {
        final item = records[index];
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
