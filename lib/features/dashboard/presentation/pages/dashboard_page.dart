import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/common/widgets/company_logo.dart';
import 'package:trade_for_you_app/core/router/app_router.dart';
import 'package:trade_for_you_app/features/auth/data/models/user_model.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          context.goNamed(AppRouter.loginRoute);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: CompanyLogo(height: 30),
          backgroundColor: AppColors.background,
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                context.read<AuthCubit>().logout();
              },
              child: Padding(
                padding: const EdgeInsets.all(AppUiConst.mp12),
                child: Icon(Icons.logout, color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                UserModel? user;
                if (state is Authenticated) {
                  user = state.user;
                  return Container(
                    margin: EdgeInsets.all(AppUiConst.mp16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildWelcomeBackBox(user),
                        SizedBox(height: AppUiConst.mp12),
                        _buildPlaceOrderButton(
                          onTap: () {
                            context.pushNamed(AppRouter.placeOrderRoute);
                          },
                        ),
                        SizedBox(height: AppUiConst.mp12),
                        _buildCancelOrderButton(
                          onTap: () {
                            context.pushNamed(AppRouter.cancelOrderRoute);
                          },
                        ),
                      ],
                    ),
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeBackBox(UserModel user) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: AppUiConst.mp12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.3),
            AppColors.orange.withValues(alpha: 0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${AppStrings.welcomeBack}, ${user.name}",
            style: AppUiConst.font12BoldTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            "${AppStrings.userID}: ${user.username}",
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            "${AppStrings.joined}: ${user.joinedDate.day}/${user.joinedDate.month}/${user.joinedDate.year}",
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  _buildPlaceOrderButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppUiConst.mp12),
        decoration: BoxDecoration(
          color: AppColors.accent.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
        ),
        child: Center(
          child: Text(
            AppStrings.placeOrder,
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  _buildCancelOrderButton({required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: AppUiConst.mp12),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(AppUiConst.borderRadius10),
        ),
        child: Center(
          child: Text(
            AppStrings.cancelOrder,
            style: AppUiConst.font12RegularTS.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
