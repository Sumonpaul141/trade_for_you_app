import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:trade_for_you_app/common/app_assets.dart';

class CompanyLogo extends StatelessWidget {
  final double? height;
  final double? weight;
  const CompanyLogo({super.key, this.height, this.weight});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.companyLogo,
      height: height,
      width: weight,
    );
  }
}
