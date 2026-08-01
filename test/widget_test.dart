import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maldives_experts_customer/app.dart';
import 'package:maldives_experts_customer/providers/auth_provider.dart';
import 'package:maldives_experts_customer/providers/home_provider.dart';
import 'package:maldives_experts_customer/views/auth/login_screen.dart';
import 'package:maldives_experts_customer/views/home/home_screen.dart';
import 'package:maldives_experts_customer/views/home/activities_screen.dart';
import 'package:maldives_experts_customer/views/home/offers_screen.dart';
import 'package:maldives_experts_customer/views/home/resorts_screen.dart';
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

  testWidgets('resorts screen is responsive on an iPhone viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MaterialApp(home: ResortsScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Featured Resorts'), findsOneWidget);
    expect(find.text('Search Resorts'), findsOneWidget);
    expect(find.text('Top Rated Resorts'), findsOneWidget);
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
    await tester.pumpAndSettle();

    expect(find.text('Activities'), findsWidgets);
    expect(find.text('Search Activities'), findsOneWidget);
    expect(find.text('Popular Activities'), findsOneWidget);
    expect(find.text('Up to 25% OFF'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
