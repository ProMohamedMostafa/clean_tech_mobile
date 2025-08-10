import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/core/widgets/floating_action_button/floating_action_button.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/core/widgets/filter_and_search_build/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/ui/widgets/pdf.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_managment/ui/widgets/user_details_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserManagmentBody extends StatelessWidget {
  const UserManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserManagementCubit>();
    return Scaffold(
      appBar: AppBar(
          leading: CustomBackButton(),
          title: Text(S.of(context).userManagement),
          actions: [
            IconButton(
              onPressed: () => createPDF(context),
              icon: Icon(
                CupertinoIcons.tray_arrow_down,
                color: Colors.red,
                size: 22.sp,
              ),
            ),
            horizontalSpace(10)
          ]),
      floatingActionButton: role == 'Admin'
          ? floatingActionButton(
              icon: Icons.person_add,
              onPressed: () async {
                final result = await context.pushNamed(Routes.addUserScreen);

                if (result == true) {
                  cubit.refreshUsers();
                }
              },
            )
          : SizedBox.shrink(),
      body: BlocConsumer<UserManagementCubit, UserManagementState>(
        listener: (context, state) {
          if (state is UserDeleteSuccessState) {
            toast(text: state.deleteUserModel.message!, isSuccess: true);
            cubit.getAllDeletedUser();
          }
          if (state is UserDeleteErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is RestoreUsersSuccessState) {
            toast(text: state.message, isSuccess: true);
          }
          if (state is RestoreUsersErrorState) {
            toast(text: state.error, isSuccess: false);
          }
          if (state is ForceDeleteUsersSuccessState) {
            toast(text: state.message, isSuccess: true);
            cubit.getAllUsers();
            cubit.getAllDeletedUser();
          }
          if (state is ForceDeleteUsersErrorState) {
            toast(text: state.error, isSuccess: false);
          }
        },
        builder: (context, state) {
          return Skeletonizer(
            enabled:
                (cubit.usersModel == null && cubit.deletedListModel == null),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(10),
                  FilterAndSearchWidget(
                    hintText: S.of(context).findSomeone,
                    searchController: cubit.searchController,
                    onSearchChanged: (value) {
                      cubit.getAllUsers();
                    },
                    onFilterTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return BlocProvider(
                            create: (context) => FilterDialogCubit()
                              ..getCountry(true, false)
                              ..getRole()
                              ..getProviders(),
                            child: FilterDialogWidget(
                              index: 'U',
                              onPressed: (data) {
                                cubit.filterModel = data;
                                cubit.getAllUsers();
                              },
                            ),
                          );
                        },
                      );
                    },
                    isFilterActive: cubit.filterModel != null,
                    onClearFilter: () {
                      cubit.filterModel = null;
                      cubit.searchController.clear();
                      cubit.getAllUsers();
                    },
                  ),
                  verticalSpace(10),
                  integrationsButtons(
                    selectedIndex: cubit.selectedIndex,
                    onTap: (index) => cubit.changeTap(index),
                    firstCount: cubit.usersModel?.data?.totalCount ?? 0,
                    firstLabel: S.of(context).totalUsers,
                    secondCount: role == 'Admin'
                        ? cubit.deletedListModel?.data?.length ?? 0
                        : null,
                    secondLabel:
                        role == 'Admin' ? S.of(context).deletedUsers : null,
                  ),
                  verticalSpace(10),
                  Divider(color: Colors.grey[300], height: 0),
                  Expanded(child: UserDetailsList()),
                  verticalSpace(10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
