import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_for_you_app/common/app_ui_const.dart';
import 'package:trade_for_you_app/common/widgets/company_logo.dart';
import 'package:trade_for_you_app/core/router/app_router.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = context.read<AuthCubit>();
    _authCubit.getLoggedInUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.goNamed(AppRouter.dashboardRoute);
        }
        if (state is Unauthenticated) {
          context.goNamed(AppRouter.loginRoute);
        }
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CompanyLogo(height: 40),
            SizedBox(height: AppUiConst.mp16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [CircularProgressIndicator()],
            ),
          ],
        ),
      ),
    );
  }
}
