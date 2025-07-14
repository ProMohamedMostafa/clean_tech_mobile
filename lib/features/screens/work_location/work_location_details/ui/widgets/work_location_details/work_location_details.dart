import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/logic/cubit/work_location_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_details/ui/widgets/work_location_details/work_location_tree.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class WorkLocationDetails extends StatelessWidget {
  final int selectedIndex;
  const WorkLocationDetails({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<WorkLocationDetailsCubit>();

    dynamic workLocationDetailsModel;

    switch (selectedIndex) {
      case 0:
        workLocationDetailsModel = cubit.areaUsersDetailsModel?.data;
        break;
      case 1:
        workLocationDetailsModel = cubit.cityUsersDetailsModel?.data;
        break;
      case 2:
        workLocationDetailsModel =
            cubit.organizationUsersShiftDetailsModel?.data;
        break;
      case 3:
        workLocationDetailsModel = cubit.buildingUsersShiftDetailsModel?.data;
        break;
      case 4:
        workLocationDetailsModel = cubit.floorUsersShiftDetailsModel?.data;
        break;
      case 5:
        workLocationDetailsModel = cubit.sectionUsersShiftDetailsModel?.data;
        break;
      case 6:
        workLocationDetailsModel = cubit.pointUsersDetailsModel?.data;
        break;
      default:
        workLocationDetailsModel = null;
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          rowDetailsBuild(context, S.of(context).country,
              workLocationDetailsModel.countryName!),
          Divider(),
          if (selectedIndex >= 0) ...[
            rowDetailsBuild(
                context,
                S.of(context).Area,
                selectedIndex == 0
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.areaName!,
                color: selectedIndex == 0 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 1) ...[
            rowDetailsBuild(
                context,
                S.of(context).City,
                selectedIndex == 1
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.cityName!,
                color: selectedIndex == 1 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 2) ...[
            rowDetailsBuild(
                context,
                S.of(context).Organization,
                selectedIndex == 2
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.organizationName!,
                color: selectedIndex == 2 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 3) ...[
            rowDetailsBuild(
                context,
                S.of(context).Building,
                selectedIndex == 3
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.buildingName!,
                color: selectedIndex == 3 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 4) ...[
            rowDetailsBuild(
                context,
                S.of(context).Floor,
                selectedIndex == 4
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.floorName!,
                color: selectedIndex == 4 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 5) ...[
            rowDetailsBuild(
                context,
                S.of(context).Section,
                selectedIndex == 5
                    ? workLocationDetailsModel.name!
                    : workLocationDetailsModel.sectionName!,
                color: selectedIndex == 5 ? AppColor.primaryColor : null),
            Divider(),
          ],
          if (selectedIndex >= 6) ...[
            rowDetailsBuild(
                context, S.of(context).Point, workLocationDetailsModel.name!,
                color: selectedIndex == 6 ? AppColor.primaryColor : null),
            Divider(),
            if (cubit.pointUsersDetailsModel?.data?.isCountable == true) ...[
              rowDetailsBuild(
                context,
                S.of(context).capacity,
                cubit.pointUsersDetailsModel!.data!.capacity!.toString(),
              ),
              Divider(),
              rowDetailsBuild(
                context,
                S.of(context).unitTitle,
                cubit.pointUsersDetailsModel!.data!.unit ?? '__',
              ),
              Divider(),
            ],
            if (cubit.pointUsersDetailsModel!.data!.deviceName != null) ...[
              rowDetailsBuild(context, S.of(context).device,
                  cubit.pointUsersDetailsModel!.data!.deviceName!),
              Divider()
            ]
          ],
          if (selectedIndex >= 3) ...[
            Text(
              S.of(context).description,
              style: TextStyles.font14GreyRegular.copyWith(color: Colors.black),
            ),
            verticalSpace(5),
            Text(
              workLocationDetailsModel.description!,
              overflow: TextOverflow.ellipsis,
              maxLines: cubit.descTextShowFlag ? 40 : 3,
              style: TextStyles.font14GreyRegular,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: InkWell(
                  borderRadius: BorderRadius.circular(5.r),
                  onTap: () {
                    cubit.toggleDescText();
                  },
                  child: cubit.descTextShowFlag
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            S.of(context).ReadLessButton,
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            S.of(context).ReadMoreButton,
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                          ),
                        )),
            ),
            Divider(),
          ],
          WorkLocationTree(
            selectedIndex: selectedIndex,
          )
        ],
      ),
    );
  }
}
