import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/filter/logic/cubit/filter_dialog_cubit.dart';

class BatterySlider extends StatelessWidget {
  const BatterySlider({super.key});
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FilterDialogCubit>();
    final range = cubit.currentRange;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          " ${range.start.round()}",
          style: TextStyles.font13PrimRegular,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              overlayShape: SliderComponentShape.noOverlay,
              rangeThumbShape:
                  const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
              showValueIndicator: ShowValueIndicator.never,
              rangeValueIndicatorShape:
                  const PaddleRangeSliderValueIndicatorShape(),
            ),
            child: RangeSlider(
              values: range,
              min: 0,
              max: 100,
              divisions: 100,
              labels: RangeLabels(
                range.start.round().toString(),
                range.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                cubit.updateRange(values);
              },
              activeColor: AppColor.primaryColor,
              inactiveColor: AppColor.primaryColor.withOpacity(0.4),
            ),
          ),
        ),
        Text(
          " ${range.end.round()}",
          style: TextStyles.font13PrimRegular,
        ),
      ],
    );
  }
}
