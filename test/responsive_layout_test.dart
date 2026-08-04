import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:maldives_experts_customer/providers/auth_provider.dart';
import 'package:maldives_experts_customer/providers/home_provider.dart';
import 'package:maldives_experts_customer/views/auth/forgot_pass.dart';
import 'package:maldives_experts_customer/views/auth/login_screen.dart';
import 'package:maldives_experts_customer/views/auth/reset_password.dart';
import 'package:maldives_experts_customer/views/home/activities_screen.dart';
import 'package:maldives_experts_customer/views/home/drawer_screens.dart';
import 'package:maldives_experts_customer/views/home/home_screen.dart';
import 'package:maldives_experts_customer/views/home/offers_screen.dart';
import 'package:maldives_experts_customer/views/home/popular_destinations_screen.dart';
import 'package:maldives_experts_customer/views/home/resorts_screen.dart';
import 'package:maldives_experts_customer/views/language_selection_screen.dart';
import 'package:maldives_experts_customer/views/onboarding/onboarding_screen.dart';
import 'package:maldives_experts_customer/views/profile/profile_screen.dart';
import 'package:maldives_experts_customer/views/search/filters_screen.dart';
import 'package:maldives_experts_customer/views/search/saved_searches_screen.dart';
import 'package:maldives_experts_customer/views/trips/my_trips_screen.dart';
import 'package:maldives_experts_customer/views/wishlist/wishlist_screen.dart';
import 'package:provider/provider.dart';

typedef _ScreenBuilder = Widget Function();

void main() {
  const viewports = <_Viewport>[
    _Viewport('iPhone SE', Size(320, 568)),
    _Viewport('iPhone standard + large text', Size(390, 844), textScale: 1.3),
    _Viewport('iPhone Pro Max', Size(430, 932)),
    _Viewport('iPad', Size(768, 1024)),
    _Viewport('phone landscape', Size(844, 390)),
    _Viewport('Android phone', Size(360, 800)),
  ];

  final screens = <String, _ScreenBuilder>{
    'Onboarding': () => const OnboardingAdScreen(),
    'Language selection': () => const LanguageSelectionScreen(),
    'Login': () => const LoginScreen(),
    'Forgot password': () => const ForgotPasswordScreen(),
    'Reset password': () => const ResetPasswordScreen(),
    'Home': () => const HomeScreen(),
    'Resorts': () => const ResortsScreen(),
    'Popular destinations': () => const PopularDestinationsScreen(),
    'Offers': () => const OffersScreen(),
    'Activities': () => const ActivitiesScreen(),
    'Featured resort collection': () =>
        const ResortCollectionScreen(collection: ResortCollection.featured),
    'Popular resort collection': () =>
        const ResortCollectionScreen(collection: ResortCollection.popular),
    'Latest blogs': () => const LatestBlogsScreen(),
    'Travel guides': () => const TravelGuidesScreen(),
    'Search holidays': () => const SearchHolidaysScreen(),
    'Recent searches': () => const RecentSearchesScreen(),
    'Saved searches': () => const SavedSearchesScreen(),
    'Filters': () => const FiltersScreen(),
    'My trips': () => const MyTripsScreen(),
    'Wishlist': () => const WishlistScreen(),
    'Profile': () => const ProfileScreen(),
  };

  for (final screen in screens.entries) {
    for (final viewport in viewports) {
      testWidgets('${screen.key} fits ${viewport.name}', (tester) async {
        tester.view.physicalSize = viewport.size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);

        await tester.pumpWidget(
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AuthProvider()),
              ChangeNotifierProvider(create: (_) => HomeProvider()),
            ],
            child: MaterialApp(
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: TextScaler.linear(viewport.textScale)),
                child: child!,
              ),
              home: screen.value(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 500));
        expect(tester.takeException(), isNull);

        // Exercise lazy list/card layouts below the initial viewport.
        for (var pass = 0; pass < 3; pass++) {
          final scrollables = find.byWidgetPredicate(
            (widget) =>
                widget is Scrollable &&
                (widget.axisDirection == AxisDirection.down ||
                    widget.axisDirection == AxisDirection.up),
          );
          if (scrollables.evaluate().isEmpty) break;
          await tester.drag(
            scrollables.first,
            const Offset(0, -350),
            warnIfMissed: false,
          );
          await tester.pump(const Duration(milliseconds: 250));
          expect(tester.takeException(), isNull);
        }
      });
    }
  }
}

class _Viewport {
  const _Viewport(this.name, this.size, {this.textScale = 1});

  final String name;
  final Size size;
  final double textScale;
}
