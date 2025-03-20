import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/filter_search_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/ui/widgets/transaction_details_list_build.dart';

class TransactionManagmentBody extends StatefulWidget {
  const TransactionManagmentBody({super.key});

  @override
  State<TransactionManagmentBody> createState() =>
      _TransactionManagmentBodyState();
}

class _TransactionManagmentBodyState extends State<TransactionManagmentBody> {
  @override
  void initState() {
    context.read<TransactionManagementCubit>()
      ..getTransactionList()
      ..getUsers()
      ..getCategoryList()
      ..getProviders();

    super.initState();
  }

  int? selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: customBackButton(context),
        title: Text(
          'Transaction Management',
        ),
      ),
      body:
          BlocConsumer<TransactionManagementCubit, TransactionManagementState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (context
                  .read<TransactionManagementCubit>()
                  .transactionManagementModel ==
              null) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColor.primaryColor,
              ),
            );
          }

          return SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(15),
                    filterAndSearchBuild(
                        context, context.read<TransactionManagementCubit>()),
                    verticalSpace(15),
                    SizedBox(
                      height: 45.h,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;

                          double containerWidth = (totalWidth - 5) / 3.05;
                          return ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 3,
                            separatorBuilder: (context, index) {
                              return horizontalSpace(5);
                            },
                            itemBuilder: (context, index) {
                              bool isSelected = selectedIndex == index;
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 45.h,
                                  width: containerWidth,
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? AppColor.primaryColor
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                      color: AppColor.secondaryColor,
                                      width: 1,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        index == 0
                                            ? "${context.read<TransactionManagementCubit>().transactionManagementModel?.data.data.length ?? 0}"
                                            : index == 1
                                                ? "${context.read<TransactionManagementCubit>().transactionManagementModel?.data.data.where((type) => type.type == 'In').length ?? 0}"
                                                : "${context.read<TransactionManagementCubit>().transactionManagementModel?.data.data.where((type) => type.type == 'Out').length ?? 0}",
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                      horizontalSpace(5),
                                      Text(
                                        index == 0
                                            ? "All"
                                            : index == 1
                                                ? 'Inside'
                                                : 'Outside',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : AppColor.primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    verticalSpace(10),
                    Divider(
                      color: Colors.grey[300],
                    ),
                    transactionDetailsBuild(context, selectedIndex!),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
