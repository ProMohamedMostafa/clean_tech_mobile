import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/provider/provider_management/logic/cubit/provider_cubit.dart';

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
        hint: "find provider",
        keyboardType: TextInputType.text,
        onlyRead: false,
        onChanged: (searchedCharacter) {
          cubit.getProviders();
        },
      ),
    );
  }
}
