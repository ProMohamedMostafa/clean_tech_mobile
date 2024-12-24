import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/features/screens/user_managment/ui/widgets/list_item_build.dart';

Widget userDetailsBuild(BuildContext context) {
  return ListView.builder(
    shrinkWrap: true,
    physics: const ClampingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: 2,
    itemBuilder: (context, index) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Divider(
            color: Colors.grey[300],
          ),
          listItemBuild(context,index)
        ],
      );
    },
  );
}
