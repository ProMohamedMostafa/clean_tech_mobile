import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_details_list_build.dart';

class UserManagmentBody extends StatefulWidget {
  const UserManagmentBody({super.key});

  @override
  State<UserManagmentBody> createState() => _UserManagmentBodyState();
}

class _UserManagmentBodyState extends State<UserManagmentBody> {
  int? selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserManagementCubit>().initialize();
    if (role == 'Admin') {
      context.read<UserManagementCubit>().getAllUsersInUserManage();
      context.read<UserManagementCubit>().getAllDeletedUser();
      context.read<UserManagementCubit>().getNationality();
      context.read<UserManagementCubit>().getRole();
      context.read<UserManagementCubit>().getProviders();
    }
    if (role == 'Manager') {
      context.read<UserManagementCubit>().getAllUsersInUserManage();
      context.read<UserManagementCubit>().getNationality();
      context.read<UserManagementCubit>().getRole();
    }
    if (role == 'Supervisor') {
      context.read<UserManagementCubit>().getAllUsersInUserManage();
      context.read<UserManagementCubit>().getNationality();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('User Management'),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: SizedBox(
          height: 57.h,
          width: 57.w,
          child: ElevatedButton(
            onPressed: () {
              context.pushNamed(Routes.addUserScreen);
            },
            style: ElevatedButton.styleFrom(
              padding: REdgeInsets.all(0),
              backgroundColor: AppColor.primaryColor,
              shape: CircleBorder(),
              side: BorderSide(
                color: AppColor.secondaryColor,
                width: 1.w,
              ),
            ),
            child: Icon(
              Icons.person_add,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ),
      ),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is AllUsersErrorState || state is DeletedUsersErrorState) {
            final errorMessage = state is AllUsersErrorState
                ? state.error
                : (state as DeletedUsersErrorState).error;
            toast(text: errorMessage, color: Colors.red);
          } else if (state is ForceDeleteUsersSuccessState ||
              state is UserDeleteSuccessState) {
            final message = (state is ForceDeleteUsersSuccessState)
                ? state.message
                : (state as UserDeleteSuccessState).deleteUserModel.message;
            toast(text: message!, color: Colors.blue);
            context.read<UserManagementCubit>().getAllUsersInUserManage();
            context.read<UserManagementCubit>().getAllDeletedUser();
          }
          if (state is RestoreUsersSuccessState) {
            toast(text: state.message, color: Colors.blue);
          }
          if (state is UserDeleteSuccessState) {
            toast(text: state.deleteUserModel.message!, color: Colors.blue);
            context.read<UserManagementCubit>().getAllDeletedUser();
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled: context.read<UserManagementCubit>().usersModel == null,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    filterAndSearchBuild(
                        context, context.read<UserManagementCubit>()),
                    verticalSpace(15),
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;
                          double gap = 10;
                          double containerWidth = (totalWidth - gap) / 2;

                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (role == 'Admin') ? 2 : 1,
                            separatorBuilder: (context, index) {
                              return SizedBox(width: gap);
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColor.secondaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (role == 'Admin')
                                            ? index == 0
                                                ? "${context.read<UserManagementCubit>().usersModel?.data?.users!.length ?? 0}"
                                                : "${context.read<UserManagementCubit>().deletedListModel?.data?.length ?? 0}"
                                            : "${context.read<UserManagementCubit>().usersModel?.data?.users!.length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        (role == 'Admin')
                                            ? index == 0
                                                ? "Total Users"
                                                : 'Deleted User'
                                            : "Total Users",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Divider(color: Colors.grey[300]),
                    Expanded(
                      child: state is AllUsersLoadingState &&
                              (context.read<UserManagementCubit>().usersModel ==
                                  null)
                          ? Center(
                              child: CircularProgressIndicator(
                                  color: AppColor.primaryColor))
                          : userDetailsBuild(context, selectedIndex!),
                    ),
                    verticalSpace(10),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
