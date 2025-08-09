import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/common/app_toaster.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/common/enums.dart';
import 'package:trade_for_you_app/common/widgets/company_logo.dart';
import 'package:trade_for_you_app/core/router/app_router.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/login_cubit/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? _userIDController;
  TextEditingController? _passwordController;
  bool _obscurePassword = true;

  _toggleObscurePassword() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  void initState() {
    _userIDController = TextEditingController();
    _passwordController = TextEditingController();
    // _userIDController?.text = "5207280046";
    // _userIDController?.text = "5206080002";
    _userIDController?.text = "5208080001";
    _passwordController?.text = "Sumon1234";
    super.initState();
  }

  @override
  void dispose() {
    _userIDController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  _emptyFields() {
    _userIDController?.clear();
    _passwordController?.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is Authenticated) {
              _emptyFields();
              context.goNamed(AppRouter.dashboardRoute);
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.status == EventCallResult.error) {
              AppToaster.showInfo(context, state.error ?? "");
            }
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CompanyLogo(height: 60),
                  SizedBox(height: AppUiConst.mp16),
                  Container(
                    margin: EdgeInsets.all(AppUiConst.mp20),
                    padding: EdgeInsets.all(AppUiConst.mp20),
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground,
                      borderRadius: BorderRadius.circular(
                        AppUiConst.borderRadius20,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            AppStrings.signIn,
                            style: AppUiConst.font20BoldTS.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        SizedBox(height: AppUiConst.mp16),
                        Text(
                          AppStrings.userID,
                          style: AppUiConst.font12RegularTS.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppUiConst.mp8),
                        TextFormField(
                          controller: _userIDController,
                          style: AppUiConst.font12RegularTS.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppStrings.enterYourUserId,
                            hintStyle: AppUiConst.font12RegularTS.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: AppUiConst.mp12),
                        Text(
                          AppStrings.password,
                          style: AppUiConst.font12RegularTS.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: AppUiConst.mp8),
                        TextFormField(
                          obscureText: _obscurePassword,
                          controller: _passwordController,
                          style: AppUiConst.font12RegularTS.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: AppStrings.enterPassword,
                            hintStyle: AppUiConst.font12RegularTS.copyWith(
                              color: AppColors.textPrimary.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              onTap: _toggleObscurePassword,
                              child: Icon(Icons.remove_red_eye_outlined),
                            ),
                          ),
                        ),
                        SizedBox(height: AppUiConst.mp12),
                        BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state) {
                            if (state.status == EventCallResult.loading) {
                              return Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    padding: EdgeInsets.all(AppUiConst.mp4),
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              );
                            }
                            return GestureDetector(
                              onTap: () {
                                var userId = _userIDController?.text ?? "";
                                var password = _passwordController?.text ?? "";
                                if (userId != "" && password != "") {
                                  context.read<LoginCubit>().login(
                                    userId,
                                    password,
                                  );
                                } else {
                                  AppToaster.showInfo(
                                    context,
                                    "User id and password cannot be empty",
                                  );
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  borderRadius: BorderRadius.circular(
                                    AppUiConst.borderRadius5,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    AppStrings.signIn,
                                    style: AppUiConst.font12BoldTS.copyWith(
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
