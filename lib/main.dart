import 'package:bondly/core/bloc_provider/bloc_initiator.dart';
import 'package:bondly/core/constants/app_constants.dart';
import 'package:bondly/core/themes/app_theme.dart';
import 'package:bondly/core/utils/app_router.dart';
import 'package:bondly/data/services/dependencies.dart';
import 'package:bondly/features/counter/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/injection_container.dart' as di;
import 'features/register_screen/presentation/bloc/register_bloc.dart';

void main() {
  AppInjector.injection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: BlocInit.provider,
        child: MaterialApp.router(
          routerConfig: AppRouter.appRouter,
          title: AppConstants.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: AppTheme.primaryColor),
          ),
        )
    );
  }
}
