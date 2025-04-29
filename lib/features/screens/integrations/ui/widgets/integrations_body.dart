import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
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
          image: 'assets/images/user.png',
        ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.chooseViewWorkLocationScreen),
        label: 'Work Location',
        image: 'assets/images/location.png',
      ),
      if (role == 'Admin')
        IntegrationItem(
          onTap: () => context.pushNamed(Routes.assignScreen),
          label: "Assign Management",
          image: 'assets/images/assign.png',
        ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.shiftScreen),
        label: "Shift",
        image: 'assets/images/shift.png',
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.taskManagementScreen),
        label: 'Task',
        image: 'assets/images/task.png',
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.attendanceScreen),
        label: "Attendance",
        image: 'assets/images/attendance.png',
      ),
      if (role == 'Admin')
        IntegrationItem(
          onTap: () => context.pushNamed(Routes.viewStockScreen),
          label: "Stock",
          image: 'assets/images/stock.png',
        ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.activityScreen),
        label: "Activity",
        image: 'assets/images/activity.png',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Integrations"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 24.h,
                  crossAxisSpacing: 24.w,
                  childAspectRatio: 1,
                ),
                itemCount: integrationItems.length,
                itemBuilder: (context, index) {
                  final item = integrationItems[index];
                  return buildIntegrationItem(
                    item.onTap,
                    item.label,
                    item.image,
                  );
                },
              ),
              verticalSpace(30),
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
  final String image;

  IntegrationItem({
    required this.onTap,
    required this.label,
    required this.image,
  });
}
