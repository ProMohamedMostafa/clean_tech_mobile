import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/adding_build.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/user_details_build.dart';

class UserManagmentBody extends StatefulWidget {
  const UserManagmentBody({super.key});

  @override
  State<UserManagmentBody> createState() => _UserManagmentBodyState();
}

class _UserManagmentBodyState extends State<UserManagmentBody> {
  @override
  void initState() {
    context.read<UserManagementCubit>().getAllUsersInUserManage();
    context.read<UserManagementCubit>().getAllDeletedUser();
    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text('User Management', style: TextStyles.font16BlackSemiBold),
        centerTitle: true,
      ),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is AllUsersErrorState || state is DeletedUsersErrorState) {
            final errorMessage = state is AllUsersErrorState
                ? state.error
                : (state as DeletedUsersErrorState).error;

            toast(text: errorMessage, color: Colors.red);
          } else if (state is UserDeleteSuccessState) {
            toast(text: state.deleteUserModel.message!, color: Colors.blue);
            context.read<UserManagementCubit>().getAllUsersInUserManage();
            context.read<UserManagementCubit>().getAllDeletedUser();
          } else if (state is RestoreUsersSuccessState) {
            toast(text: state.message, color: Colors.blue);
            context.read<UserManagementCubit>().getAllUsersInUserManage();
            context.read<UserManagementCubit>().getAllDeletedUser();
          }
           else if (state is ForceDeleteUsersSuccessState ||
              state is UserDeleteInDetailsSuccessState) {
            context.read<UserManagementCubit>().getAllUsersInUserManage();
            context.read<UserManagementCubit>().getAllDeletedUser();
          }
        },
        builder: (context, state) {
          if (state is AllUsersLoadingState &&
              state is DeletedUsersLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }
          if (state is AllUsersSuccessState ||
              state is DeletedUsersSuccessState) {
            return SafeArea(
              child: SingleChildScrollView(
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
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: ListView.separated(
                                separatorBuilder: (context, index) {
                                  return horizontalSpace(10);
                                },
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: 2,
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
                                      width: 118.w,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? AppColor.primaryColor
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(8.r),
                                        border: Border.all(
                                          color: AppColor.secondaryColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            index == 0
                                                ? "${context.read<UserManagementCubit>().usersModel?.data?.length ?? 0}"
                                                : "${context.read<UserManagementCubit>().deletedListModel?.data?.length ?? 0}",
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              color: isSelected
                                                  ? Colors.white
                                                  : AppColor.primaryColor,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            index == 0
                                                ? "Total Users"
                                                : 'Deleted User',
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
                              ),
                            ),
                            Expanded(flex: 1, child: addingBuild(context)),
                          ],
                        ),
                      ),
                      verticalSpace(10),
                      Divider(
                        color: Colors.grey[300],
                      ),
                      userDetailsBuild(context, selectedIndex!),
                    ],
                  ),
                ),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        },
      ),
    );
  }
}
