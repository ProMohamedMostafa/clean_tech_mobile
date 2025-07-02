import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/work_location/select_work_location_view/logic/cubit/choose_view_work_location_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ChooseViewWorkLocation extends StatelessWidget {
  const ChooseViewWorkLocation({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {'title': S.of(context).Area, 'icon': Icons.map, 'data': 'A'},
      {'title': S.of(context).City, 'icon': Icons.location_city, 'data': 'C'},
      {
        'title': S.of(context).Organization,
        'icon': Icons.business,
        'data': 'O'
      },
      {'title': S.of(context).Building, 'icon': Icons.home_work, 'data': 'B'},
      {'title': S.of(context).Floor, 'icon': Icons.house, 'data': 'F'},
      {'title': S.of(context).Section, 'icon': Icons.stairs, 'data': 'S'},
      {'title': S.of(context).Point, 'icon': Icons.place, 'data': 'P'},
    ];
    return BlocBuilder<ChooseViewWorkLocationCubit,
        ChooseViewWorkLocationState>(
      builder: (context, state) {
        final data = context
            .read<ChooseViewWorkLocationCubit>()
            .chooseViewWorkLocationModel
            ?.data;
        final dataIndexMap = {
          'A': 0,
          'C': 1,
          'O': 2,
          'B': 3,
          'F': 4,
          'S': 5,
          'P': 6,
        };
        final startIndex = dataIndexMap[data] ?? 0;
        final filteredItems = items.sublist(startIndex);
        return Skeletonizer(
          enabled: context
                  .read<ChooseViewWorkLocationCubit>()
                  .chooseViewWorkLocationModel ==
              null,
          child: Scaffold(
            appBar: AppBar(
                title: Text(S.of(context).workLocation),
                leading: CustomBackButton()),
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
                      itemCount: filteredItems.length,
                      separatorBuilder: (context, index) => verticalSpace(10),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        final originalIndex = startIndex + index;

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColor.secondaryColor),
                          ),
                          child: ListTile(
                            minTileHeight: 70,
                            dense: true,
                            leading: Icon(item['icon'],
                                color: AppColor.primaryColor),
                            title: Text(item['title'],
                                style: TextStyles.font16PrimSemiBold),
                            trailing: Icon(Icons.arrow_forward_ios,
                                color: AppColor.primaryColor),
                            onTap: () {
                              context.pushNamed(Routes.workLocationScreen,
                                  arguments: originalIndex);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
