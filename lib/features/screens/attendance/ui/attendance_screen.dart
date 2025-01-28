import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<Map<String, dynamic>> items = [
    {'title': 'History', 'icon': Icons.co_present_rounded},
    {'title': 'Leaves', 'icon': Icons.person_off_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
        ),
        leading: customBackButton(context),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(40),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: items.length,
                separatorBuilder: (context, index) {
                  return verticalSpace(10);
                },
                itemBuilder: (context, index) {
                  final item = items[index];

                  return Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColor.secondaryColor)),
                    child: ListTile(
                      minTileHeight: 80,
                      dense: true,
                      leading: Icon(item['icon'], color: AppColor.primaryColor),
                      title: Text(item['title'],
                          style: TextStyles.font16PrimSemiBold),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: AppColor.primaryColor),
                      onTap: () {
                        index == 0
                            ? context.pushNamed(Routes.historyScreen)
                            : context.pushNamed(Routes.leavesScreen);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
