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
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
                .map((user) => user.id!)
                .toString()
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                    .map((user) => user.id!)
                    .toString()
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((user) => user.id!)
                        .toString()
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                            .map((user) => user.id!)
                            .toString()
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                                .map((user) => user.id!)
                                .toString()
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.id!)
                                    .toString()
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.id!)
                                    .toString(),
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
          '${ApiConstants.apiBaseUrl}${selectedIndex == 0 ? context.read<WorkLocationCubit>().areaUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 1 ? context.read<WorkLocationCubit>().cityUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 2 ? context.read<WorkLocationCubit>().organizationUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 3 ? context.read<WorkLocationCubit>().buildingUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 4 ? context.read<WorkLocationCubit>().floorUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 5 ? context.read<WorkLocationCubit>().sectionUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : context.read<WorkLocationCubit>().pointUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString()}',
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
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
                .map((user) => user.userName!)
                .toString()
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                    .map((user) => user.userName!)
                    .toString()
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((user) => user.userName!)
                        .toString()
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                            .map((user) => user.userName!)
                            .toString()
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                                .map((user) => user.userName!)
                                .toString()
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.userName!)
                                    .toString()
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.userName!)
                                    .toString(),
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
                .map((user) => user.email!)
                .toString()
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                    .map((user) => user.email!)
                    .toString()
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((user) => user.email!)
                        .toString()
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                            .map((user) => user.email!)
                            .toString()
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                                .map((user) => user.email!)
                                .toString()
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.email!)
                                    .toString()
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.email!)
                                    .toString(),
        style: TextStyles.font12GreyRegular,
      ),
    ),
  );
}
