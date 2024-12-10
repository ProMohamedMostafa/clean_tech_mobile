import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/itegration_item.dart';

class IntegrationsBody extends StatelessWidget {
  const IntegrationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child: Center(
            child: SingleChildScrollView(
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                childAspectRatio: 1 / 1,
                children: [
                  buildIntegrationItem(
                    () {},
                    'User Management',
                    IconBroken.Add_User,
                  ),
                  buildIntegrationItem(
                    () {},
                    'Add Task',
                    Icons.task_outlined,
                  ),
                  buildIntegrationItem(
                    () {},
                    'Reports',
                    Icons.file_copy_outlined,
                  ),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.settingssScreen);
                    },
                    'Settings',
                    IconBroken.Setting,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
