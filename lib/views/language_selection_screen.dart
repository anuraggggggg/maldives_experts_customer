import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/constants/app_constants.dart';
import '../core/routes/route_names.dart';
import '../core/theme/app_colors.dart';

class LanguageModel {
  final String code;
  final String nativeName;
  final String englishName;
  final String countryCode;

  const LanguageModel({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.countryCode,
  });
}

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguageCode = 'en';

  final List<LanguageModel> _languages = const [
    LanguageModel(
      code: 'en',
      nativeName: 'English',
      englishName: 'English',
      countryCode: 'GB',
    ),
    LanguageModel(
      code: 'ar',
      nativeName: 'العربية',
      englishName: 'Arabic',
      countryCode: 'SA',
    ),
    LanguageModel(
      code: 'hi',
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      countryCode: 'IN',
    ),
    LanguageModel(
      code: 'ru',
      nativeName: 'Русский',
      englishName: 'Russian',
      countryCode: 'RU',
    ),
    LanguageModel(
      code: 'zh',
      nativeName: '中文 (简体)',
      englishName: 'Chinese (Simplified)',
      countryCode: 'CN',
    ),
    LanguageModel(
      code: 'de',
      nativeName: 'Deutsch',
      englishName: 'German',
      countryCode: 'DE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;
    final availableHeight = mq.size.height - mq.padding.vertical;
    final languageListHeight = (availableHeight - 300).clamp(220.0, 430.0);

    return Scaffold(
      body: Stack(
        children: [
          // Fixed Background Image across full screen
          Positioned.fill(
            child: Image.asset(
              AppConstants.languageBackgroundPath,
              fit: BoxFit.cover,
            ),
          ),

          // Main Layout
          SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // 1. FIXED TOP HEADER SECTION
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 12),
                      child: Center(
                        child: SizedBox(
                          width: screenWidth * 0.65,
                          child: Image.asset(
                            AppConstants.brandLogoPath,
                            height: 72,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Column(
                                  children: [
                                    Text(
                                      'Maldives',
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.authNavy,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                    Text(
                                      'EXPERTS',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.orange,
                                        letterSpacing: 4.0,
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                        ),
                      ),
                    ),

                    // Globe Icon Badge
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: AppColors.blueTint,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.language,
                        color: AppColors.authBlue,
                        size: 22,
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Title & Subtitle
                    const Text(
                      'Choose Your Language',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.authNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Select your preferred language to get started',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.inputIcon,
                        height: 1.2,
                      ),
                    ),

                    const SizedBox(height: 14),

                    // 2. SCROLLABLE MIDDLE SECTION (Only language tiles scroll)
                    SizedBox(
                      height: languageListHeight,
                      child: ListView.separated(
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 12),
                        itemCount: _languages.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final lang = _languages[index];
                          final isSelected = lang.code == _selectedLanguageCode;

                          return _LanguageTile(
                            language: lang,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedLanguageCode = lang.code;
                              });
                            },
                          );
                        },
                      ),
                    ),

                    // 3. FIXED BOTTOM ACTION SECTION
                    const SizedBox(height: 10),

                    // Fixed Continue Button with Login Navigation
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          colors: [AppColors.royalBlue, AppColors.brightBlue],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.authBlue.withValues(alpha: 0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(25),
                          onTap: () {
                            // Navigates to the Login screen using GoRouter
                            context.goNamed(RouteNames.login);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Bottom Note
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 14,
                          color: AppColors.brightBlue,
                        ),
                        SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            'You can change the language anytime from settings',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: TextStyle(
                              color: AppColors.inputIcon,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final LanguageModel language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppConstants.shortAnimationDuration,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.blueSurface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColors.authBlue : Colors.transparent,
          width: isSelected ? 1.5 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Row(
              children: [
                // Country badge. Using text instead of flag emoji avoids
                // missing-glyph boxes on iOS simulator and device fonts.
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.lightGrey,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    language.countryCode,
                    style: const TextStyle(
                      color: AppColors.authNavy,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Text details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.nativeName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppColors.authNavy,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        language.englishName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.inactive,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),

                // Radio Selection Checkmark
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.authBlue : Colors.transparent,
                    border: isSelected
                        ? null
                        : Border.all(color: AppColors.mediumGrey, width: 1.5),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, color: Colors.white, size: 12)
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
