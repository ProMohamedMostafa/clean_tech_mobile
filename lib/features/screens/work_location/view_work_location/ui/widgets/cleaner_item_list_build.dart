import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/work_location/work_location_management/logic/work_location_cubit.dart';

Widget cleanerListItemBuild(BuildContext context, index, selectedIndex) {
  List<int> cleanerIds = selectedIndex == 0
      ? context
              .read<WorkLocationCubit>()
              .areaUsersDetailsModel
              ?.data
              ?.users
              ?.where((user) => user.role == 'Cleaner')
              .map((user) => user.id!)
              .toList() ??
          []
      : selectedIndex == 1
          ? context
                  .read<WorkLocationCubit>()
                  .cityUsersDetailsModel
                  ?.data
                  ?.users
                  ?.where((user) => user.role == 'Cleaner')
                  .map((user) => user.id!)
                  .toList() ??
              []
          : selectedIndex == 2
              ? context
                      .read<WorkLocationCubit>()
                      .organizationUsersShiftDetailsModel
                      ?.data
                      ?.users
                      ?.where((user) => user.role == 'Cleaner')
                      .map((user) => user.id!)
                      .toList() ??
                  []
              : selectedIndex == 3
                  ? context
                          .read<WorkLocationCubit>()
                          .buildingUsersShiftDetailsModel
                          ?.data
                          ?.users
                          ?.where((user) => user.role == 'Cleaner')
                          .map((user) => user.id!)
                          .toList() ??
                      []
                  : selectedIndex == 4
                      ? context
                              .read<WorkLocationCubit>()
                              .floorUsersShiftDetailsModel
                              ?.data
                              ?.users
                              ?.where((user) => user.role == 'Cleaner')
                              .map((user) => user.id!)
                              .toList() ??
                          []
                      : selectedIndex == 5
                          ? context
                                  .read<WorkLocationCubit>()
                                  .sectionUsersShiftDetailsModel
                                  ?.data
                                  ?.users
                                  ?.where((user) => user.role == 'Cleaner')
                                  .map((user) => user.id!)
                                  .toList() ??
                              []
                          : context
                                  .read<WorkLocationCubit>()
                                  .pointUsersDetailsModel
                                  ?.data
                                  ?.users
                                  ?.where((user) => user.role == 'Cleaner')
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
      leading: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (contextt) => Scaffold(
                  appBar: AppBar(
                    leading: customBackButton(context),
                  ),
                  body: Center(
                    child: PhotoView(
                      imageProvider: NetworkImage(
                        '${ApiConstants.apiBaseUrl}${selectedIndex == 0 ? context.read<WorkLocationCubit>().areaUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : selectedIndex == 1 ? context.read<WorkLocationCubit>().cityUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : selectedIndex == 2 ? context.read<WorkLocationCubit>().organizationUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : selectedIndex == 3 ? context.read<WorkLocationCubit>().buildingUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : selectedIndex == 4 ? context.read<WorkLocationCubit>().floorUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : selectedIndex == 5 ? context.read<WorkLocationCubit>().sectionUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString() : context.read<WorkLocationCubit>().pointUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image!).toString()}',
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'assets/images/noImage.png',
                          fit: BoxFit.fill,
                        );
                      },
                      backgroundDecoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          child: Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.hardEdge,
            decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
            child: Image.network(
              '${ApiConstants.apiBaseUrl}${selectedIndex == 0 ?
               context.read<WorkLocationCubit>().areaUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() : 
               selectedIndex == 1 ? 
               context.read<WorkLocationCubit>().cityUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() :
                selectedIndex == 2 ? 
               context.read<WorkLocationCubit>().organizationUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() :
                selectedIndex == 3 ?
               context.read<WorkLocationCubit>().buildingUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() :
                selectedIndex == 4 ?
               context.read<WorkLocationCubit>().floorUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() :
                selectedIndex == 5 ?
               context.read<WorkLocationCubit>().sectionUsersShiftDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString() :
               context.read<WorkLocationCubit>().pointUsersDetailsModel!.data!.users?.where((user) => user.role == 'Cleaner').map((user) => user.image).toString()}',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/noImage.png',
                  fit: BoxFit.fill,
                );
              },
            ),
          )),
      title: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Cleaner')
                .map((user) => user.userName!)
                .join(", ")
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Cleaner')
                    .map((user) => user.userName!)
                    .join(", ")
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                        .map((user) => user.userName!)
                        .join(", ")
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Cleaner')
                            .map((user) => user.userName!)
                            .join(", ")
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Cleaner')
                                .map((user) => user.userName!)
                                .join(", ")
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
                                    .map((user) => user.userName!)
                                    .join(", ")
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
                                    .map((user) => user.userName!)
                                    .join(", "),
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<WorkLocationCubit>()
                .areaUsersDetailsModel!
                .data!
                .users!
                .where((user) => user.role == 'Cleaner')
                .map((user) => user.email!)
                .join(", ")
            : selectedIndex == 1
                ? context
                    .read<WorkLocationCubit>()
                    .cityUsersDetailsModel!
                    .data!
                    .users!
                    .where((user) => user.role == 'Cleaner')
                    .map((user) => user.email!)
                    .join(", ")
                : selectedIndex == 2
                    ? context
                        .read<WorkLocationCubit>()
                        .organizationUsersShiftDetailsModel!
                        .data!
                        .users!
                        .where((user) => user.role == 'Cleaner')
                        .map((user) => user.email!)
                        .join(", ")
                    : selectedIndex == 3
                        ? context
                            .read<WorkLocationCubit>()
                            .buildingUsersShiftDetailsModel!
                            .data!
                            .users!
                            .where((user) => user.role == 'Cleaner')
                            .map((user) => user.email!)
                            .join(", ")
                        : selectedIndex == 4
                            ? context
                                .read<WorkLocationCubit>()
                                .floorUsersShiftDetailsModel!
                                .data!
                                .users!
                                .where((user) => user.role == 'Cleaner')
                                .map((user) => user.email!)
                                .join(", ")
                            : selectedIndex == 5
                                ? context
                                    .read<WorkLocationCubit>()
                                    .sectionUsersShiftDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
                                    .map((user) => user.email!)
                                    .join(", ")
                                : context
                                    .read<WorkLocationCubit>()
                                    .pointUsersDetailsModel!
                                    .data!
                                    .users!
                                    .where((user) => user.role == 'Cleaner')
                                    .map((user) => user.email!)
                                    .join(", "),
        style: TextStyles.font12GreyRegular,
      ),
    ),
  );
}
