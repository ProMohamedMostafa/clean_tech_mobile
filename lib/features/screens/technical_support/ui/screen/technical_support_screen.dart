import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/colors/color.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/core/widgets/default_back_button/back_button.dart';
import 'package:smart_cleaning_application/core/widgets/default_button/default_elevated_button.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_description_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/integrations/ui/widgets/custom_text_form_field.dart';
import 'package:smart_cleaning_application/features/screens/technical_support/logic/technical_support_cubit.dart';
import 'package:smart_cleaning_application/features/screens/technical_support/logic/technical_support_state.dart';
import 'package:smart_cleaning_application/features/screens/technical_support/ui/widgets/upload_files_dialog.dart';

class TechnicalSupportScreen extends StatefulWidget {
  const TechnicalSupportScreen({super.key});

  @override
  State<TechnicalSupportScreen> createState() => _TechnicalSupportScreenState();
}

class _TechnicalSupportScreenState extends State<TechnicalSupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Technical Support'),
        leading: customBackButton(context),
      ),
      body: BlocProvider(
        create: (context) => TechnicalSupportCubit(),
        child: BlocConsumer<TechnicalSupportCubit, TechnicalSupportState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: context.read<TechnicalSupportCubit>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        leading: SizedBox(
                          width: 80.w,
                          child: Row(
                            children: [
                              Icon(Icons.call),
                              horizontalSpace(8),
                              Text(
                                'Mobile',
                                style: TextStyles.font14BlackSemiBold,
                              ),
                            ],
                          ),
                        ),
                        trailing: Text(
                          '01060056199',
                          style: TextStyles.font14BlackSemiBold,
                        ),
                      ),
                    ),
                    verticalSpace(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                        Text(
                          ' OR ',
                          style: TextStyles.font14GreyRegular,
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Text(
                      'Title',
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    verticalSpace(5),
                    CustomTextFormField(
                      color: Colors.grey,
                      controller:
                          context.read<TechnicalSupportCubit>().titleController,
                      keyboardType: TextInputType.text,
                      hint: "Enter your problem title",
                      onlyRead: false,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Problem title is Required";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    Text(
                      'Description',
                      style: TextStyles.font14BlackSemiBold,
                    ),
                    verticalSpace(5),
                    CustomDescriptionTextFormField(
                      controller: context
                          .read<TechnicalSupportCubit>()
                          .descriptionController,
                      hint: 'Problem description...',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Problem description is Required";
                        }
                        return null;
                      },
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Text(
                          'Add file',
                          style: TextStyles.font14BlackSemiBold,
                        ),
                        IconButton(
                            onPressed: () {
                              UploadFilesBottomDialog().showBottomDialog(
                                  context,
                                  context.read<TechnicalSupportCubit>());
                            },
                            icon: Icon(
                              Icons.attach_file_rounded,
                              color: Colors.black,
                            ))
                      ],
                    ),
                    verticalSpace(10),
                    (state is ImageSelectedState)
                        ? Container(
                            height: 80,
                            width: 80,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Image.file(
                              File(context
                                  .read<TechnicalSupportCubit>()
                                  .image!
                                  .path),
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox.shrink(),
                    verticalSpace(20),
                    state is TechnicalSupportLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColor.primaryColor),
                          )
                        : Center(
                            child: DefaultElevatedButton(
                                name: "Send",
                                onPressed: () {
                                  if (context
                                      .read<TechnicalSupportCubit>()
                                      .formKey
                                      .currentState!
                                      .validate()) {
                                    // context
                                    //     .read<TechnicalSupportCubit>()
                                    //     .addTask();
                                  }
                                },
                                color: AppColor.primaryColor,
                                height: 47,
                                width: double.infinity,
                                textStyles: TextStyles.font20Whitesemimedium),
                          ),
                    verticalSpace(30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
