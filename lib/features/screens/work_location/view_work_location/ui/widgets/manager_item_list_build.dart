import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/work_location/view_work_location/logic/cubit/work_location_details_cubit.dart';

Widget managerListItemBuild(BuildContext context, index, selectedIndex) {
  List<int> cleanerIds = selectedIndex == 0
      ? context
              .read<WorkLocationDetailsCubit>()
              .areaUsersDetailsModel
              ?.data
              ?.users
              ?.where((user) => user.role == 'Manager')
              .map((user) => user.id!)
              .toList() ??
          []
      : selectedIndex == 1
          ? context
                  .read<WorkLocationDetailsCubit>()
                  .cityUsersDetailsModel
                  ?.data
                  ?.users
                  ?.where((user) => user.role == 'Manager')
                  .map((user) => user.id!)
                  .toList() ??
              []
          : selectedIndex == 2
              ? context
                      .read<WorkLocationDetailsCubit>()
                      .organizationUsersShiftDetailsModel
                      ?.data
                      ?.users
                      ?.where((user) => user.role == 'Manager')
                      .map((user) => user.id!)
                      .toList() ??
                  []
              : selectedIndex == 3
                  ? context
                          .read<WorkLocationDetailsCubit>()
                          .buildingUsersShiftDetailsModel
                          ?.data
                          ?.users
                          ?.where((user) => user.role == 'Manager')
                          .map((user) => user.id!)
                          .toList() ??
                      []
                  : selectedIndex == 4
                      ? context
                              .read<WorkLocationDetailsCubit>()
                              .floorUsersShiftDetailsModel
                              ?.data
                              ?.users
                              ?.where((user) => user.role == 'Manager')
                              .map((user) => user.id!)
                              .toList() ??
                          []
                      : selectedIndex == 5
                          ? context
                                  .read<WorkLocationDetailsCubit>()
                                  .sectionUsersShiftDetailsModel
                                  ?.data
                                  ?.users
                                  ?.where((user) => user.role == 'Manager')
                                  .map((user) => user.id!)
                                  .toList() ??
                              []
                          : context
                                  .read<WorkLocationDetailsCubit>()
                                  .pointUsersDetailsModel
                                  ?.data
                                  ?.users
                                  ?.where((user) => user.role == 'Manager')
                                  .map((user) => user.id!)
                                  .toList() ??
                              [];

  return InkWell(
    onTap: () {
      int? cleanerId = cleanerIds.isNotEmpty ? cleanerIds.first : null;
      context.pushNamed(
        Routes.userDetailsScreen,
        arguments: cleanerId,
      );
    },
    child: ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 5),
      minTileHeight: 60.h,
      leading: Container(
        height: 40.h,
        width: 40.w,
        decoration: BoxDecoration(shape: BoxShape.circle),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          '${ApiConstants.apiBaseUrlImage}${selectedIndex == 0 ? context.read<WorkLocationDetailsCubit>().areaUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 1 ? context.read<WorkLocationDetailsCubit>().cityUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 2 ? context.read<WorkLocationDetailsCubit>().organizationUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 3 ? context.read<WorkLocationDetailsCubit>().buildingUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 4 ? context.read<WorkLocationDetailsCubit>().floorUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : selectedIndex == 5 ? context.read<WorkLocationDetailsCubit>().sectionUsersShiftDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString() : context.read<WorkLocationDetailsCubit>().pointUsersDetailsModel!.data!.users!.where((user) => user.role == 'Manager').map((user) => user.image!).toString()}',
          fit: BoxFit.fill,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/person.png',
              fit: BoxFit.fill,
            );
          },
        ),
      ),
      title: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationDetailsCubit>()
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
                .map((user) => user.userName!)
                .join(", ")
            : selectedIndex == 1
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                    .map((user) => user.userName!)
                    .join(", ")
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((user) => user.userName!)
                        .join(", ")
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                            .map((user) => user.userName!)
                            .join(", ")
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                                .map((user) => user.userName!)
                                .join(", ")
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.userName!)
                                    .join(", ")
                                : context
                                    .read<WorkLocationDetailsCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.userName!)
                                    .join(", "),
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationDetailsCubit>()
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Manager')
                .map((user) => user.email!)
                .join(", ")
            : selectedIndex == 1
                ? context
                    .read<WorkLocationDetailsCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Manager')
                    .map((user) => user.email!)
                    .join(", ")
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationDetailsCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Manager')
                        .map((user) => user.email!)
                        .join(", ")
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationDetailsCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Manager')
                            .map((user) => user.email!)
                            .join(", ")
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationDetailsCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Manager')
                                .map((user) => user.email!)
                                .join(", ")
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationDetailsCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.email!)
                                    .join(", ")
                                : context
                                    .read<WorkLocationDetailsCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Manager')
                                    .map((user) => user.email!)
                                    .join(", "),
        style: TextStyles.font12GreyRegular,
      ),
    ),
  );
}
