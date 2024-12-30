import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/pop_up_dialog/show_custom_dialog.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

Widget organizationsListItemBuild(BuildContext context, selectedIndex, index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      InkWell(
        onTap: () {
          // context.pushNamed(
          //   Routes.userDetailsScreen,
          //   arguments:
          //       context.read<OrganizationsCubit>().usersModel!.data![index].id,
          // );
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
                  "Ai Cloud",
                  // selectedIndex == 0
                  //     ? context
                  //         .read<OrganizationsCubit>()
                  //         .usersModel!
                  //         .data![index]
                  //         .userName!
                  //     : context
                  //         .read<OrganizationsCubit>()
                  //         .deletedListModel!
                  //         .data![index]
                  //         .userName!,
                  style: TextStyles.font14BlackSemiBold,
                ),
                Text(
                  "8 floors",
                  // selectedIndex == 0
                  //     ? context
                  //         .read<OrganizationsCubit>()
                  //         .usersModel!
                  //         .data![index]
                  //         .email!
                  //     : context
                  //         .read<OrganizationsCubit>()
                  //         .deletedListModel!
                  //         .data![index]
                  //         .email!,
                  style: TextStyles.font12GreyRegular,
                ),
              ],
            ),
          ],
        ),
      ),
      Spacer(),
      // (selectedIndex == 0 &&
      //         uId ==
      //             context
      //                 .read<OrganizationsCubit>()
      //                 .usersModel!
      //                 .data![index]
      //                 .id)
      //     ? SizedBox.shrink()
      //     :
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                // selectedIndex == 0
                //     ? context.pushNamed(
                //         Routes.editUserScreen,
                //         arguments: context
                //             .read<OrganizationsCubit>()
                //             .usersModel!
                //             .data![index]
                //             .id,
                //       )
                //     :
                showCustomDialog(context, "Are you Sure to restore this user ?",
                    () {
                  // context
                  //     .read<OrganizationsCubit>()
                  //     .restoreDeletedUser(
                  //       context
                  //           .read<OrganizationsCubit>()
                  //           .deletedListModel!
                  //           .data![index]
                  //           .id!,
                  //     );
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
                    ? showCustomDialog(context, S.of(context).deleteMessage,
                        () {
                        // context.read<OrganizationsCubit>().userDelete(
                        //     context
                        //         .read<OrganizationsCubit>()
                        //         .usersModel!
                        //         .data![index]
                        //         .id!);
                        context.pop();
                      })
                    : showCustomDialog(context, "Forced Delete this user", () {
                        // context
                        //     .read<OrganizationsCubit>()
                        //     .forcedDeletedUser(context
                        //         .read<OrganizationsCubit>()
                        //         .deletedListModel!
                        //         .data![index]
                        //         .id!);
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
