import 'package:bondly/features/home_screen/home_screen.dart';
import 'package:bondly/features/login_screen/presentation/login_screen.dart';
import 'package:bondly/features/register_screen/presentation/pages/register_screen.dart';
import 'package:bondly/features/welcome_screen/welcome_screen.dart';
import 'package:flutter/cupertino.dart';

import '../../features/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter{

  static GoRouter appRouter = GoRouter(
    initialLocation: AppRouteConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppRouteConstants.splashRoute,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.welcomeRoute,
        builder: (context, state) => WelcomeScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.registerRoute,
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.loginRoute,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: AppRouteConstants.homeRoute,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}

class AppRouteConstants{
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String welcomeRoute = '/welcome';
  static const String registerRoute = '/register';
  static const String homeRoute = '/home';
  static const String profileRoute = '/profile';
}

class Routing{
  static void push({required String location,required BuildContext context, Object? values}){
   context.push(location,extra: values);
  }

  static void replace({required String location,required BuildContext context, Object? values}){
    context.go(location,extra: values);
  }

  static void back({required BuildContext context,Object? values}){
    context.pop(values);
  }
}