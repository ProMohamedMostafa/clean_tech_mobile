import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class AssignBody extends StatefulWidget {
  const AssignBody({super.key});

  @override
  State<AssignBody> createState() => _AssignBodyState();
}

class _AssignBodyState extends State<AssignBody> {
  int? selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('Assign Management', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(2, (index) {
                bool isSelected = selectedIndex == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: Container(
                    height: 45.h,
                    width: 150.w,
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColor.primaryColor : Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColor.secondaryColor,
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        index == 0 ? "User-Organization" : 'Organization-shift',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color:
                              isSelected ? Colors.white : AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            verticalSpace(10),
            Divider(
              color: Colors.grey[300],
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
