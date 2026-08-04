import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/helpers/validators.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_snackbar.dart';
import '../../core/widgets/app_text_field.dart';
import '../../providers/auth_provider.dart';

/// Pixel-perfect implementation matching target UI.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoginTab = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final auth = context.read<AuthProvider>();

    if (_isLoginTab) {
      await auth.login(
        email: _emailController.text.trim(),
        password: _password.text,
      );

      final error = auth.error;
      if (mounted && error != null) {
        AppSnackbar.show(context, error);
      }
    } else {
      await auth.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _password.text,
      );
    }
  }

  void _showComingSoon() {
    AppSnackbar.show(context, AppStrings.featureComingSoon);
  }

  void _onTabChanged(bool loginSelected) {
    if (loginSelected == _isLoginTab) return;
    setState(() {
      _isLoginTab = loginSelected;
      _formKey.currentState?.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final screenWidth = mq.size.width;

    final isTablet = screenWidth >= 600;
    final maxCardWidth = isTablet ? 480.0 : double.infinity;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          // Full-screen background image
          Positioned.fill(
            child: Image.asset(
              AppConstants.authBackgroundPath,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // Scrollable layout content
          SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxCardWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 24),

                      // Logo Header
                      Center(
                        child: SizedBox(
                          width: screenWidth * 0.65,
                          child: const Hero(
                            tag: AppConstants.brandLogoHeroTag,
                            child: Image(
                              image: AssetImage(AppConstants.brandLogoPath),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Welcome / Get Started Text
                      Text(
                        _isLoginTab ? 'Welcome Back!' : 'Create Account',
                        style: GoogleFonts.playfairDisplay(
                          color: AppColors.white,
                          fontSize: 29,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.2,
                          shadows: const [
                            Shadow(
                              color: AppColors.authNavy,
                              blurRadius: 5,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: _isLoginTab
                                  ? 'Login to continue your journey\nto the Maldives '
                                  : 'Sign up to start planning your dream\ngetaway to the Maldives ',
                            ),
                            const WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.water_rounded,
                                color: AppColors.white,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          height: 1.35,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Main Auth Card
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _LoginFormCard(
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailController,
                          mobileController: _mobileController,
                          passwordController: _password,
                          confirmPasswordController: _confirmPassword,
                          obscurePassword: _obscurePassword,
                          obscureConfirmPassword: _obscureConfirmPassword,
                          isLoginTab: _isLoginTab,
                          onTabChanged: _onTabChanged,
                          onPasswordVisibilityChanged: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                          onConfirmPasswordVisibilityChanged: () => setState(
                            () => _obscureConfirmPassword =
                                !_obscureConfirmPassword,
                          ),
                          onSubmit: _submit,
                          onSecondaryAction: _showComingSoon,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Trust Badges
                      const _TrustBadges(),

                      const SizedBox(height: 28),

                      // Terms and Privacy Footer
                      _TermsFooter(onTap: _showComingSoon),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard({
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.mobileController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.isLoginTab,
    required this.onTabChanged,
    required this.onPasswordVisibilityChanged,
    required this.onConfirmPasswordVisibilityChanged,
    required this.onSubmit,
    required this.onSecondaryAction,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController mobileController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isLoginTab;
  final ValueChanged<bool> onTabChanged;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onConfirmPasswordVisibilityChanged;
  final VoidCallback onSubmit;
  final VoidCallback onSecondaryAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AuthTabBar(isLoginTab: isLoginTab, onChanged: onTabChanged),
            const SizedBox(height: 24),

            // Name Field (Register Mode Only)
            if (!isLoginTab) ...[
              AppTextField(
                controller: nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                prefixIcon: Icons.person_outline,
                validator: Validators.required,
              ),
              const SizedBox(height: 16),
            ],

            // Email Field
            AppTextField(
              controller: emailController,
              label: 'Email Address',
              hint: 'Enter your email address',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            const SizedBox(height: 16),

            // Mobile Number Field (Register Mode Only)
            if (!isLoginTab) ...[
              AppTextField(
                controller: mobileController,
                label: 'Mobile Number',
                hint: 'Enter your mobile number',
                prefixIcon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: Validators.required,
              ),
              const SizedBox(height: 16),
            ],

            // Password Field
            AppTextField(
              controller: passwordController,
              label: AppStrings.password,
              hint: isLoginTab ? 'Enter your password' : 'Create a password',
              prefixIcon: Icons.lock_outline,
              obscureText: obscurePassword,
              validator: Validators.required,
              suffixIcon: IconButton(
                onPressed: onPasswordVisibilityChanged,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.inputIcon,
                  size: 20,
                ),
              ),
            ),

            // Confirm Password Field (Register Mode Only)
            if (!isLoginTab) ...[
              const SizedBox(height: 16),
              AppTextField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                prefixIcon: Icons.lock_outline,
                obscureText: obscureConfirmPassword,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (val != passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  onPressed: onConfirmPasswordVisibilityChanged,
                  icon: Icon(
                    obscureConfirmPassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.inputIcon,
                    size: 20,
                  ),
                ),
              ),
            ],

            // Forgot Password (Login Mode Only)
            if (isLoginTab)
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Navigates to the Forgot Password screen
                    context.push('/forgot-password');
                    // OR if using path: context.push('/forgot-password');
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: AppColors.authBlue,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 24),

            // Submit Gradient Button
            Selector<AuthProvider, bool>(
              selector: (_, auth) => auth.isLoading,
              builder: (_, isLoading, __) => AppButton(
                isLoading: isLoading,
                label: isLoginTab ? 'Login' : 'Register',
                onPressed: isLoading ? null : onSubmit,
                gradient: AppColors.authGradient,
                icon: Icons.arrow_forward,
              ),
            ),

            const SizedBox(height: 20),
            const _OrDivider(),
            const SizedBox(height: 16),

            Text(
              isLoginTab ? 'Login with' : 'Register with',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.authNavy,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 14),

            // Social Buttons Row
            _SocialLoginRow(onPressed: onSecondaryAction),
          ],
        ),
      ),
    );
  }
}

class _AuthTabBar extends StatelessWidget {
  const _AuthTabBar({required this.isLoginTab, required this.onChanged});

  final bool isLoginTab;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onChanged(true),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 20,
                          color: isLoginTab
                              ? AppColors.authNavy
                              : AppColors.inactive,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Login',
                          style: TextStyle(
                            color: isLoginTab
                                ? AppColors.authNavy
                                : AppColors.inactive,
                            fontWeight: isLoginTab
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onChanged(false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_add_alt_1,
                          size: 20,
                          color: !isLoginTab
                              ? AppColors.authNavy
                              : AppColors.inactive,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Register',
                          style: TextStyle(
                            color: !isLoginTab
                                ? AppColors.authNavy
                                : AppColors.inactive,
                            fontWeight: !isLoginTab
                                ? FontWeight.w700
                                : FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        // Bottom Tab Border Lines
        Stack(
          children: [
            Container(height: 1, color: AppColors.divider),
            AnimatedAlign(
              duration: AppConstants.shortAnimationDuration,
              alignment: isLoginTab
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(height: 2, color: AppColors.authBlue),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(child: Divider(color: AppColors.divider)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'OR',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const Expanded(child: Divider(color: AppColors.divider)),
    ],
  );
}

class _SocialLoginRow extends StatelessWidget {
  const _SocialLoginRow({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Expanded(
        child: _SocialButton(
          label: 'Google',
          iconWidget: const Text(
            'G',
            style: TextStyle(
              color: AppColors.googleRed,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          onPressed: onPressed,
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _SocialButton(
          label: 'Facebook',
          iconWidget: const Icon(
            Icons.facebook,
            color: AppColors.facebookBlue,
            size: 20,
          ),
          onPressed: onPressed,
        ),
      ),
    ],
  );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.iconWidget,
    required this.onPressed,
  });

  final String label;
  final Widget iconWidget;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 10),
      side: const BorderSide(color: AppColors.divider),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget,
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.inputText,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) => const Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: _TrustBadge(
          icon: Icons.shield_outlined,
          title: 'Secure & Safe',
          subtitle: 'Your data is 100%\nprotected',
        ),
      ),
      Expanded(
        child: _TrustBadge(
          icon: Icons.headset_mic_outlined,
          title: '24/7 Support',
          subtitle: 'We\'re here to help\nyou anytime',
        ),
      ),
      Expanded(
        child: _TrustBadge(
          icon: Icons.verified_outlined,
          title: 'Best Prices',
          subtitle: 'Get the best deals\nand offers',
        ),
      ),
      Expanded(
        child: _TrustBadge(
          icon: Icons.account_balance_wallet_outlined,
          title: 'Easy Payments',
          subtitle: 'Multiple secure\npayment options',
        ),
      ),
    ],
  );
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2),
    child: Column(
      children: [
        Icon(icon, color: AppColors.authNavy, size: 24),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.authNavy,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: AppColors.inputIcon,
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ],
    ),
  );
}

class _TermsFooter extends StatelessWidget {
  const _TermsFooter({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      style: const TextStyle(color: AppColors.inputIcon, fontSize: 12),
      children: [
        const TextSpan(text: 'By continuing, you agree to our '),
        TextSpan(
          text: 'Terms & Conditions',
          style: const TextStyle(
            color: AppColors.authBlue,
            fontWeight: FontWeight.w600,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
        const TextSpan(text: '\nand '),
        TextSpan(
          text: 'Privacy Policy',
          style: const TextStyle(
            color: AppColors.authBlue,
            fontWeight: FontWeight.w600,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}
