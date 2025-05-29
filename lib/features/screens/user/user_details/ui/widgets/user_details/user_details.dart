import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/features/screens/user/user_details/ui/widgets/user_details/user_item_details_build.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserDetails extends StatelessWidget {
  const UserDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace(5),
          _buildUserDetails(context),
        ],
      ),
    );
  }

  Widget _buildUserDetails(BuildContext context) {
    final userDetailModel = context.read<UserDetailsCubit>().userDetailsModel!;
    if (userDetailModel.data == null) {
      return Center(
        child: Text(
          S.of(context).noData,
          style: TextStyles.font13Blackmedium,
        ),
      );
    }
    return UserItemDetailsBuild();
  }
}
