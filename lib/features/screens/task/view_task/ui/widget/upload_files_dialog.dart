import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_cleaning_application/core/helpers/extenstions/extenstions.dart';
import 'package:smart_cleaning_application/core/helpers/icons/icons.dart';
import 'package:smart_cleaning_application/core/helpers/spaces/spaces.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/features/screens/task/view_task/logic/cubit/task_details_cubit.dart';

class UploadFilesBottomDialog {
  void showBottomDialog(BuildContext context, TaskDetailsCubit cubit) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context, cubit),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget _buildDialogContent(BuildContext context, TaskDetailsCubit cubit) {
    return Container(
      width: double.maxFinite,
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Material(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildContinueText(),
                verticalSpace(25),
                _buildContinueButton(context, cubit),
                verticalSpace(15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueText() {
    return Text(
      'Upload file',
      style: TextStyles.font18PrimBold,
    );
  }

  Widget _buildContinueButton(BuildContext context, TaskDetailsCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                cubit.galleryFile();
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blue,
                elevation: 4,
              ),
              child:
                  const Icon(IconBroken.upload, color: Colors.white, size: 26),
            ),
            verticalSpace(8),
            Text(
              'Upload file',
              style: TextStyles.font14BlackSemiBold,
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                cubit.cameraFile();
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(10),
                backgroundColor: Colors.blue,
                elevation: 4,
              ),
              child:
                  const Icon(IconBroken.camera, color: Colors.white, size: 26),
            ),
            verticalSpace(8),
            Text(
              'Take photo',
              style: TextStyles.font14BlackSemiBold,
            ),
          ],
        ),
      ],
    );
  }
}
