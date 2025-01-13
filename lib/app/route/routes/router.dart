import 'package:daytaskapp/app/controller/navigation_cubit.dart';
import 'package:daytaskapp/data/repo/authenticate/login_repo.dart';
import 'package:daytaskapp/data/repo/repo.dart';
import 'package:daytaskapp/feature/login/bloc/login_bloc.dart';
import 'package:daytaskapp/feature/main_screen.dart';
import 'package:daytaskapp/feature/postask/post_task_screen.dart';
import 'package:daytaskapp/feature/profile/profile_screen.dart';
import 'package:daytaskapp/feature/rank/rank_screen.dart';
import 'package:daytaskapp/feature/schedule/schedule_screen.dart';
import 'package:daytaskapp/feature/taskdetail/task_detail_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:daytaskapp/feature/register/register_screen.dart';
import '../../../feature/notfound/notfound_screen.dart';
import '../../../feature/product/product_screen.dart';
import '../../../feature/splash/splash_screen.dart';
import '../../../feature/login/login_screen.dart';
import '../../../feature/home/home_screen.dart';

import 'route_path.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: RoutePath.splash,
  navigatorKey: _rootNavigatorKey,
  routes: [
    // bottom Navigation
    ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainScreen(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: RoutePath.home,
            name: RoutePath.home,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
            routes: [
              // product route with parameter
              GoRoute(
                path: "${RoutePath.productDetails}/:category",
                name: RoutePath.productDetails,
                builder: (context, state) => ProductScreen(
                  category: state.pathParameters["category"] ?? "All",
                ),
              ),
            ],
          ),
          GoRoute(
            path: RoutePath.schedule,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ScheduleScreen(),
            ),
            routes: [],
          ),
          GoRoute(
            path: RoutePath.postask,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: PostTaskScreen(),
            ),
            routes: [],
          ),
          GoRoute(
            path: RoutePath.rank,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: RankScreen(),
            ),
            routes: [],
          ),
          GoRoute(
            path: RoutePath.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
            routes: [],
          ),
        ]),
    // Normal Navigation
    GoRoute(
      path: RoutePath.login,
      name: RoutePath.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RoutePath.register,
      name: RoutePath.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RoutePath.splash,
      name: RoutePath.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RoutePath.taskDetail,
      name: RoutePath.taskDetail,
      builder: (context, state) => const TaskDetailScreen(),
    ),
  ],
  errorBuilder: (context, state) => const NotFoundScreen(),
);
