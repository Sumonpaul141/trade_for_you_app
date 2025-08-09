import 'package:flutter/material.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';

class AppToaster {
  static void showInfo(BuildContext context, String msg, {Duration? duration}) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? Duration(milliseconds: 2000),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(
          vertical: AppUiConst.mp12,
          horizontal: AppUiConst.mp12,
        ),
        content: Text(
          msg,
          style: AppUiConst.font12RegularTS.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
