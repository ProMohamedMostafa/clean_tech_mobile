import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget managerListItemBuild(BuildContext context, index, selectedIndex) {
  return InkWell(
    onTap: () {
      context.pushNamed(
        Routes.userDetailsScreen,
        arguments: selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaManagersDetailsModel!
                .data!
                .managers![index]
                .id
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityManagersDetailsModel!
                    .data!
                    .managers![index]
                    .id
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationManagersDetailsModel!
                        .data!
                        .managers![index]
                        .id
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingManagersDetailsModel!
                            .data!
                            .managers![index]
                            .id
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorManagersDetailsModel!
                                .data!
                                .managers![index]
                                .id
                            : context
                                .read<WorkLocationCubit>()
                                .pointManagersDetailsModel!
                                .data!
                                .managers![index]
                                .id,
      );
    },
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      minTileHeight: 60.h,
      leading:
          //  Container(
          //   height: 40.h,
          //   width: 40.w,
          //   decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
          // ),

          Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          '${ApiConstants.apiBaseUrl}${selectedIndex == 0 ? context.read<WorkLocationCubit>().areaManagersDetailsModel!.data!.managers![index].image : selectedIndex == 1 ? context.read<WorkLocationCubit>().cityManagersDetailsModel!.data!.managers![index].image : selectedIndex == 2 ? context.read<WorkLocationCubit>().organizationManagersDetailsModel!.data!.managers![index].image : selectedIndex == 3 ? context.read<WorkLocationCubit>().buildingManagersDetailsModel!.data!.managers![index].image : selectedIndex == 4 ? context.read<WorkLocationCubit>().floorManagersDetailsModel!.data!.managers![index].image : context.read<WorkLocationCubit>().pointManagersDetailsModel!.data!.managers![index].image}',
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/noImage.png',
              fit: BoxFit.fill,
            );
          },
        ),
      ),
      title: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaManagersDetailsModel!
                .data!
                .managers![index]
                .userName!
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityManagersDetailsModel!
                    .data!
                    .managers![index]
                    .userName!
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationManagersDetailsModel!
                        .data!
                        .managers![index]
                        .userName!
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingManagersDetailsModel!
                            .data!
                            .managers![index]
                            .userName!
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorManagersDetailsModel!
                                .data!
                                .managers![index]
                                .userName!
                            : context
                                .read<WorkLocationCubit>()
                                .pointManagersDetailsModel!
                                .data!
                                .managers![index]
                                .userName!,
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaManagersDetailsModel!
                .data!
                .managers![index]
                .email!
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityManagersDetailsModel!
                    .data!
                    .managers![index]
                    .email!
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationManagersDetailsModel!
                        .data!
                        .managers![index]
                        .email!
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingManagersDetailsModel!
                            .data!
                            .managers![index]
                            .email!
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorManagersDetailsModel!
                                .data!
                                .managers![index]
                                .email!
                            : context
                                .read<WorkLocationCubit>()
                                .pointManagersDetailsModel!
                                .data!
                                .managers![index]
                                .email!,
        style: TextStyles.font12GreyRegular,
      ),
    ),
  );
}
