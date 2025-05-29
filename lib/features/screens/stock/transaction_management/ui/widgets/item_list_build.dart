import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/routing/routes.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';

class TransactionListitembuild extends StatelessWidget {
  final int index;
  const TransactionListitembuild({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionManagementCubit>();

    return InkWell(
      borderRadius: BorderRadius.circular(11.r),
      onTap: () {
        cubit.selectedIndex == 0
            ? context.pushNamed(Routes.transactionDetailsScreen, arguments: {
                'id': cubit.transactionManagementModel!.data!.data![index].id,
                'type':
                    cubit.transactionManagementModel!.data!.data![index].typeId
              })
            : cubit.selectedIndex == 1
                ? context
                    .pushNamed(Routes.transactionDetailsScreen, arguments: {
                    'id': cubit
                        .transactionManagementInModel!.data!.data![index].id,
                    'type': cubit
                        .transactionManagementInModel!.data!.data![index].typeId
                  })
                : context.pushNamed(
                    Routes.transactionDetailsScreen,
                    arguments: {
                      'id': cubit
                          .transactionManagementOutModel!.data!.data![index].id,
                      'type': cubit.transactionManagementOutModel!.data!
                          .data![index].typeId,
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
                    cubit.selectedIndex == 0
                        ? cubit.transactionManagementModel!.data!.data![index]
                            .userName!
                        : cubit.selectedIndex == 1
                            ? cubit.transactionManagementModel!.data!.data!
                                .where((type) => type.typeId == 0)
                                .toList()[index]
                                .userName!
                            : cubit.transactionManagementModel!.data!.data!
                                .where((type) => type.typeId == 1)
                                .toList()[index]
                                .userName!,
                    style: TextStyles.font16BlackSemiBold,
                  ),
                  horizontalSpace(5),
                  Container(
                    height: 23.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: cubit
                          .getStatusColorForType(cubit
                              .transactionManagementModel!
                              .data!
                              .data![index]
                              .typeId!)
                          .withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        cubit.selectedIndex == 0
                            ? cubit.transactionManagementModel!.data!
                                .data![index].type!
                            : cubit.selectedIndex == 1
                                ? cubit.transactionManagementModel!.data!.data!
                                    .where((type) => type.typeId == 0)
                                    .toList()[index]
                                    .type!
                                : cubit.transactionManagementModel!.data!.data!
                                    .where((type) => type.typeId == 1)
                                    .toList()[index]
                                    .type!,
                        style: TextStyles.font11WhiteSemiBold.copyWith(
                          color: cubit.getStatusColorForType(cubit
                              .transactionManagementModel!
                              .data!
                              .data![index]
                              .typeId!),
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
                    cubit.getDateOnly(cubit.selectedIndex == 0
                        ? cubit.transactionManagementModel!.data!.data![index]
                            .createdAt!
                        : cubit.selectedIndex == 1
                            ? cubit.transactionManagementModel!.data!.data!
                                .where((type) => type.typeId == 0)
                                .toList()[index]
                                .createdAt!
                            : cubit.transactionManagementModel!.data!.data!
                                .where((type) => type.typeId == 1)
                                .toList()[index]
                                .createdAt!),
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
                      text: cubit.selectedIndex == 0
                          ? cubit.transactionManagementModel!.data!.data![index]
                              .category
                          : cubit.selectedIndex == 1
                              ? cubit.transactionManagementModel!.data!.data!
                                  .where((type) => type.typeId == 0)
                                  .toList()[index]
                                  .category
                              : cubit.transactionManagementModel!.data!.data!
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
                          text: cubit.selectedIndex == 0
                              ? cubit.transactionManagementModel!.data!
                                  .data![index].quantity
                                  .toString()
                              : cubit.selectedIndex == 1
                                  ? cubit
                                      .transactionManagementModel!.data!.data!
                                      .where((type) => type.typeId == 0)
                                      .toList()[index]
                                      .quantity
                                      .toString()
                                  : cubit
                                      .transactionManagementModel!.data!.data!
                                      .where((type) => type.typeId == 1)
                                      .toList()[index]
                                      .quantity
                                      .toString(),
                          style: TextStyles.font14Primarybold,
                        ),
                        TextSpan(
                          text:
                              ' ${cubit.selectedIndex == 0 ? cubit.transactionManagementModel?.data!.data![index].unitId : cubit.selectedIndex == 1 ? cubit.transactionManagementModel?.data!.data!.where((type) => type.typeId == 0).toList()[index].unitId : cubit.transactionManagementModel?.data!.data!.where((type) => type.typeId == 1).toList()[index].unitId ?? ''}',
                          style: TextStyles.font12GreyRegular
                              .copyWith(color: AppColor.primaryColor),
                        ),
                      ],
                    ),
                  ),
                  horizontalSpace(30),
                  if ((cubit.selectedIndex == 0 &&
                          cubit.transactionManagementModel!.data!.data![index]
                                  .typeId ==
                              0) ||
                      cubit.selectedIndex == 1) ...[
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Total Price: ',
                            style: TextStyles.font12GreyRegular,
                          ),
                          TextSpan(
                            text:
                                '${cubit.selectedIndex == 0 ? cubit.transactionManagementModel!.data!.data![index].totalPrice : cubit.selectedIndex == 1 ? cubit.transactionManagementModel!.data!.data!.where((type) => type.typeId == 0).toList()[index].totalPrice : cubit.transactionManagementModel!.data!.data!.where((type) => type.typeId == 1).toList()[index].totalPrice.toString()} \$',
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
}
