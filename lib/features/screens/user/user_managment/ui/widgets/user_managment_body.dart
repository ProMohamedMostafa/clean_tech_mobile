import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/constants/constants.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/widgets/default_toast/default_toast.dart';
import 'package:smart_cleaning_application/core/widgets/integration_buttons/integrations_buttons.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/logic/user_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/user/user_managment/ui/widgets/user_details_list_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserManagmentBody extends StatelessWidget {
  const UserManagmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserManagementCubit>();
    return BlocConsumer<UserManagementCubit, UserManagementState>(
      listener: (context, state) {
        if (state is UserDeleteSuccessState) {
          toast(text: state.deleteUserModel.message!, color: Colors.blue);
          cubit.getAllDeletedUser();
        }
        if (state is UserDeleteErrorState) {
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
        if (state is ForceDeleteUsersErrorState) {
          toast(text: state.error, color: Colors.red);
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
    );
  }
}
