import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';

class TransactionDetailsBody extends StatefulWidget {
  final int id;
  const TransactionDetailsBody({super.key, required this.id});

  @override
  State<TransactionDetailsBody> createState() => _TransactionDetailsBodyState();
}

class _TransactionDetailsBodyState extends State<TransactionDetailsBody> {
  @override
  void initState() {
    // context.read<TransactionManagementCubit>().getTransactionDetails(widget.id);
    super.initState();
  }

  bool descTextShowFlag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction details"),
        leading: customBackButton(context),
      ),
      // body: BlocConsumer<TransactionManagementCubit, TransactionManagementState>(
      //   listener: (context, state) {
      //     // if (state is DeleteTransactionSuccessState) {
      //     //   toast(text: state.message, color: Colors.blue);
      //     //   context.pushNamedAndRemoveUntil(
      //     //     Routes.transactionScreen,
      //     //     predicate: (route) => false,
      //     //   );
      //     // }
      //     // if (state is DeletetransactionErrorState) {
      //     //   toast(text: state.error, color: Colors.red);
      //     // }
      //   },
      //   builder: (context, state) {
      //     if (

      //       context.read<TransactionManagementCubit>().transactionDetailsModel ==
      //         null
      //         ) {
      //       return Center(
      //         child: CircularProgressIndicator(
      //           color: AppColor.primaryColor,
      //         ),
      //       );
      //     }

      //     return SingleChildScrollView(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 20),
      //         child: Column(
      //           mainAxisAlignment: MainAxisAlignment.start,
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             rowDetailsBuild(
      //                 context,
      //                 'Name',
      //                 context
      //                     .read<TransactionManagementCubit>()
      //                     .transactionDetailsModel!
      //                     .data!
      //                     .name!),
      //             Divider(
      //               height: 30,
      //             ),
      //             rowDetailsBuild(
      //                 context,
      //                 'Category',
      //                 context
      //                     .read<TransactionManagementCubit>()
      //                     .transactionDetailsModel!
      //                     .data!
      //                     .categoryName!),
      //             Divider(
      //               height: 30,
      //             ),
      //             rowDetailsBuild(
      //                 context,
      //                 'Quantity',
      //                 context
      //                     .read<TransactionManagementCubit>()
      //                     .transactionDetailsModel!
      //                     .data!
      //                     .quantity
      //                     .toString()),
      //             Divider(
      //               height: 30,
      //             ),
      //             rowDetailsBuild(
      //                 context,
      //                 'Minimum',
      //                 context
      //                     .read<TransactionManagementCubit>()
      //                     .transactionDetailsModel!
      //                     .data!
      //                     .minThreshold
      //                     .toString()),
      //             Divider(
      //               height: 30,
      //             ),
      //             Text(
      //               'Description',
      //               style: TextStyles.font16BlackSemiBold,
      //             ),
      //             verticalSpace(5),
      //             Text(
      //               context
      //                   .read<TransactionManagementCubit>()
      //                   .transactionDetailsModel!
      //                   .data!
      //                   .description!,
      //               overflow: TextOverflow.ellipsis,
      //               maxLines: descTextShowFlag ? 40 : 3,
      //               style: TextStyles.font14GreyRegular,
      //             ),
      //             Align(
      //                 alignment: Alignment.bottomRight,
      //                 child: InkWell(
      //                     borderRadius: BorderRadius.circular(5.r),
      //                     onTap: () {
      //                       setState(() {
      //                         descTextShowFlag = !descTextShowFlag;
      //                       });
      //                     },
      //                     child: descTextShowFlag
      //                         ? Padding(
      //                             padding: const EdgeInsets.all(10),
      //                             child: const Text(
      //                               "Read less",
      //                               style: TextStyle(
      //                                   color: Colors.blue, fontSize: 12),
      //                             ),
      //                           )
      //                         : Padding(
      //                             padding: const EdgeInsets.all(10),
      //                             child: const Text(
      //                               "Read more",
      //                               style: TextStyle(
      //                                   color: Colors.blue, fontSize: 12),
      //                             ),
      //                           ))),
      //             verticalSpace(20),
      //             state is DeletetransactionLoadingState
      //                 ? Center(
      //                     child: CircularProgressIndicator(
      //                       color: AppColor.primaryColor,
      //                     ),
      //                   )
      //                 : Center(
      //                     child: DefaultElevatedButton(
      //                         name: 'Delete',
      //                         onPressed: () {
      //                           context
      //                               .read<TransactionManagementCubit>()
      //                               .deletetransaction(widget.id);
      //                         },
      //                         color: Colors.red,
      //                         height: 47,
      //                         width: double.infinity,
      //                         textStyles: TextStyles.font20Whitesemimedium),
      //                   ),
      //             verticalSpace(20)
      //           ],
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
