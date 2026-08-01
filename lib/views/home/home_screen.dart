import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constants/app_constants.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import 'widgets/destination_section.dart';
import 'widgets/dashboard_swipe_navigator.dart';
import 'widgets/feature_shortcuts.dart';
import 'widgets/home_header.dart';
import 'widgets/offer_banner.dart';
import 'widgets/travel_search_card.dart';
import 'widgets/why_choose_us.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: AppConstants.animationDuration,
    )..forward();
    _fade = CurvedAnimation(parent: _entranceController, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.025),
      end: Offset.zero,
    ).animate(_fade);
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light,
    child: Scaffold(
      backgroundColor: AppColors.white,
      body: DashboardSwipeNavigator(
        currentPage: DashboardPage.packages,
        child: FadeTransition(
          opacity: _fade,
          child: SlideTransition(
            position: _slide,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(
                children: [
                  const HomeHeader(),
                  Transform.translate(
                    offset: const Offset(0, -12),
                    child: const TravelSearchCard(),
                  ),
                  const FeatureShortcuts(),
                  const DestinationSection(),
                  const SizedBox(height: AppSpacing.md),
                  const OfferBanner(),
                  const SizedBox(height: AppSpacing.lg),
                  const WhyChooseUs(),
                  const SizedBox(height: AppSpacing.bottomNavClearance),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
