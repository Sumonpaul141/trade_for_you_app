import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_for_you_app/common/app_colors.dart';
import 'package:trade_for_you_app/common/app_strings.dart';
import 'package:trade_for_you_app/core/di/service_locator.dart';
import 'package:trade_for_you_app/core/router/app_router.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/pair_cubit/pair_cubit.dart';

class TradeForYouApp extends StatelessWidget {
  const TradeForYouApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(sl(), sl())),
        BlocProvider(create: (context) => PairCubit(sl())),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: AppStrings.appName,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
      ),
    );
  }
}
