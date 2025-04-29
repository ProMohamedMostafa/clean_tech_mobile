import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/category_management/logic/category_mangement_cubit.dart';

class FilterAndSearchWidget extends StatelessWidget {
  const FilterAndSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryManagementCubit cubit =
        context.read<CategoryManagementCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormField(
            color: AppColor.secondaryColor,
            perfixIcon: Icon(IconBroken.search),
            controller: cubit.searchController,
            hint: 'Find category',
            keyboardType: TextInputType.text,
            onlyRead: false,
            onChanged: (searchedCharacter) {
              cubit.getCategoryList();
            },
          ),
        ),
        horizontalSpace(10),
        InkWell(
          borderRadius: BorderRadius.circular(10.r),
          onTap: () {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider(
                  create: (context) => FilterDialogCubit()..getCategory(),
                  child: FilterDialogWidget(
                    index: 'S-c',
                    onPressed: (data) {
                      cubit.filterModel = data;
                      cubit.getCategoryList();
                    },
                  ),
                );
              },
            );
          },
          child: Container(
            height: 49.h,
            width: 49.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: AppColor.secondaryColor)),
            child: Icon(
              Icons.tune,
              color: AppColor.primaryColor,
              size: 25.sp,
            ),
          ),
        ),
      ],
    );
  }
}
