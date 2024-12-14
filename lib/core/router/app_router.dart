import 'package:go_router/go_router.dart';
import 'package:my_training_app/features/dashboard/dashboard_screen.dart';
import 'package:my_training_app/features/summery_of_training/screen.dart';

class AppRouter {
  final goRouter = GoRouter(
    initialLocation: '/', // Set your initial route path
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/training-details/:id', // Dynamic route with an ID parameter
        builder: (context, state) => SummeryOfTrainingScreenScreen(id: state.pathParameters['id']!),
      ),
    ],
  );
}
