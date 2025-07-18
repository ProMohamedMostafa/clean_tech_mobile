import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Attendance'), leading: CustomBackButton()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            verticalSpace(20),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColor.secondaryColor)),
              child: ListTile(
                minTileHeight: 70,
                dense: true,
                leading: Icon(Icons.co_present_rounded,
                    color: AppColor.primaryColor),
                title: Text(S.of(context).history,
                    style: TextStyles.font16PrimSemiBold),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
                onTap: () {
                  context.pushNamed(Routes.historyScreen);
                },
              ),
            ),
            verticalSpace(10),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColor.secondaryColor)),
              child: ListTile(
                minTileHeight: 70,
                dense: true,
                leading: Icon(Icons.person_off_rounded,
                    color: AppColor.primaryColor),
                title: Text(S.of(context).leaves,
                    style: TextStyles.font16PrimSemiBold),
                trailing:
                    Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
                onTap: () {
                  context.pushNamed(Routes.leavesScreen);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
