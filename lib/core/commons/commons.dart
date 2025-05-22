import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/app_colors.dart';

void showToast({required String message, required ToastStates state}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: getToastStates(state),
    textColor: AppColors.textColor,
    fontSize: 16.0,
  );
}

enum ToastStates { error, success, warning }

Color getToastStates(ToastStates state) {
  switch (state) {
    case ToastStates.error:
      return AppColors.c1;
    case ToastStates.success:
      return AppColors.primaryColor;
    case ToastStates.warning:
      return AppColors.c5;
  }
}
