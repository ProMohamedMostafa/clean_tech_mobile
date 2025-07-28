import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/custom_row/row_details_build.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/loading/loading.dart';
import 'package:smart_cleaning_application/features/screens/dashboard/stock/view_transaction/logic/cubit/transaction_details_cubit.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TransactionDetailsBody extends StatelessWidget {
  final int id;
  final int type;
  const TransactionDetailsBody(
      {super.key, required this.id, required this.type});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TransactionDetailsCubit>();
    final Color currentStatusColor =
        (type >= 0 && type < cubit.statusColor.length)
            ? cubit.statusColor[type]
            : Colors.grey;
    return BlocBuilder<TransactionDetailsCubit, TransactionDetailsState>(
      builder: (context, state) {
        if (cubit.transactionDetailsModel?.data == null) {
          return Loading();
        }
        return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).transactionDetails),
              leading: CustomBackButton(),
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
                        cubit.transactionDetailsModel!.data!.type!,
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
                    rowDetailsBuild(context, S.of(context).category,
                        cubit.transactionDetailsModel!.data!.category!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(context, S.of(context).material,
                        cubit.transactionDetailsModel!.data!.name!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(context, S.of(context).user,
                        cubit.transactionDetailsModel!.data!.userName!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(context, S.of(context).providerBody,
                        cubit.transactionDetailsModel!.data!.provider!),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        S.of(context).totalQuantity,
                        cubit.transactionDetailsModel!.data!.quantity!
                            .toString()),
                    Divider(
                      height: 30,
                    ),
                    if (cubit.transactionDetailsModel!.data!.typeId == 0) ...[
                      rowDetailsBuild(
                        context,
                        S.of(context).totalPrice,
                        double.parse(cubit
                                    .transactionDetailsModel!.data!.totalPrice
                                    ?.toString() ??
                                '0.0')
                            .toString(),
                      ),
                      Divider(
                        height: 30,
                      )
                    ],
                    rowDetailsBuild(
                        context,
                        S.of(context).date,
                        cubit.getDateOnly(
                            cubit.transactionDetailsModel!.data!.createdAt!)),
                    Divider(
                      height: 30,
                    ),
                    rowDetailsBuild(
                        context,
                        S.of(context).time,
                        cubit.getTimeOnly(
                            cubit.transactionDetailsModel!.data!.createdAt!)),
                    Divider(
                      height: 30,
                    ),
                    if (cubit.transactionDetailsModel!.data!.typeId == 0) ...[
                      rowDetailsBuild(
                        context,
                        S.of(context).file,
                        cubit.transactionDetailsModel!.data!.file == null
                            ? S.of(context).noFile
                            : '${cubit.transactionDetailsModel?.data?.file != null ? 1 : 0} ${S.of(context).uploadFile}',
                      ),
                      verticalSpace(10),
                      buildRemoteFileViewer(
                          context, cubit.transactionDetailsModel!.data!.file),
                    ]
                  ],
                ),
              ),
            ));
      },
    );
  }

  Widget buildRemoteFileViewer(BuildContext context, String? fileUrl) {
    bool isPdf(String? url) {
      if (url == null) return false;
      return url.toLowerCase().endsWith('.pdf');
    }

    if (fileUrl == null) {
      return Text(S.of(context).noFile);
    }

    final isPDF = isPdf(fileUrl);

    return GestureDetector(
      onTap: () {
        if (isPDF) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(title: Text('PDF Viewer')),
                body: SfPdfViewer.network(fileUrl),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => Scaffold(
                appBar: AppBar(leading: CustomBackButton()),
                body: Center(
                  child: PhotoView(
                    imageProvider: NetworkImage(fileUrl),
                    backgroundDecoration:
                        const BoxDecoration(color: Colors.white),
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/noImage.png',
                        fit: BoxFit.contain,
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        }
      },
      child: Container(
        height: 80,
        width: 80,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.shade200,
        ),
        child: isPDF
            ? Icon(Icons.picture_as_pdf, color: Colors.red, size: 40)
            : Image.network(
                fileUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/noImage.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
      ),
    );
  }
}
