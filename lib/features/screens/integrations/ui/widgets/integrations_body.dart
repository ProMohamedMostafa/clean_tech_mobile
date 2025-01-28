import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
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
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.userManagmentScreen),
        label: S.of(context).integ1,
        icon: IconBroken.addUser,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.organizationsScreen),
        label: 'Work Location',
        icon: Icons.location_city_outlined,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.assignScreen),
        label: "Assign",
        icon: Icons.assignment,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.shiftScreen),
        label: "Shift",
        icon: IconBroken.calendar,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.taskManagementScreen),
        label: S.of(context).integ3,
        icon: Icons.task_outlined,
      ),
      IntegrationItem(
        onTap: () {},
        label: S.of(context).integ4,
        icon: Icons.file_copy_outlined,
      ),
      IntegrationItem(
        onTap: () => context.pushNamed(Routes.settingsScreen),
        label: S.of(context).integ5,
        icon: IconBroken.setting,
      ),
    ];
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: 200.h,
                color: AppColor.primaryColor,
              ),
            ),
            Padding(
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
                            item.onTap, item.label, item.icon);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    // Slight curve at size.width * 0.15
    path.quadraticBezierTo(
      size.width * 0.13, size.height - 40, // Control point
      size.width * 0.15, size.height - 40, // Endpoint
    );

    // Slight curve at size.width * 0.85
    path.quadraticBezierTo(
      size.width * 0.87, size.height - 40, // Control point
      size.width * 0.85, size.height - 40, // Endpoint
    );
    // path.lineTo(size.width * 0.15, size.height - 40);
    // path.lineTo(size.width * 0.85, size.height - 40);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
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
