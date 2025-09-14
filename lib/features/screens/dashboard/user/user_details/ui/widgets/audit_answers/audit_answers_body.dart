import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/user/user_details/logic/cubit/user_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AuditAnswersUserBody extends StatelessWidget {
  const AuditAnswersUserBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserDetailsCubit>();
    return BlocBuilder<UserDetailsCubit, UserDetailsState>(
      builder: (context, state) {
        final data = cubit.auditorsModel?.data?.data;

        return Scaffold(
          body: (data == null || data.isEmpty)
              ? Center(
                  child: Text(
                    S.of(context).noData,
                    style: TextStyles.font13Blackmedium,
                  ),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => verticalSpace(10),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return InkWell(
                      borderRadius: BorderRadius.circular(11.r),
                      onTap: () {
                        context.pushNamed(Routes.auditorAnswerDetailsScreen,
                            arguments: item.id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(11.r),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        rowDetailsBuild(
                                          S.of(context).answer,
                                          '${item.completedQuestionCount} ${S.of(context).outOf} ${item.totalQuestionCount}',
                                        ),
                                        verticalSpace(5),
                                        rowDetailsBuild(S.of(context).date,
                                            item.date ?? '--'),
                                        verticalSpace(5),
                                        rowDetailsBuild(S.of(context).time,
                                            item.time ?? '--'),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1.w,
                                  color: Colors.grey[300],
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Icon(Icons.remove_red_eye_rounded,
                                      color: AppColor.primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }

  Widget rowDetailsBuild(
    String leadingTitle,
    String suffixTitle, {
    Color? color,
    IconData? icon,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leadingTitle,
          style: TextStyles.font13Blackmedium,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              suffixTitle,
              style: TextStyles.font13Blackmedium.copyWith(
                color: color ?? AppColor.primaryColor,
              ),
            ),
            if (icon != null) ...[
              Icon(
                icon,
                color: color,
                size: 17.sp,
              ),
            ],
          ],
        ),
      ],
    );
  }
}
