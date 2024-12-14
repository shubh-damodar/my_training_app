import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_training_app/features/dashboard/dashboard_screen.dart';
import 'package:my_training_app/features/dashboard/data/models/training_model.dart';
import 'package:my_training_app/features/summery_of_training/screen.dart';

class AppRouter {
  final goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/summeryOfTrainingScreen',
        builder: (BuildContext context, GoRouterState state) {
          final Training training = state.extra as Training;
          return SummeryOfTrainingScreen(
            key: state.pageKey,
            training: training,
          );
        },
        // pageBuilder: (context, state) => const SummeryOfTrainingScreen(),
      ),
    ],
  );
}
