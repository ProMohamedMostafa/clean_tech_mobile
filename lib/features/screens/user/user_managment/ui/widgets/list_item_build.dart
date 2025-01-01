import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          context.pushNamed(
            Routes.userDetailsScreen,
            arguments:
                context.read<UserManagementCubit>().usersModel!.data![index].id,
          );
        },
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/profile.png',
                width: 45.w,
                height: 45.h,
              ),
            ),
            horizontalSpace(10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  selectedIndex == 0
                      ? context
                          .read<UserManagementCubit>()
                          .usersModel!
                          .data![index]
                          .userName!
                      : context
                          .read<UserManagementCubit>()
                          .deletedListModel!
                          .data![index]
                          .userName!,
                  style: TextStyles.font14BlackSemiBold,
                ),
                Text(
                  selectedIndex == 0
                      ? context
                          .read<UserManagementCubit>()
                          .usersModel!
                          .data![index]
                          .email!
                      : context
                          .read<UserManagementCubit>()
                          .deletedListModel!
                          .data![index]
                          .email!,
                  style: TextStyles.font12GreyRegular,
                ),
              ],
            ),
          ],
        ),
      ),
      Spacer(),
      (selectedIndex == 0 &&
              uId ==
                  context
                      .read<UserManagementCubit>()
                      .usersModel!
                      .data![index]
                      .id)
          ? SizedBox.shrink()
          : Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      selectedIndex == 0
                          ? context.pushNamed(
                              Routes.editUserScreen,
                              arguments: context
                                  .read<UserManagementCubit>()
                                  .usersModel!
                                  .data![index]
                                  .id,
                            )
                          : showCustomDialog(
                              context, "Are you Sure to restore this user ?",
                              () {
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
                    child: Icon(
                      selectedIndex == 0
                          ? Icons.mode_edit_outlined
                          : Icons.replay_outlined,
                      color: AppColor.thirdColor,
                    )),
                horizontalSpace(10),
                InkWell(
                    onTap: () {
                      selectedIndex == 0
                          ? showCustomDialog(
                              context, S.of(context).deleteMessage, () {
                              context.read<UserManagementCubit>().userDelete(
                                  context
                                      .read<UserManagementCubit>()
                                      .usersModel!
                                      .data![index]
                                      .id!);
                              context.pop();
                            })
                          : showCustomDialog(context, "Forced Delete this user",
                              () {
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
                    child: Icon(
                      IconBroken.delete,
                      color: AppColor.thirdColor,
                    )),
              ],
            )
    ],
  );
}
