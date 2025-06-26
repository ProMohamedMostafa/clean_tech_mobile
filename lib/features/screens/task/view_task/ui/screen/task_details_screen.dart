import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/ui/widget/task_details_body.dart';

class TaskDetailsScreen extends StatelessWidget {
  final int id;
  const TaskDetailsScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Task details"),
          leading: CustomBackButton(),
          actions: [
            role == 'Cleaner'
                ? SizedBox.shrink()
                : IconButton(
                    onPressed: () {
                      context.pushNamed(Routes.editTaskScreen, arguments: id);
                    },
                    icon: Icon(
                      Icons.edit,
                      color: AppColor.primaryColor,
                    ))
          ],
        ),
        body: TaskDetailsBody(id: id));
  }
}
