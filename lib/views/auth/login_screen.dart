import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_strings.dart';
import '../../core/helpers/validators.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/app_snackbar.dart';
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
  final _emailOrPhone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoginTab = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailOrPhone.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final auth = context.read<AuthProvider>();

    if (_isLoginTab) {
      await auth.login(
        email: _emailOrPhone.text.trim(),
        password: _password.text,
      );
    } else {
      await auth.register(
        name: _nameController.text.trim(),
        email: _emailOrPhone.text.trim(),
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
              'assets/images/login_screen_background.png',
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),

          // Scrollable layout content
          SafeArea(
            child: SingleChildScrollView(
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
                          child: const Image(
                            image: AssetImage('assets/images/footer_logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 36),

                      // Welcome / Get Started Text
                      Text(
                        _isLoginTab ? 'Welcome Back!' : 'Create Account',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _isLoginTab
                            ? 'Login to continue your journey\nto the Maldives 🌊'
                            : 'Sign up to start planning your dream\ngetaway to the Maldives 🌊',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
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
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: _LoginFormCard(
                          formKey: _formKey,
                          nameController: _nameController,
                          emailController: _emailOrPhone,
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
              _LoginField(
                controller: nameController,
                label: 'Full Name',
                hint: 'Enter your full name',
                icon: Icons.person_outline,
                validator: Validators.required,
              ),
              const SizedBox(height: 16),
            ],

            // Email or Mobile Field
            _LoginField(
              controller: emailController,
              label: 'Email or Mobile Number',
              hint: 'Enter email or mobile number',
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.required,
            ),
            const SizedBox(height: 16),

            // Password Field
            _LoginField(
              controller: passwordController,
              label: AppStrings.password,
              hint: isLoginTab ? 'Enter your password' : 'Create a password',
              icon: Icons.lock_outline,
              obscureText: obscurePassword,
              validator: Validators.required,
              suffixIcon: IconButton(
                onPressed: onPasswordVisibilityChanged,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: const Color(0xFF6B7280),
                  size: 20,
                ),
              ),
            ),

            // Confirm Password Field (Register Mode Only)
            if (!isLoginTab) ...[
              const SizedBox(height: 16),
              _LoginField(
                controller: confirmPasswordController,
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                icon: Icons.lock_outline,
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
                    color: const Color(0xFF6B7280),
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
                  onPressed: onSecondaryAction,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.only(top: 8, bottom: 16),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFF0066CC),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
            else
              const SizedBox(height: 24),

            // Submit Gradient Button
            Consumer<AuthProvider>(
              builder: (_, auth, __) => _GradientLoginButton(
                isLoading: auth.isLoading,
                label: isLoginTab ? 'Login' : 'Register',
                onPressed: auth.isLoading ? null : onSubmit,
              ),
            ),

            const SizedBox(height: 20),
            const _OrDivider(),
            const SizedBox(height: 16),

            Text(
              isLoginTab ? 'Login with' : 'Register with',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF0F2540),
                fontSize: 13,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        size: 20,
                        color: isLoginTab
                            ? const Color(0xFF0F2540)
                            : const Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Login',
                        style: TextStyle(
                          color: isLoginTab
                              ? const Color(0xFF0F2540)
                              : const Color(0xFF9CA3AF),
                          fontWeight: isLoginTab
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => onChanged(false),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person_add_alt_1,
                        size: 20,
                        color: !isLoginTab
                            ? const Color(0xFF0F2540)
                            : const Color(0xFF9CA3AF),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Register',
                        style: TextStyle(
                          color: !isLoginTab
                              ? const Color(0xFF0F2540)
                              : const Color(0xFF9CA3AF),
                          fontWeight: !isLoginTab
                              ? FontWeight.w700
                              : FontWeight.w500,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        // Bottom Tab Border Lines
        Stack(
          children: [
            Container(height: 1, color: const Color(0xFFE5E7EB)),
            AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: isLoginTab
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: FractionallySizedBox(
                widthFactor: 0.5,
                child: Container(height: 2, color: const Color(0xFF0066CC)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: Color(0xFF0F2540),
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
      const SizedBox(height: 8),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        style: const TextStyle(fontSize: 14, color: Color(0xFF1F2937)),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
          prefixIcon: Icon(icon, color: const Color(0xFF9CA3AF), size: 20),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: const Color(0xFFF9FAFB),
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFF0066CC), width: 1.5),
          ),
        ),
      ),
    ],
  );
}

class _GradientLoginButton extends StatelessWidget {
  const _GradientLoginButton({
    required this.isLoading,
    required this.label,
    required this.onPressed,
  });

  final bool isLoading;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) => Container(
    height: 48,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      gradient: const LinearGradient(
        colors: [Color(0xFF0F2540), Color(0xFF0066CC)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
    ),
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                  ],
                ),
        ),
      ),
    ),
  );
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          'OR',
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      const Expanded(child: Divider(color: Color(0xFFE5E7EB))),
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
              color: Color(0xFFEA4335),
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
            color: Color(0xFF1877F2),
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
      side: const BorderSide(color: Color(0xFFE5E7EB)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        iconWidget,
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFF1F2937),
            fontWeight: FontWeight.w600,
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
        Icon(icon, color: const Color(0xFF0F2540), size: 24),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF0F2540),
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 9,
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
      style: const TextStyle(color: Color(0xFF6B7280), fontSize: 11),
      children: [
        const TextSpan(text: 'By continuing, you agree to our '),
        TextSpan(
          text: 'Terms & Conditions',
          style: const TextStyle(
            color: Color(0xFF0066CC),
            fontWeight: FontWeight.w600,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
        const TextSpan(text: '\nand '),
        TextSpan(
          text: 'Privacy Policy',
          style: const TextStyle(
            color: Color(0xFF0066CC),
            fontWeight: FontWeight.w600,
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        ),
      ],
    ),
  );
}
