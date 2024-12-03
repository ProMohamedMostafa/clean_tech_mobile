import 'dart:async';

import 'package:flutter/material.dart';
import 'package:smart_cleaning_application/core/theming/font_style/font_styles.dart';
import 'package:smart_cleaning_application/generated/l10n.dart';

class ReceiveCodeText extends StatefulWidget {
  const ReceiveCodeText({super.key});

  @override
  State<ReceiveCodeText> createState() => _ReceiveCodeTextState();
}

class _ReceiveCodeTextState extends State<ReceiveCodeText> {
  Timer? timer;
  int start = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return start == 0
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  S.of(context).verifyAccountScreenTitle3,
                  style: TextStyles.font12BlackRegular,
                ),
                InkWell(
                    onTap: () {
                      start = 10;
                      setState(() {});
                    },
                    child: Text(
                      S.of(context).resendButton,
                      style: TextStyles.font14Redbold,
                    )),
              ],
            ),
          )
        : Center(
            child: Text(
              "$start",
              style: TextStyles.font16BlackRegular,
            ),
          );
  }
}
