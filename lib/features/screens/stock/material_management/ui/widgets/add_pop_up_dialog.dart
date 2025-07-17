import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_drop_down_list.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_cubit.dart';
import 'package:smart_cleaning_application/features/screens/stock/material_management/logic/material_mangement_state.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class AddPopUpDialog {
  static Future<String?> show(
      {required BuildContext context, required int id}) async {
    return await showDialog(
      context: context,
      builder: (dialogContext) {
        final cubit = context.read<MaterialManagementCubit>();
        cubit.clearAllControllers();
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<MaterialManagementCubit, MaterialManagementState>(
            builder: (context, state) {
              return Dialog(
                insetPadding: EdgeInsets.all(20),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 8.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                  color: AppColor.primaryColor,
                                  borderRadius: BorderRadius.circular(2.r)),
                            ),
                            horizontalSpace(8),
                            Text(
                              S.of(context).addMaterial,
                              style: TextStyles.font18PrimMedium,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.close_rounded,
                                size: 26.sp,
                              ),
                              onPressed: () => context.pop(),
                            ),
                          ],
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).quantity,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).writeQuantity,
                          controller: cubit.quantityController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).quantityRequired;
                            } else if (value.length > 20) {
                              return S.of(context).quantityTooLong;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.quantityIdController.text =
                                double.parse(value).toString();
                          },
                        ),
                        verticalSpace(10),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: S.of(context).price,
                                style: TextStyles.font16BlackRegular,
                              ),
                              TextSpan(
                                text: S.of(context).unit,
                                style: TextStyles.font14GreyRegular,
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(5),
                        CustomTextFormField(
                          onlyRead: false,
                          hint: S.of(context).writePrice,
                          controller: cubit.priceController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).priceRequired;
                            } else if (value.length > 20) {
                              return S.of(context).priceTooLong;
                            }
                            return null;
                          },
                          onChanged: (value) {
                            cubit.priceIdController.text =
                                double.parse(value).toString();
                          },
                        ),
                        verticalSpace(10),
                        Text(
                          S.of(context).providerBody,
                          style: TextStyles.font16BlackRegular,
                        ),
                        verticalSpace(5),
                        CustomDropDownList(
                          hint: S.of(context).hintSelectProvider,
                          onPressed: (selectedValue) {
                            final selectedId = cubit.providersModel?.data?.data
                                ?.firstWhere(
                                  (provider) => provider.name == selectedValue,
                                )
                                .id;

                            if (selectedId != null) {
                              cubit.providerIdController.text =
                                  selectedId.toString();
                            }
                          },
                          items: cubit.providerItem
                              .map((e) => e.name ?? 'Unknown')
                              .toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return S.of(context).providerRequiredValidation;
                            }
                            return null;
                          },
                          controller: cubit.providerController,
                          keyboardType: TextInputType.text,
                          suffixIcon: IconBroken.arrowDown2,
                        ),
                        verticalSpace(10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              cubit.pickSingleFile();
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(10),
                                backgroundColor: AppColor.primaryColor,
                                elevation: 4),
                            child: const Icon(IconBroken.upload,
                                color: Colors.white, size: 26),
                          ),
                        ),
                        verticalSpace(8),
                        Center(
                          child: Text(
                            S.of(context).uploadFile,
                            style: TextStyles.font14BlackSemiBold,
                          ),
                        ),
                        if (cubit.image?.path != null) ...[
                          Text(
                            S.of(context).file,
                            style: TextStyles.font16BlackRegular,
                          ),
                          verticalSpace(5),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  final path = cubit.image!.path;
                                  final isPDF =
                                      path.toLowerCase().endsWith('.pdf');

                                  if (isPDF) {
                                    await OpenFile.open(path);
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (contextt) => Scaffold(
                                          appBar: AppBar(
                                              leading: CustomBackButton()),
                                          body: Center(
                                            child: PhotoView(
                                              imageProvider:
                                                  FileImage(File(path)),
                                              backgroundDecoration:
                                                  const BoxDecoration(
                                                      color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: Builder(builder: (_) {
                                  final path = cubit.image!.path;
                                  final isPDF =
                                      path.toLowerCase().endsWith('.pdf');

                                  return Container(
                                    height: 80,
                                    width: 80,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Colors.grey.shade200,
                                    ),
                                    child: isPDF
                                        ? Icon(Icons.picture_as_pdf,
                                            color: Colors.red, size: 40.sp)
                                        : Image.file(File(path),
                                            fit: BoxFit.cover),
                                  );
                                }),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: GestureDetector(
                                  onTap: () {
                                    cubit.removeSelectedFile();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                    child: Icon(Icons.close,
                                        size: 14, color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        verticalSpace(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DefaultElevatedButton(
                              name: S.of(context).addButton,
                              onPressed: () {
                                cubit.addMaterial(
                                    materialId: id, image: cubit.image?.path);
                                context.pop();
                              },
                              color: AppColor.primaryColor,
                              width: 125.w,
                              textStyles: TextStyles.font16WhiteSemiBold,
                            ),
                            DefaultElevatedButton(
                              name: S.of(context).cancelButton,
                              onPressed: () {
                                context.pop();
                              },
                              color: AppColor.fourthColor,
                              width: 125.w,
                              textStyles: TextStyles.font16WhiteSemiBold,
                            ),
                          ],
                        )
                      ],
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
}
