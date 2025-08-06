import 'package:flutter/material.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/widgets/company_logo.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BasicAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CompanyLogo(height: 30),
      iconTheme: IconThemeData(color: AppColors.textPrimary),
      backgroundColor: AppColors.background,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
