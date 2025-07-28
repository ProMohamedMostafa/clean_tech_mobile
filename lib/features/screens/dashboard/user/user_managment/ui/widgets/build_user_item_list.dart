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
import 'package:smart_cleaning_application/core/widgets/pop_up_message/pop_up_message.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/logic/user_mangement_cubit.dart';

class BuildUserItemList extends StatelessWidget {
  final int index;
  const BuildUserItemList({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserManagementCubit>();
    return InkWell(
      onTap: () async {
        if (cubit.selectedIndex == 0) {
          final result = await context.pushNamed(
            Routes.userDetailsScreen,
            arguments: cubit.usersModel!.data!.users![index].id,
          );
          if (result == true) {
            await cubit.refreshUsers();
          }
        }
      },
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 5),
        minTileHeight: 60.h,
        dense: true,
        leading: Container(
          height: 40.h,
          width: 40.w,
          decoration: BoxDecoration(shape: BoxShape.circle),
          clipBehavior: Clip.hardEdge,
          child: Image.network(
            cubit.selectedIndex == 0
                ? '${cubit.usersModel!.data!.users![index].image}'
                : '${cubit.deletedListModel!.data![index].image}',
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
          cubit.selectedIndex == 0
              ? '${cubit.usersModel!.data!.users![index].firstName!} ${cubit.usersModel!.data!.users![index].lastName!}'
              : '${cubit.deletedListModel!.data![index].firstName!} ${cubit.deletedListModel!.data![index].lastName!}',
          style: TextStyles.font14BlackSemiBold,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          cubit.selectedIndex == 0
              ? cubit.usersModel!.data!.users![index].email!
              : cubit.deletedListModel!.data![index].email!,
          style: TextStyles.font12GreyRegular,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        trailing: (role == 'Admin')
            ? (cubit.selectedIndex == 0 &&
                    uId == cubit.usersModel!.data!.users![index].id)
                ? SizedBox.shrink()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () async {
                          if (cubit.selectedIndex == 0) {
                            final result = await context.pushNamed(
                              Routes.editUserScreen,
                              arguments:
                                  cubit.usersModel!.data!.users![index].id,
                            );

                            if (result == true) {
                              await cubit.refreshUsers();
                            }
                          } else {
                            showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return PopUpMessage(
                                      title: 'restore',
                                      body: 'user',
                                      onPressed: () {
                                        cubit.restoreDeletedUser(
                                          cubit.deletedListModel!.data![index]
                                              .id!,
                                        );
                                      });
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            cubit.selectedIndex == 0
                                ? Icons.mode_edit_outlined
                                : Icons.replay_outlined,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ),
                      horizontalSpace(12),
                      InkWell(
                        onTap: () {
                          if (cubit.selectedIndex == 0) {
                            showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return PopUpMessage(
                                      title: 'delete',
                                      body: 'user',
                                      onPressed: () {
                                        cubit.userDelete(cubit.usersModel!.data!
                                            .users![index].id!);
                                      });
                                });
                          } else {
                            showDialog(
                                context: context,
                                builder: (dialogContext) {
                                  return PopUpMessage(
                                      title: 'delete',
                                      body: 'user',
                                      onPressed: () {
                                        cubit.forcedDeletedUser(cubit
                                            .deletedListModel!
                                            .data![index]
                                            .id!);
                                      });
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(3),
                          child: Icon(
                            IconBroken.delete,
                            color: Colors.red,
                            size: 24.sp,
                          ),
                        ),
                      ),
                    ],
                  )
            : SizedBox.shrink(),
      ),
    );
  }
}
