import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';

Widget listItemBuild(BuildContext context, selectedIndex, index) {
  String getDateOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  final List<int> typeId = [0, 1];
  final List<Color> statusColor = [
    Colors.green,
    Colors.red,
  ];
  int tsransactionType;
  Color statusColorForType;

  tsransactionType = selectedIndex == 0
      ? context
          .read<TransactionManagementCubit>()
          .transactionManagementModel!
          .data
          .data[index]
          .typeId
      : selectedIndex == 1
          ? context
              .read<TransactionManagementCubit>()
              .transactionManagementModel!
              .data
              .data
              .where((type) => type.typeId == 0)
              .toList()[index]
              .typeId
          : context
              .read<TransactionManagementCubit>()
              .transactionManagementModel!
              .data
              .data
              .where((type) => type.typeId == 1)
              .toList()[index]
              .typeId;

  if (typeId.contains(tsransactionType)) {
    statusColorForType = statusColor[typeId.indexOf(tsransactionType)];
  } else {
    statusColorForType = Colors.black;
  }
  return InkWell(
    borderRadius: BorderRadius.circular(11.r),
    onTap: () {
      selectedIndex == 0
          ? context.pushNamed(Routes.transactionDetailsScreen, arguments: {
              'id': context
                  .read<TransactionManagementCubit>()
                  .transactionManagementModel!
                  .data
                  .data[index]
                  .id,
              'type': context
                  .read<TransactionManagementCubit>()
                  .transactionManagementModel!
                  .data
                  .data[index]
                  .typeId
            })
          : selectedIndex == 1
              ? context.pushNamed(Routes.transactionDetailsScreen, arguments: {
                  'id': context
                      .read<TransactionManagementCubit>()
                      .transactionManagementInModel!
                      .data
                      .data[index]
                      .id,
                  'type': context
                      .read<TransactionManagementCubit>()
                      .transactionManagementInModel!
                      .data
                      .data[index]
                      .typeId
                })
              : context.pushNamed(
                  Routes.transactionDetailsScreen,
                  arguments: {
                    'id': context
                        .read<TransactionManagementCubit>()
                        .transactionManagementOutModel!
                        .data
                        .data[index]
                        .id,
                    'type': context
                        .read<TransactionManagementCubit>()
                        .transactionManagementOutModel!
                        .data
                        .data[index]
                        .typeId,
                  },
                );
    },
    child: Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 90.h,
        ),
        width: double.infinity,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11.r),
          border: Border.all(color: AppColor.secondaryColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  selectedIndex == 0
                      ? context
                          .read<TransactionManagementCubit>()
                          .transactionManagementModel!
                          .data
                          .data[index]
                          .userName
                      : selectedIndex == 1
                          ? context
                              .read<TransactionManagementCubit>()
                              .transactionManagementModel!
                              .data
                              .data
                              .where((type) => type.typeId == 0)
                              .toList()[index]
                              .userName
                          : context
                              .read<TransactionManagementCubit>()
                              .transactionManagementModel!
                              .data
                              .data
                              .where((type) => type.typeId == 1)
                              .toList()[index]
                              .userName,
                  style: TextStyles.font16BlackSemiBold,
                ),
                horizontalSpace(5),
                Container(
                  height: 23.h,
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: statusColorForType.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Center(
                    child: Text(
                      selectedIndex == 0
                          ? context
                              .read<TransactionManagementCubit>()
                              .transactionManagementModel!
                              .data
                              .data[index]
                              .type
                          : selectedIndex == 1
                              ? context
                                  .read<TransactionManagementCubit>()
                                  .transactionManagementModel!
                                  .data
                                  .data
                                  .where((type) => type.typeId == 0)
                                  .toList()[index]
                                  .type
                              : context
                                  .read<TransactionManagementCubit>()
                                  .transactionManagementModel!
                                  .data
                                  .data
                                  .where((type) => type.typeId == 1)
                                  .toList()[index]
                                  .type,
                      style: TextStyles.font11WhiteSemiBold.copyWith(
                        color: statusColorForType,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Icon(
                  IconBroken.calendar,
                  color: AppColor.primaryColor,
                  size: 18.sp,
                ),
                horizontalSpace(3),
                Text(
                  getDateOnly(selectedIndex == 0
                      ? context
                          .read<TransactionManagementCubit>()
                          .transactionManagementModel!
                          .data
                          .data[index]
                          .createdAt
                      : selectedIndex == 1
                          ? context
                              .read<TransactionManagementCubit>()
                              .transactionManagementModel!
                              .data
                              .data
                              .where((type) => type.typeId == 0)
                              .toList()[index]
                              .createdAt
                          : context
                              .read<TransactionManagementCubit>()
                              .transactionManagementModel!
                              .data
                              .data
                              .where((type) => type.typeId == 1)
                              .toList()[index]
                              .createdAt),
                  style: TextStyles.font11WhiteSemiBold
                      .copyWith(color: AppColor.primaryColor),
                ),
              ],
            ),
            verticalSpace(12),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Category: ',
                    style: TextStyles.font12GreyRegular,
                  ),
                  TextSpan(
                    text: selectedIndex == 0
                        ? context
                            .read<TransactionManagementCubit>()
                            .transactionManagementModel!
                            .data
                            .data[index]
                            .category
                        : selectedIndex == 1
                            ? context
                                .read<TransactionManagementCubit>()
                                .transactionManagementModel!
                                .data
                                .data
                                .where((type) => type.typeId == 0)
                                .toList()[index]
                                .category
                            : context
                                .read<TransactionManagementCubit>()
                                .transactionManagementModel!
                                .data
                                .data
                                .where((type) => type.typeId == 1)
                                .toList()[index]
                                .category,
                    style: TextStyles.font14Primarybold,
                  ),
                ],
              ),
            ),
            verticalSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quantity: ',
                        style: TextStyles.font12GreyRegular,
                      ),
                      TextSpan(
                        text: selectedIndex == 0
                            ? context
                                .read<TransactionManagementCubit>()
                                .transactionManagementModel!
                                .data
                                .data[index]
                                .quantity
                                .toString()
                            : selectedIndex == 1
                                ? context
                                    .read<TransactionManagementCubit>()
                                    .transactionManagementModel!
                                    .data
                                    .data
                                    .where((type) => type.typeId == 0)
                                    .toList()[index]
                                    .quantity
                                    .toString()
                                : context
                                    .read<TransactionManagementCubit>()
                                    .transactionManagementModel!
                                    .data
                                    .data
                                    .where((type) => type.typeId == 1)
                                    .toList()[index]
                                    .quantity
                                    .toString(),
                        style: TextStyles.font14Primarybold,
                      ),
                      TextSpan(
                        text:
                            ' ${selectedIndex == 0 ? context.read<TransactionManagementCubit>().transactionManagementModel?.data.data[index].unit : selectedIndex == 1 ? context.read<TransactionManagementCubit>().transactionManagementModel?.data.data.where((type) => type.typeId == 0).toList()[index].unit : context.read<TransactionManagementCubit>().transactionManagementModel?.data.data.where((type) => type.typeId == 1).toList()[index].unit ?? ''}',
                        style: TextStyles.font12GreyRegular
                            .copyWith(color: AppColor.primaryColor),
                      ),
                    ],
                  ),
                ),
                horizontalSpace(30),
                if (selectedIndex == 0 || selectedIndex == 1) ...[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Total Price: ',
                          style: TextStyles.font12GreyRegular,
                        ),
                        TextSpan(
                          text:
                              '${selectedIndex == 0 ? context.read<TransactionManagementCubit>().transactionManagementModel!.data.data[index].totalPrice : selectedIndex == 1 ? context.read<TransactionManagementCubit>().transactionManagementModel!.data.data.where((type) => type.typeId == 0).toList()[index].totalPrice : context.read<TransactionManagementCubit>().transactionManagementModel!.data.data.where((type) => type.typeId == 1).toList()[index].totalPrice.toString()} \$',
                          style: TextStyles.font14Primarybold,
                        ),
                      ],
                    ),
                  )
                ],
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
