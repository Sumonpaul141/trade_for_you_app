import 'package:flutter/material.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final Color? color;
  const RoundedButton({super.key, this.onTap, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppUiConst.mp12),
        decoration: BoxDecoration(
          color: color ?? AppColors.accent,
          borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
        ),
        child: Center(
          child: Text(
            text,
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
