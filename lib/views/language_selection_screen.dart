import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/route_names.dart';

class LanguageModel {
  final String code;
  final String nativeName;
  final String englishName;
  final String flagEmoji;

  const LanguageModel({
    required this.code,
    required this.nativeName,
    required this.englishName,
    required this.flagEmoji,
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
      flagEmoji: '🇬🇧',
    ),
    LanguageModel(
      code: 'ar',
      nativeName: 'العربية',
      englishName: 'Arabic',
      flagEmoji: '🇸🇦',
    ),
    LanguageModel(
      code: 'hi',
      nativeName: 'हिन्दी',
      englishName: 'Hindi',
      flagEmoji: '🇮🇳',
    ),
    LanguageModel(
      code: 'ru',
      nativeName: 'Русский',
      englishName: 'Russian',
      flagEmoji: '🇷🇺',
    ),
    LanguageModel(
      code: 'zh',
      nativeName: '中文 (简体)',
      englishName: 'Chinese (Simplified)',
      flagEmoji: '🇨🇳',
    ),
    LanguageModel(
      code: 'de',
      nativeName: 'Deutsch',
      englishName: 'German',
      flagEmoji: '🇩🇪',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;

    return Scaffold(
      body: Stack(
        children: [
          // Fixed Background Image across full screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/bb_image2.png',
              fit: BoxFit.cover,
            ),
          ),

          // Main Layout
          SafeArea(
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
                          'assets/images/footer_logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Column(
                            children: const [
                              Text(
                                'Maldives',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F2540),
                                  letterSpacing: 1.2,
                                ),
                              ),
                              Text(
                                'EXPERTS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF9900),
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
                      color: Color(0xFFE6F2FF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.language,
                      color: Color(0xFF0066CC),
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
                      color: Color(0xFF0F2540),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Select your preferred language to get started',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B7280),
                      height: 1.2,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 2. SCROLLABLE MIDDLE SECTION (Only language tiles scroll)
                  Expanded(
                    child: ListView.separated(
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
                        colors: [Color(0xFF0052CC), Color(0xFF0088FF)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0066CC).withOpacity(0.3),
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
                        color: Color(0xFF0088FF),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'You can change the language anytime from settings',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                ],
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
      duration: const Duration(milliseconds: 180),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF0F7FF) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? const Color(0xFF0066CC) : Colors.transparent,
          width: isSelected ? 1.5 : 0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
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
                // Flag Container
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFF3F4F6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    language.flagEmoji,
                    style: const TextStyle(fontSize: 18),
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
                          color: Color(0xFF0F2540),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        language.englishName,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF9CA3AF),
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
                    color: isSelected
                        ? const Color(0xFF0066CC)
                        : Colors.transparent,
                    border: isSelected
                        ? null
                        : Border.all(
                            color: const Color(0xFFD1D5DB),
                            width: 1.5,
                          ),
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
