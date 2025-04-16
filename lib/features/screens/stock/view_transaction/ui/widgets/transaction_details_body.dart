import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/networking/api_constants/api_constants.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/row_details_build.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/transaction_management/logic/transaction_mangement_state.dart';

class TransactionDetailsBody extends StatefulWidget {
  final int id;
  final int type;
  const TransactionDetailsBody(
      {super.key, required this.id, required this.type});

  @override
  State<TransactionDetailsBody> createState() => _TransactionDetailsBodyState();
}

class _TransactionDetailsBodyState extends State<TransactionDetailsBody> {
  String getDateOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  String getTimeOnly(String dateTimeString) {
    final dateTime = DateTime.parse(dateTimeString);
    return DateFormat('HH:mm').format(dateTime);
  }

  final List<Color> statusColor = [
    Colors.green,
    Colors.red,
  ];

  @override
  void initState() {
    context
        .read<TransactionManagementCubit>()
        .getTransactionDetails(widget.id, widget.type);
    super.initState();
  }

  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    final Color currentStatusColor =
        (widget.type >= 0 && widget.type < statusColor.length)
            ? statusColor[widget.type]
            : Colors.grey;
    return BlocBuilder<TransactionManagementCubit, TransactionManagementState>(
      builder: (context, state) {
        if (context
                .read<TransactionManagementCubit>()
                .transactionDetailsModel
                ?.data ==
            null) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColor.primaryColor,
            ),
          );
        }
        return Scaffold(
            appBar: AppBar(
              title: Text("Transaction details"),
              leading: customBackButton(context),
              actions: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Container(
                    height: 23.h,
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: currentStatusColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Center(
                      child: Text(
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .type!,
                        style: TextStyles.font11WhiteSemiBold.copyWith(
                          color: currentStatusColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    rowDetailsBuild(
                        context,
                        'Category',
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .category!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'Matrial',
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .name!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'User',
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .userName!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'Provider',
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .provider!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'Total Quantity',
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .quantity!
                            .toString()),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                      context,
                      'Total Price',
                      double.parse(context
                                  .read<TransactionManagementCubit>()
                                  .transactionDetailsModel!
                                  .data!
                                  .totalPrice
                                  ?.toString() ??
                              '0.0')
                          .toString(),
                    ),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'Date',
                        getDateOnly(context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .createdAt!)),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        'Time',
                        getTimeOnly(context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .createdAt!)),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                      context,
                      'File',
                      context
                                  .read<TransactionManagementCubit>()
                                  .transactionDetailsModel!
                                  .data!
                                  .file ==
                              null
                          ? 'No file uploaded'
                          : '${context.read<TransactionManagementCubit>().transactionDetailsModel!.data!.file!.length} files uploaded',
                    ),
                    verticalSpace(10),
                    if (context
                                .read<TransactionManagementCubit>()
                                .transactionDetailsModel!
                                .data!
                                .file !=
                            null &&
                        context
                            .read<TransactionManagementCubit>()
                            .transactionDetailsModel!
                            .data!
                            .file!
                            .isNotEmpty) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (contextt) => Scaffold(
                                appBar: AppBar(
                                  leading: customBackButton(context),
                                ),
                                body: Center(
                                  child: PhotoView(
                                    imageProvider: NetworkImage(
                                      '${ApiConstants.apiBaseUrlImage}${context.read<TransactionManagementCubit>().transactionDetailsModel!.data!.file}',
                                    ),
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                          'assets/images/noImage.png',
                                          fit: BoxFit.fill);
                                    },
                                    backgroundDecoration: const BoxDecoration(
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 5.h, horizontal: 10.w),
                          child: Container(
                            height: 70.h,
                            width: 70.w,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Image.network(
                              '${ApiConstants.apiBaseUrlImage}${context.read<TransactionManagementCubit>().transactionDetailsModel!.data!.file}',
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset('assets/images/noImage.png',
                                    fit: BoxFit.fill);
                              },
                            ),
                          ),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ));
      },
    );
  }
}
