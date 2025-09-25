import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/home/logic/home_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class FeedbackOverview extends StatelessWidget {
  const FeedbackOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<HomeCubit>();
    final model = cubit.shiftsCountModel;
    final isLoading = model == null || model.data == null;
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: ListTile(
          minTileHeight: 70.h,
          dense: true,
          title: Text(S.of(context).feedback_overview,
              style: TextStyles.font16PrimSemiBold),
          trailing: Icon(Icons.arrow_forward_ios, color: AppColor.primaryColor),
          onTap: () => context.pushNamed(Routes.feedbackOverviewScreen),
        ),
      ),
    );
  }
}
