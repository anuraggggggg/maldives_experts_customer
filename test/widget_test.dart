import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:maldives_experts_customer/app.dart';
import 'package:maldives_experts_customer/providers/auth_provider.dart';
import 'package:maldives_experts_customer/providers/home_provider.dart';
import 'package:maldives_experts_customer/views/auth/login_screen.dart';
import 'package:maldives_experts_customer/views/home/home_screen.dart';
import 'package:maldives_experts_customer/views/home/activities_screen.dart';
import 'package:maldives_experts_customer/views/home/offers_screen.dart';
import 'package:maldives_experts_customer/views/home/resorts_screen.dart';
import 'package:maldives_experts_customer/views/home/popular_destinations_screen.dart';
import 'package:maldives_experts_customer/views/trips/my_trips_screen.dart';
import 'package:maldives_experts_customer/views/search/filters_screen.dart';
import 'package:maldives_experts_customer/views/search/saved_searches_screen.dart';
import 'package:maldives_experts_customer/views/wishlist/wishlist_screen.dart';
import 'package:maldives_experts_customer/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';

void main() {
  test('demo credentials authenticate successfully', () async {
    final auth = AuthProvider();

    await auth.login(
      email: AuthProvider.demoEmail,
      password: AuthProvider.demoPassword,
    );

    expect(auth.isLoggedIn, isTrue);
    expect(auth.error, isNull);
  });

  test('invalid credentials are rejected', () async {
    final auth = AuthProvider();

    await auth.login(email: 'wrong@gmail.com', password: 'wrong');

    expect(auth.isLoggedIn, isFalse);
    expect(auth.error, 'Invalid email or password');
  });

  testWidgets('shows splash then opens onboarding after configured duration', (
    tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const MaldivesExpertsApp(),
      ),
    );

    expect(find.text('Your Dream Holiday'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);

    await tester.pump(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('shows mobile number only on the register tab', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const MaterialApp(home: LoginScreen()),
      ),
    );

    expect(find.text('Email Address'), findsOneWidget);
    expect(find.text('Mobile Number'), findsNothing);

    await tester.tap(find.text('Register').first);
    await tester.pumpAndSettle();

    expect(find.text('Mobile Number'), findsOneWidget);
  });

  testWidgets('dashboard renders all primary sections on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: const MaterialApp(home: HomeScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hi, John 👋'), findsOneWidget);
    expect(find.text('Search Packages'), findsOneWidget);
    expect(find.text('Popular Destinations'), findsOneWidget);
    expect(find.text('Exclusive Summer Sale ☀️'), findsOneWidget);
    expect(find.text('Why Book With Us?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('home drawer opens and navigates to Featured Resorts', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/home',
      routes: [
        GoRoute(
          path: '/home',
          builder: (_, __) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'featured-resorts',
              builder: (_, __) => const ResortsScreen(),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.menu_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Latest Blogs'), findsOneWidget);
    expect(find.text('Saved Searches'), findsOneWidget);

    await tester.tap(find.text('Featured Resorts'));
    await tester.pump(const Duration(milliseconds: 400));

    expect(
      router.routeInformationProvider.value.uri.path,
      '/home/featured-resorts',
    );
    expect(find.text('Featured Resorts'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('resorts screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ResortsScreen()));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Featured Resorts'), findsOneWidget);
    expect(find.text('Search Resorts'), findsOneWidget);
    expect(find.text('Top Rated Resorts'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('popular destinations is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: PopularDestinationsScreen()),
    );
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Popular Destinations'), findsOneWidget);
    expect(find.text('Explore Destinations'), findsOneWidget);
    expect(find.text('Top Maldives Destinations'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('offers screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: OffersScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Latest Offers'), findsOneWidget);
    expect(find.text('Up to 30% OFF'), findsOneWidget);
    expect(find.text("Don't Miss Any Offers!"), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('activities screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ActivitiesScreen()));
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Activities'), findsWidgets);
    expect(find.text('Search Activities'), findsOneWidget);
    expect(find.text('Popular Activities'), findsOneWidget);
    expect(find.text('Up to 25% OFF'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('my trips screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: MyTripsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('My Trips'), findsOneWidget);
    expect(find.text('Next Trip'), findsOneWidget);
    expect(find.text('Upcoming Trips (2)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('saved searches screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: SavedSearchesScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Saved Searches'), findsOneWidget);
    expect(find.text('Filters'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filters screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: FiltersScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Filters'), findsOneWidget);
    expect(find.text('Price Range'), findsOneWidget);
    expect(find.text('Apply Filters  (342 Results)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filters remain responsive on a narrow screen with larger text', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 700);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: const TextScaler.linear(1.15)),
          child: child!,
        ),
        home: const FiltersScreen(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(FiltersScreen), findsOneWidget);
    expect(tester.takeException(), isNull);

    for (var index = 0; index < 8; index++) {
      await tester.dragFrom(const Offset(160, 300), const Offset(0, -450));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }
  });

  testWidgets('wishlist screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: WishlistScreen()));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('My Wishlist'), findsOneWidget);
    expect(find.text('Total Saved'), findsOneWidget);
    expect(find.text('Sort by: Recently Added'), findsOneWidget);
    expect(find.text('Resorts (10)'), findsWidgets);
    expect(tester.takeException(), isNull);

    for (var index = 0; index < 6; index++) {
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pump(const Duration(milliseconds: 300));
      expect(tester.takeException(), isNull);
    }

    expect(find.text('Need help planning your dream trip?'), findsOneWidget);
  });

  testWidgets('profile screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => AuthProvider(),
        child: const MaterialApp(home: ProfileScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('My Profile'), findsOneWidget);
    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Personal Information'), findsOneWidget);
    expect(tester.takeException(), isNull);

    for (var index = 0; index < 4; index++) {
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);
    }

    expect(find.text('Sign Out'), findsOneWidget);
  });
}
