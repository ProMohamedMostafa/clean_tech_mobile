import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class ChooseViewTask extends StatelessWidget {
  const ChooseViewTask({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': 'My tasks'},
      {'title': 'Received tasks'},
      {'title': 'My team tasks'},
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Tasks'), leading: CustomBackButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColor.secondaryColor)),
                    child: ListTile(
                      minTileHeight: 70,
                      dense: true,
                      leading: Icon(Icons.co_present_rounded,
                          color: AppColor.primaryColor),
                      title: Text(item['title'],
                          style: TextStyles.font16PrimSemiBold),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: AppColor.primaryColor),
                      onTap: () {
                        context.pushNamed(Routes.taskManagementScreen);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
