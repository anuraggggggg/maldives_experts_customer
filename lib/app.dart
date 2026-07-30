import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';

class MaldivesExpertsApp extends StatefulWidget {
  const MaldivesExpertsApp({super.key});

  @override
  State<MaldivesExpertsApp> createState() => _MaldivesExpertsAppState();
}

class _MaldivesExpertsAppState extends State<MaldivesExpertsApp> {
  late final AppRouter _router;

  @override
  void initState() {
    super.initState();
    _router = AppRouter(context.read<AuthProvider>());
  }

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: AppStrings.appName,
    debugShowCheckedModeBanner: false,
    theme: AppTheme.light,
    darkTheme: AppTheme.dark,
    routerConfig: _router.router,
  );
}
