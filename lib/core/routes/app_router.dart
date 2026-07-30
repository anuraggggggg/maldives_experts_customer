import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_provider.dart';
import '../../views/auth/login_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/splash/splash_screen.dart';
import '../../views/static/placeholder_screen.dart';
import '../constants/app_strings.dart';
import '../services/navigation_service.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter(this._authProvider);

  final AuthProvider _authProvider;

  late final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/splash',
    refreshListenable: _authProvider,
    redirect: (context, state) {
      final path = state.uri.path;
      final publicRoute = path == '/splash' || path == '/login';
      if (!_authProvider.isLoggedIn && !publicRoute) return '/login';
      if (_authProvider.isLoggedIn && path == '/login') return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        builder: (_, __) => const LoginScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            AppNavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                name: RouteNames.home,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),
          _placeholderBranch('/search', RouteNames.search, AppStrings.search),
          _placeholderBranch(
            '/wishlist',
            RouteNames.wishlist,
            AppStrings.wishlist,
          ),
          _placeholderBranch(
            '/bookings',
            RouteNames.bookings,
            AppStrings.bookings,
          ),
          _placeholderBranch(
            '/profile',
            RouteNames.profile,
            AppStrings.profile,
          ),
        ],
      ),
    ],
  );

  static StatefulShellBranch _placeholderBranch(
    String path,
    String name,
    String title,
  ) => StatefulShellBranch(
    routes: [
      GoRoute(
        path: path,
        name: name,
        builder: (_, __) => PlaceholderScreen(title: title),
      ),
    ],
  );
}

class AppNavigationShell extends StatelessWidget {
  const AppNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) => Scaffold(
    body: navigationShell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: navigationShell.currentIndex,
      onDestinationSelected: (index) => navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      ),
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          label: AppStrings.home,
        ),
        NavigationDestination(
          icon: Icon(Icons.search),
          label: AppStrings.search,
        ),
        NavigationDestination(
          icon: Icon(Icons.favorite_outline),
          label: AppStrings.wishlist,
        ),
        NavigationDestination(
          icon: Icon(Icons.luggage_outlined),
          label: AppStrings.bookings,
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: AppStrings.profile,
        ),
      ],
    ),
  );
}
