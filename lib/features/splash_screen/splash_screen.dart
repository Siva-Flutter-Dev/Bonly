import 'package:bondly/core/constants/app_constants.dart';
import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/data/services/store_user_data.dart';
import 'package:bondly/features/splash_screen/splash_bloc/splash_bloc.dart';
import 'package:bondly/features/splash_screen/splash_bloc/splash_event.dart';
import 'package:bondly/features/splash_screen/splash_bloc/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/utils/app_router.dart';
import '../../core/utils/assets_constants.dart';
import '../../core/utils/extentions.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var storeUserData = StoreUserData();
    final isMobile = context.isMobile();
    var currentWidth = context.mediaQueryWidth;
    return BlocProvider(
      create: (_) => SplashBloc()..add(StartSplashEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoaded) {
            if(storeUserData.getBoolean(AppConstants.loginSession)){
              Routing.replace(context: context, location: AppRouteConstants.homeRoute);
            }else if(storeUserData.getBoolean(AppConstants.onBoardSlide)){
              Routing.replace(context: context, location: AppRouteConstants.loginRoute);
            }else{
              Routing.replace(context: context, location: AppRouteConstants.welcomeRoute);
            }
          }
        },
        child: Scaffold(
          body: Container(
            width: currentWidth,
            decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient
            ),
            child: Center(
              child: Image.asset(
                  height: isMobile?170:230,
                  width: isMobile?190:250,
                  AssetsPath.splashIcon),
            ),
          ),
        ),
      ),
    );
  }
}