import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/itegration_item.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class IntegrationsBody extends StatelessWidget {
  const IntegrationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<IntegrationItem> integrationItems = [
      if (role != 'Cleaner')
        IntegrationItem(
          onTap: () => context.pushNamed(Routes.userManagmentScreen),
          label: S.of(context).integ1,
          icon: IconBroken.addUser,
        ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.chooseViewWorkLocationScreen),
        label: 'Work Location',
        icon: Icons.location_city_outlined,
      ),
      if (role == 'Admin')
        IntegrationItem(
          onTap: () => context.pushNamed(Routes.assignScreen),
          label: "Assign",
          icon: Icons.assignment,
        ),
      if (role == 'Admin')
        IntegrationItem(
          onTap: () => context.pushNamed(Routes.shiftScreen),
          label: "Shift",
          icon: IconBroken.calendar,
        ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.taskManagementScreen),
        label: 'Task',
        icon: Icons.task_outlined,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.attendanceScreen),
        label: "Attendance",
        icon: Icons.perm_contact_cal_sharp,
      ),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              verticalSpace(100),
              Expanded(
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1,
                  ),
                  itemCount: integrationItems.length,
                  itemBuilder: (context, index) {
                    final item = integrationItems[index];
                    return buildIntegrationItem(
                      item.onTap,
                      item.label,
                      item.icon,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IntegrationItem {
  final VoidCallback onTap;
  final String label;
  final IconData icon;

  IntegrationItem({
    required this.onTap,
    required this.label,
    required this.icon,
  });
}
