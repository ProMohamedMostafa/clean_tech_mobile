import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_text_form_field/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/provider/provider_management/logic/cubit/provider_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SearchProviderWidget extends StatelessWidget {
  const SearchProviderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProviderCubit>();

    return SizedBox(
      height: 60.h,
      width: double.infinity,
      child: CustomTextFormField(
        color: AppColor.secondaryColor,
        perfixIcon: Icon(IconBroken.search),
        controller: cubit.searchController,
        hint: S.of(context).findProvider,
        keyboardType: TextInputType.text,
        onlyRead: false,
        onChanged: (searchedCharacter) {
          cubit.getProviders();
        },
      ),
    );
  }
}
