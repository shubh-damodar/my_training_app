import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_training_app/core/router/app_router.dart';
import 'package:my_training_app/core/theme/app_theme.dart';
import 'package:my_training_app/features/dashboard/bloc/dashboard_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardBloc()),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().goRouter, // Use your AppRouter
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
      ),
    );
  }
}
