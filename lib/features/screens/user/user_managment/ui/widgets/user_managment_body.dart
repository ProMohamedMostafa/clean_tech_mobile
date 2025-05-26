import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/two_buttons_in_integreat_screen/two_buttons_in_integration_screen.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_details_list_build.dart';

class UserManagmentBody extends StatelessWidget {
  const UserManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final UserManagementCubit cubit = context.read<UserManagementCubit>();
    return BlocConsumer<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        // if (state is AllUsersErrorState || state is DeletedUsersErrorState) {
        //   final errorMessage = state is AllUsersErrorState
        //       ? state.error
        //       : (state as DeletedUsersErrorState).error;
        //   toast(text: errorMessage, color: Colors.red);
        // }
        // if (state is ForceDeleteUsersSuccessState) {
        //   toast(text: state.message, color: Colors.blue);
        //   cubit.getAllUsersInUserManage();
        //   cubit.getAllDeletedUser();
        // }
        // if (state is RestoreUsersSuccessState) {
        //   toast(text: state.message, color: Colors.blue);
        // }
        // if (state is UserDeleteSuccessState) {
        //   toast(text: state.deleteUserModel.message!, color: Colors.blue);
        //   cubit.getAllDeletedUser();
        // }

        if (state is UserDeleteSuccessState) {
          toast(text: state.deleteUserModel.message!, color: Colors.blue);
          cubit.getAllDeletedUser();
        }
        if (state is DeletedUsersErrorState) {
          toast(text: state.error, color: Colors.red);
        }
        if (state is RestoreUsersSuccessState) {
          toast(text: state.message, color: Colors.blue);
        }
        if (state is RestoreUsersErrorState) {
          toast(text: state.error, color: Colors.red);
        }
        if (state is ForceDeleteUsersSuccessState) {
          toast(text: state.message, color: Colors.blue);
          cubit.getAllUsersInUserManage();
          cubit.getAllDeletedUser();
        }
      },
      builder: (context, state) {
        return Skeletonizer(
          enabled: (cubit.usersModel == null && cubit.deletedListModel == null),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpace(10),
                FilterAndSearchWidget(),
                verticalSpace(10),
                twoButtonsIntegration(
                  selectedIndex: cubit.selectedIndex,
                  onTap: (index) => cubit.changeTap(index),
                  firstCount: cubit.usersModel?.data?.totalCount ?? 0,
                  firstLabel: 'Total Users',
                  secondCount: cubit.deletedListModel?.data?.length ?? 0,
                  secondLabel: 'Deleted Users',
                ),
                verticalSpace(10),
                Divider(color: Colors.grey[300]),
                Expanded(
                  child: userDetailsBuild(context, cubit.selectedIndex),
                ),
                verticalSpace(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
