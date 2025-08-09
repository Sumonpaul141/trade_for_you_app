import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:trade_for_you_app/core/di/service_locator.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/auth_cubit/auth_cubit.dart';
import 'package:trade_for_you_app/features/auth/presentation/blocs/login_cubit/login_cubit.dart';
import 'package:trade_for_you_app/features/auth/presentation/pages/login_page.dart';
import 'package:trade_for_you_app/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/cancel_order_cubit/cancel_order_cubit.dart';
import 'package:trade_for_you_app/features/order/presentation/blocs/place_order_cubit/place_order_cubit.dart';
import 'package:trade_for_you_app/features/order/presentation/pages/cancel_order_page.dart';
import 'package:trade_for_you_app/features/order/presentation/pages/place_order_page.dart';
import 'package:trade_for_you_app/features/splash_screen/presentation/splash_screen.dart';

class AppRouter {
  static const String dashboardRoute = "dashboard";
  static const String loginRoute = "login";
  static const String splashScreenRoute = "splash_screen";
  static const String cancelOrderRoute = "cancel_order";
  static const String placeOrderRoute = "place_order";

  static GoRouter router = GoRouter(
    initialLocation: "/$splashScreenRoute",
    routes: [
      GoRoute(
        path: "/$loginRoute",
        name: loginRoute,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => LoginCubit(sl(), context.read<AuthCubit>()),
            child: LoginPage(),
          );
        },
      ),
      GoRoute(
        path: "/$dashboardRoute",
        name: dashboardRoute,
        builder: (context, state) {
          return DashboardPage();
        },
        routes: [
          GoRoute(
            path: placeOrderRoute,
            name: placeOrderRoute,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => PlaceOrderCubit(sl()),
                child: PlaceOrderPage(),
              );
            },
          ),
          GoRoute(
            path: cancelOrderRoute,
            name: cancelOrderRoute,
            builder: (context, state) {
              return BlocProvider(
                create: (context) => CancelOrderCubit(sl()),
                child: CancelOrderPage(),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: "/$splashScreenRoute",
        name: splashScreenRoute,
        builder: (context, state) {
          return SplashScreen();
        },
      ),
    ],
  );
}
