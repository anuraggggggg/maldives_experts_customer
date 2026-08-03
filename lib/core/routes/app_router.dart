import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:maldives_experts_customer/views/auth/forgot_pass.dart';
import 'package:maldives_experts_customer/views/auth/reset_password.dart';
import 'package:maldives_experts_customer/views/language_selection_screen.dart';
import 'package:maldives_experts_customer/views/onboarding/onboarding_screen.dart';

import '../../providers/auth_provider.dart';
import '../../views/auth/login_screen.dart';
import '../../views/home/home_screen.dart';
import '../../views/home/offers_screen.dart';
import '../../views/home/popular_destinations_screen.dart';
import '../../views/home/resorts_screen.dart';
import '../../views/home/activities_screen.dart';
import '../../views/home/drawer_screens.dart';
import '../../views/search/filters_screen.dart';
import '../../views/search/saved_searches_screen.dart';
import '../../views/trips/my_trips_screen.dart';
import '../../views/wishlist/wishlist_screen.dart';
import '../../views/profile/profile_screen.dart';
import '../../views/splash/splash_screen.dart';
import '../services/navigation_service.dart';
import '../widgets/app_bottom_navigation.dart';
import 'route_names.dart';

class AppRouter {
  AppRouter(this._authProvider);

  final AuthProvider _authProvider;

  late final GoRouter router = GoRouter(
    navigatorKey: NavigationService.navigatorKey,
    initialLocation: '/splash',
    refreshListenable: _authProvider,
    redirect: (context, state) {
      // Using matchedLocation prevents path query string mismatches
      final path = state.matchedLocation;

      // List of routes accessible when unauthenticated
      final isPublicRoute =
          path == '/splash' ||
          path == '/onboarding' ||
          path == '/language-selection' ||
          path == '/login' ||
          path == '/forgot-password' ||
          path == '/reset-password';

      // 1. Unauthenticated users trying to access protected screens -> redirect to login
      if (!_authProvider.isLoggedIn && !isPublicRoute) {
        return '/login';
      }

      // 2. Authenticated users trying to access auth/public screens -> redirect to home
      if (_authProvider.isLoggedIn && isPublicRoute && path != '/splash') {
        return '/home';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: RouteNames.splash,
        pageBuilder: (_, state) => _cupertinoPage(state, const SplashScreen()),
      ),
      GoRoute(
        path: '/onboarding',
        name: RouteNames.onboarding,
        pageBuilder: (_, state) =>
            _cupertinoPage(state, const OnboardingAdScreen()),
      ),
      GoRoute(
        path: '/language-selection',
        name: RouteNames.languageSelection,
        pageBuilder: (_, state) =>
            _cupertinoPage(state, const LanguageSelectionScreen()),
      ),
      GoRoute(
        path: '/login',
        name: RouteNames.login,
        pageBuilder: (_, state) => _cupertinoPage(state, const LoginScreen()),
      ),
      GoRoute(
        path: '/forgot-password',
        name: RouteNames.forgotPassword,
        pageBuilder: (_, state) =>
            _cupertinoPage(state, const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: '/reset-password',
        name: RouteNames.resetPassword,
        pageBuilder: (_, state) =>
            _cupertinoPage(state, const ResetPasswordScreen()),
      ),
      GoRoute(
        path: '/filters',
        name: RouteNames.filters,
        pageBuilder: (_, state) => _cupertinoPage(state, const FiltersScreen()),
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
                pageBuilder: (_, state) =>
                    _cupertinoPage(state, const HomeScreen()),
                routes: [
                  GoRoute(
                    path: 'resorts',
                    name: RouteNames.resorts,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const ResortsScreen()),
                  ),
                  GoRoute(
                    path: 'offers',
                    name: RouteNames.offers,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const OffersScreen()),
                  ),
                  GoRoute(
                    path: 'activities',
                    name: RouteNames.activities,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const ActivitiesScreen()),
                  ),
                  GoRoute(
                    path: 'featured-resorts',
                    name: RouteNames.featuredResorts,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const ResortsScreen()),
                  ),
                  GoRoute(
                    path: 'popular-resorts',
                    name: RouteNames.popularResorts,
                    pageBuilder: (_, state) => _cupertinoPage(
                      state,
                      const PopularDestinationsScreen(),
                    ),
                  ),
                  GoRoute(
                    path: 'latest-blogs',
                    name: RouteNames.latestBlogs,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const LatestBlogsScreen()),
                  ),
                  GoRoute(
                    path: 'travel-guides',
                    name: RouteNames.travelGuides,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const TravelGuidesScreen()),
                  ),
                  GoRoute(
                    path: 'search-holidays',
                    name: RouteNames.searchHolidays,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const SearchHolidaysScreen()),
                  ),
                  GoRoute(
                    path: 'recent-searches',
                    name: RouteNames.recentSearches,
                    pageBuilder: (_, state) =>
                        _cupertinoPage(state, const RecentSearchesScreen()),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                name: RouteNames.search,
                pageBuilder: (_, state) =>
                    _cupertinoPage(state, const SavedSearchesScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/my-trips',
                name: RouteNames.myTrips,
                pageBuilder: (_, state) =>
                    _cupertinoPage(state, const MyTripsScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/wishlist',
                name: RouteNames.wishlist,
                pageBuilder: (_, state) =>
                    _cupertinoPage(state, const WishlistScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: RouteNames.profile,
                pageBuilder: (_, state) =>
                    _cupertinoPage(state, const ProfileScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static Page<void> _cupertinoPage(GoRouterState state, Widget child) =>
      CupertinoPage<void>(key: state.pageKey, child: child);
}

class AppNavigationShell extends StatelessWidget {
  const AppNavigationShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  static const _branchLocations = <String>[
    '/home',
    '/search',
    '/my-trips',
    '/wishlist',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    extendBody: true,
    body: navigationShell,
    bottomNavigationBar: AppBottomNavigation(
      currentIndex: navigationShell.currentIndex,
      onSelected: (index) {
        if (index < 0 || index >= _branchLocations.length) return;
        context.go(_branchLocations[index]);
      },
    ),
  );
}
