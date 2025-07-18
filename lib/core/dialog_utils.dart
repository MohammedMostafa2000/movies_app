import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  static showLoadingDialog(String? loadingMessage, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Row(
            children: [
              Text(
                loadingMessage ?? "",
                style: TextStyle(fontSize: 16.sp),
              ),
              const Spacer(),
              const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }

  static hideDialog(BuildContext context) {
    Navigator.pop(context);
  }

  static void showDialogMessage(BuildContext context,
      {required String message,
      String? title,
      String? posActionTitle,
      String? negActionTitle,
      VoidCallback? posAction,
      VoidCallback? negAction}) {
    List<Widget> actions = [];
    if (posActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            posAction?.call();
          },
          child: Text(
            posActionTitle,
            style: TextStyle(fontSize: 16.sp),
          )));
    }
    if (negActionTitle != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            negAction?.call();
          },
          child: Text(
            negActionTitle,
            style: TextStyle(fontSize: 16.sp),
          )));
    }
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          content: Text(
            message,
            style: TextStyle(fontSize: 16.sp),
          ),
          title: title != null
              ? Text(
                  title,
                  style: TextStyle(fontSize: 16.sp),
                )
              : null,
          actions: actions,
        );
      },
    );
  }
}
