import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class ChooseViewStock extends StatefulWidget {
  const ChooseViewStock({super.key});

  @override
  State<ChooseViewStock> createState() => _ChooseViewStockState();
}

class _ChooseViewStockState extends State<ChooseViewStock> {
  final List<Map<String, dynamic>> items = [
    {'title': 'Category'},
    {'title': 'Material'},
    {'title': 'Transactions'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock'),
        leading: CustomBackButton(),
      ),
      body: SingleChildScrollView(
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
                      title: Text(item['title'],
                          style: TextStyles.font16PrimSemiBold),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: AppColor.primaryColor),
                      onTap: () {
                        index == 0
                            ? context.pushNamed(Routes.categoryScreen)
                            : index == 1
                                ? context.pushNamed(Routes.materialScreen)
                                : context.pushNamed(Routes.transactionScreen);
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
