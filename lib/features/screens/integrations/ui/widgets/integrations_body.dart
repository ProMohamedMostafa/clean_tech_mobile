import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/itegration_item.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

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
                  role == 'Admin'
                      ? buildIntegrationItem(
                          () {
                            context.pushNamed(Routes.userManagmentScreen);
                          },
                          S.of(context).integ1,
                          IconBroken.addUser,
                        )
                      : SizedBox.shrink(),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.organizationsScreen);
                    },
                    S.of(context).integ2,
                    Icons.location_city_outlined,
                  ),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.assignScreen);
                    },
                    "Assign",
                    Icons.assignment,
                  ),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.shiftScreen);
                    },
                    "Shift",
                    IconBroken.calendar,
                  ),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.taskManagementScreen);
                    },
                    S.of(context).integ3,
                    Icons.task_outlined,
                  ),
                  buildIntegrationItem(
                    () {},
                    S.of(context).integ4,
                    Icons.file_copy_outlined,
                  ),
                  buildIntegrationItem(
                    () {
                      context.pushNamed(Routes.settingsScreen);
                    },
                    S.of(context).integ5,
                    IconBroken.setting,
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
