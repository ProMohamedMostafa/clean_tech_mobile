import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/core/widgets/filter/ui/screen/filter_dialog_widget.dart';
import 'package:smart_cleaning_application/features/screens/sensor/sensor_managment/logic/cubit/sensor_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class SensorFilterAndSearchWidget extends StatelessWidget {
  const SensorFilterAndSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SensorCubit>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: CustomTextFormField(
            color: AppColor.secondaryColor,
            perfixIcon: Icon(IconBroken.search),
            controller: cubit.searchController,
            hint: S.of(context).sensorHint,
            keyboardType: TextInputType.text,
            onlyRead: false,
            onChanged: (searchedCharacter) {
              cubit.getSensorsData();
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
                  create: (context) => FilterDialogCubit()
                    ..getCity()
                    ..getActivityType(),
                  child: FilterDialogWidget(
                    index: 'Se',
                    onPressed: (data) {
                      cubit.filterModel = data;
                      cubit.getSensorsData();
                    },
                  ),
                );
              },
            );
          },
          child: Container(
            height: 47.h,
            width: 49.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
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
