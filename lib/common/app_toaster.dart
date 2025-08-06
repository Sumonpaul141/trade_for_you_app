import 'package:flutter/material.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';

class AppToaster {
  static void showInfo(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
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
