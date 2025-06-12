import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class ChooseViewWorkLocation extends StatefulWidget {
  const ChooseViewWorkLocation({super.key});

  @override
  State<ChooseViewWorkLocation> createState() => _ChooseViewWorkLocationState();
}

class _ChooseViewWorkLocationState extends State<ChooseViewWorkLocation> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Area', 'icon': Icons.map},
    {'title': 'City', 'icon': Icons.location_city},
    {'title': 'Organizations', 'icon': Icons.business},
    {'title': 'Building', 'icon': Icons.home_work},
    {'title': 'Floor', 'icon': Icons.house},
    {'title': 'Section', 'icon': Icons.stairs},
    {'title': 'Point', 'icon': Icons.place},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Work Location',
        ),
        leading: CustomBackButton(),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(20),
              Text(
                'Select To View',
                style: TextStyles.font16BlackRegular,
              ),
              verticalSpace(10),
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
                            ? context.pushNamed(Routes.workLocationScreen,
                                arguments: index)
                            : index == 1
                                ? context.pushNamed(Routes.workLocationScreen,
                                    arguments: index)
                                : index == 2
                                    ? context.pushNamed(
                                        Routes.workLocationScreen,
                                        arguments: index)
                                    : index == 3
                                        ? context.pushNamed(
                                            Routes.workLocationScreen,
                                            arguments: index)
                                        : index == 4
                                            ? context.pushNamed(
                                                Routes.workLocationScreen,
                                                arguments: index)
                                            : index == 5
                                                ? context.pushNamed(
                                                    Routes.workLocationScreen,
                                                    arguments: index)
                                                : context.pushNamed(
                                                    Routes.workLocationScreen,
                                                    arguments: index);
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
