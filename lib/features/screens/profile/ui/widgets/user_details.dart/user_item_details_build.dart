import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/profile/logic/profile_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class UserItemDetailsBuild extends StatelessWidget {
  const UserItemDetailsBuild({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = context.read<ProfileCubit>().profileModel!;

    return Column(
      children: [
        rowDetailsBuild(
            context, S.of(context).addUserText5, userModel.data!.userName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText1, userModel.data!.firstName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText2, userModel.data!.lastName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText3, userModel.data!.email!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText10, userModel.data!.phoneNumber!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText4, userModel.data!.birthdate!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText7, userModel.data!.idNumber!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(context, S.of(context).addUserText8,
            userModel.data!.nationalityName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText12, userModel.data!.countryName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText9, userModel.data!.genderName!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
            context, S.of(context).addUserText13, userModel.data!.role!),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
          context,
          S.of(context).addUserText14,
          userModel.data!.managerName ?? S.of(context).noManager,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
        rowDetailsBuild(
          context,
          S.of(context).addUserText15,
          userModel.data!.providerName ?? S.of(context).noProvider,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Divider(),
        ),
      ],
    );
  }
}
