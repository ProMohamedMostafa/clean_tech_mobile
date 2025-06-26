import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ChooseViewWorkLocation extends StatefulWidget {
  const ChooseViewWorkLocation({super.key});

  @override
  State<ChooseViewWorkLocation> createState() => _ChooseViewWorkLocationState();
}

class _ChooseViewWorkLocationState extends State<ChooseViewWorkLocation> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': S.of(context).Area, 'icon': Icons.map},
      {'title': S.of(context).City, 'icon': Icons.location_city},
      {'title': S.of(context).Organization, 'icon': Icons.business},
      {'title': S.of(context).Building, 'icon': Icons.home_work},
      {'title': S.of(context).Floor, 'icon': Icons.house},
      {'title': S.of(context).Section, 'icon': Icons.stairs},
      {'title': S.of(context).Point, 'icon': Icons.place},
    ];
    return Scaffold(
      appBar: AppBar(
          title: Text(S.of(context).workLocation), leading: CustomBackButton()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
      ),
    );
  }
}
