import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
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
            padding: 10),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.chooseViewWorkLocationScreen),
        label: S.of(context).integ2,
        image: 'assets/images/location.png',
      ),
      IntegrationItem(
          onTap: () => context.pushNamed(Routes.shiftScreen),
          label: S.of(context).integ4,
          image: 'assets/images/shift.png',
          padding: 10),
      IntegrationItem(
        onTap: () {
          if (role == 'Admin' || role == 'Cleaner') {
            context.pushNamed(Routes.taskManagementScreen);
          } else {
            context.pushNamed(Routes.chooseViewTask);
          }
        },
        label: S.of(context).integ5,
        image: 'assets/images/task.png',
        padding: 10,
      ),
      if (role == 'Admin')
        IntegrationItem(
            onTap: () => context.pushNamed(Routes.sensorScreen),
            label: S.of(context).integ9,
            image: 'assets/images/sensor.png',
            padding: 11),
      IntegrationItem(
          onTap: () => context.pushNamed(Routes.attendanceScreen),
          label: S.of(context).integ6,
          image: 'assets/images/attendance.png',
          padding: 12),
      if (role == 'Admin')
        IntegrationItem(
            onTap: () => context.pushNamed(Routes.viewStockScreen),
            label: S.of(context).integ7,
            image: 'assets/images/stock.png',
            padding: 10),
      IntegrationItem(
          onTap: () => context.pushNamed(Routes.activityScreen),
          label: S.of(context).integ8,
          image: 'assets/images/activity.png',
          padding: 8),
      if (role == 'Admin')
        IntegrationItem(
            onTap: () => context.pushNamed(Routes.providerScreen),
            label: S.of(context).integ10,
            image: 'assets/images/provider.png',
            padding: 9),
      if (role == 'Admin')
        IntegrationItem(
            onTap: () => context.pushNamed(Routes.assignScreen),
            label: S.of(context).integ3,
            image: 'assets/images/assign.png',
            padding: 5),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).botNavTitle2,
            style: TextStyle(color: AppColor.primaryColor)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verticalSpace(10),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 15.w,
                  childAspectRatio: 0.70,
                ),
                itemCount: integrationItems.length,
                itemBuilder: (context, index) {
                  final item = integrationItems[index];
                  return buildIntegrationItem(
                      item.onTap, item.label, item.image, item.padding);
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
  double? padding;

  IntegrationItem({
    required this.onTap,
    required this.label,
    required this.image,
    this.padding,
  });
}
