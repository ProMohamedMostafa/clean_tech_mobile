import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class LanguagesScreen extends StatefulWidget {
  const LanguagesScreen({super.key});

  @override
  State<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  var ischecked = [true, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Language'),
        leading: customBackButton(context),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  ischecked[0] = true;
                  ischecked[1] = false;
                  ischecked[2] = false;
                });
              },
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                leading: Text(
                  'English',
                  style: TextStyles.font16BlackSemiBold,
                ),
                trailing: Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: ischecked[0]
                        ? Colors.transparent
                        : AppColor.primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: ischecked[0]
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withOpacity(0.4),
                      width: ischecked[0] ? 6.w : 2.w,
                    ),
                  ),
                ),
              ),
            ),
            Divider(),
            verticalSpace(5),
            Text(
              'Others',
              style:
                  TextStyles.font16PrimSemiBold.copyWith(color: Colors.black),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  ischecked[1] = true;
                  ischecked[0] = false;
                  ischecked[2] = false;
                });
              },
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                leading: Text(
                  'العربية',
                  style: TextStyles.font16BlackSemiBold,
                ),
                trailing: Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: ischecked[1]
                        ? Colors.transparent
                        : AppColor.primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: ischecked[1]
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withOpacity(0.4),
                      width: ischecked[1] ? 6.w : 2.w,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  ischecked[0] = false;
                  ischecked[2] = true;
                  ischecked[1] = false;
                });
              },
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                leading: Text(
                  'Ordo',
                  style: TextStyles.font16BlackSemiBold,
                ),
                trailing: Container(
                  width: 22.w,
                  height: 22.h,
                  decoration: BoxDecoration(
                    color: ischecked[2]
                        ? Colors.transparent
                        : AppColor.primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25.r),
                    border: Border.all(
                      color: ischecked[2]
                          ? AppColor.primaryColor
                          : AppColor.primaryColor.withOpacity(0.4),
                      width: ischecked[2] ? 6.w : 2.w,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
