import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  return InkWell(
    onTap: () {
      context.pushNamed(
        Routes.userDetailsScreen,
        arguments: context
            .read<UserManagementCubit>()
            .usersModel!
            .data!
            .users![index]
            .id,
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
          selectedIndex == 0
              ? '${ApiConstants.apiBaseUrlImage}${context.read<UserManagementCubit>().usersModel!.data!.users![index].image}'
              : '${ApiConstants.apiBaseUrlImage}${context.read<UserManagementCubit>().deletedListModel!.data![index].image}',
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
                .read<UserManagementCubit>()
                .usersModel!
                .data!
                .users![index]
                .userName!
            : context
                .read<UserManagementCubit>()
                .deletedListModel!
                .data![index]
                .userName!,
        style: TextStyles.font14BlackSemiBold,
      ),
      subtitle: Text(
        selectedIndex == 0
            ? context
                .read<UserManagementCubit>()
                .usersModel!
                .data!
                .users![index]
                .email!
            : context
                .read<UserManagementCubit>()
                .deletedListModel!
                .data![index]
                .email!,
        style: TextStyles.font12GreyRegular,
      ),
      trailing: (role == 'Admin')
          ? (selectedIndex == 0 &&
                  uId ==
                      context
                          .read<UserManagementCubit>()
                          .usersModel!
                          .data!
                          .users![index]
                          .id)
              ? SizedBox.shrink()
              : SizedBox(
                  width: 80.w,
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            selectedIndex == 0
                                ? context.pushNamed(
                                    Routes.editUserScreen,
                                    arguments: context
                                        .read<UserManagementCubit>()
                                        .usersModel!
                                        .data!
                                        .users![index]
                                        .id,
                                  )
                                : showCustomDialog(context,
                                    "Are you Sure to restore this user ?", () {
                                    context
                                        .read<UserManagementCubit>()
                                        .restoreDeletedUser(
                                          context
                                              .read<UserManagementCubit>()
                                              .deletedListModel!
                                              .data![index]
                                              .id!,
                                        );
                                    context.pop();
                                  });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              selectedIndex == 0
                                  ? Icons.mode_edit_outlined
                                  : Icons.replay_outlined,
                              color: AppColor.thirdColor,
                            ),
                          )),
                      horizontalSpace(10),
                      InkWell(
                          onTap: () {
                            selectedIndex == 0
                                ? showCustomDialog(
                                    context, S.of(context).deleteMessage, () {
                                    context
                                        .read<UserManagementCubit>()
                                        .userDelete(context
                                            .read<UserManagementCubit>()
                                            .usersModel!
                                            .data!
                                            .users![index]
                                            .id!);
                                    context.pop();
                                  })
                                : showCustomDialog(
                                    context, "Forced Delete this user", () {
                                    context
                                        .read<UserManagementCubit>()
                                        .forcedDeletedUser(context
                                            .read<UserManagementCubit>()
                                            .deletedListModel!
                                            .data![index]
                                            .id!);
                                    context.pop();
                                  });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Icon(
                              IconBroken.delete,
                              color: AppColor.thirdColor,
                            ),
                          )),
                    ],
                  ),
                )
          : SizedBox.shrink(),
    ),
  );
}
