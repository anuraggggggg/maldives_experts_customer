import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/constants/app_constants.dart';
import '../../core/constants/app_strings.dart';
import '../../core/helpers/validators.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_snackbar.dart';
import '../../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    await context.read<AuthProvider>().login(
      email: _email.text.trim(),
      password: _password.text,
    );
  }

  void _showComingSoon() {
    AppSnackbar.show(context, AppStrings.featureComingSoon);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    body: SingleChildScrollView(
      child: Column(
        children: [
          const _LoginHero(),
          _LoginFormCard(
            formKey: _formKey,
            emailController: _email,
            passwordController: _password,
            rememberMe: _rememberMe,
            obscurePassword: _obscurePassword,
            onRememberChanged: (value) =>
                setState(() => _rememberMe = value ?? false),
            onPasswordVisibilityChanged: () =>
                setState(() => _obscurePassword = !_obscurePassword),
            onSubmit: _submit,
            onSecondaryAction: _showComingSoon,
          ),
        ],
      ),
    ),
  );
}

class _LoginHero extends StatelessWidget {
  const _LoginHero();

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 315,
    width: double.infinity,
    child: Stack(
      fit: StackFit.expand,
      children: [
        const Image(
          image: AssetImage(AppConstants.loginHeroPath),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.navy,
                AppColors.transparent,
                AppColors.navyLight,
              ],
              stops: [0, 0.58, 1],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              AppSpacing.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 108,
                  height: 74,
                  padding: const EdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(AppSpacing.radius),
                  ),
                  child: const Image(
                    image: AssetImage(AppConstants.appIconPath),
                    fit: BoxFit.contain,
                  ),
                ),
                const Spacer(),
                const Text(
                  AppStrings.discoverParadise,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 27,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Text(
                  AppStrings.inMaldives,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const SizedBox(
                  width: 310,
                  child: Text(
                    AppStrings.heroSubtitle,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _LoginFormCard extends StatelessWidget {
  const _LoginFormCard({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.rememberMe,
    required this.obscurePassword,
    required this.onRememberChanged,
    required this.onPasswordVisibilityChanged,
    required this.onSubmit,
    required this.onSecondaryAction,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool rememberMe;
  final bool obscurePassword;
  final ValueChanged<bool?> onRememberChanged;
  final VoidCallback onPasswordVisibilityChanged;
  final VoidCallback onSubmit;
  final VoidCallback onSecondaryAction;

  @override
  Widget build(BuildContext context) => Transform.translate(
    offset: const Offset(0, -18),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.xl,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.xl),
        ),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.welcomeBackEmphasis,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.navy,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            const Text(
              AppStrings.loginSubtitle,
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText),
            ),
            const SizedBox(height: AppSpacing.lg),
            _LoginField(
              controller: emailController,
              label: AppStrings.emailAddress,
              hint: AppStrings.emailHint,
              icon: Icons.mail_outline,
              keyboardType: TextInputType.emailAddress,
              validator: Validators.email,
            ),
            const SizedBox(height: AppSpacing.md),
            _LoginField(
              controller: passwordController,
              label: AppStrings.password,
              hint: AppStrings.passwordHint,
              icon: Icons.lock_outline,
              obscureText: obscurePassword,
              validator: Validators.required,
              suffixIcon: IconButton(
                onPressed: onPasswordVisibilityChanged,
                icon: Icon(
                  obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
            _LoginOptions(
              rememberMe: rememberMe,
              onChanged: onRememberChanged,
              onForgotPassword: onSecondaryAction,
            ),
            const SizedBox(height: AppSpacing.md),
            Consumer<AuthProvider>(
              builder: (_, auth, __) => AppButton(
                label: AppStrings.login,
                isLoading: auth.isLoading,
                onPressed: auth.isLoading ? null : onSubmit,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            const _OrDivider(),
            const SizedBox(height: AppSpacing.md),
            const Text(
              AppStrings.loginWith,
              style: TextStyle(
                color: AppColors.navy,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            _SocialLoginRow(onPressed: onSecondaryAction),
            const SizedBox(height: AppSpacing.md),
            _SignUpPrompt(onPressed: onSecondaryAction),
            const SizedBox(height: AppSpacing.lg),
            const Divider(color: AppColors.border),
            const SizedBox(height: AppSpacing.md),
            const _TrustBadges(),
          ],
        ),
      ),
    ),
  );
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
          color: AppColors.navy,
          fontWeight: FontWeight.w700,
        ),
      ),
      const SizedBox(height: AppSpacing.sm),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: AppColors.mutedText),
          prefixIcon: Icon(icon, color: AppColors.mutedText),
          suffixIcon: suffixIcon,
          fillColor: AppColors.fieldFill,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radius),
            borderSide: const BorderSide(color: AppColors.sky, width: 1.5),
          ),
        ),
      ),
    ],
  );
}

class _LoginOptions extends StatelessWidget {
  const _LoginOptions({
    required this.rememberMe,
    required this.onChanged,
    required this.onForgotPassword,
  });

  final bool rememberMe;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onForgotPassword;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      SizedBox(
        width: 32,
        child: Checkbox(value: rememberMe, onChanged: onChanged),
      ),
      const Text(
        AppStrings.rememberMe,
        style: TextStyle(color: AppColors.mutedText, fontSize: 12),
      ),
      const Spacer(),
      TextButton(
        onPressed: onForgotPassword,
        child: const Text(AppStrings.forgotPassword),
      ),
    ],
  );
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) => const Row(
    children: [
      Expanded(child: Divider(color: AppColors.border)),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Text(
          AppStrings.or,
          style: TextStyle(color: AppColors.mutedText, fontSize: 12),
        ),
      ),
      Expanded(child: Divider(color: AppColors.border)),
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
          label: AppStrings.google,
          icon: Icons.g_mobiledata,
          iconColor: AppColors.error,
          onPressed: onPressed,
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: _SocialButton(
          label: AppStrings.facebook,
          icon: Icons.facebook,
          iconColor: AppColors.facebook,
          onPressed: onPressed,
        ),
      ),
      const SizedBox(width: AppSpacing.sm),
      Expanded(
        child: _SocialButton(
          label: AppStrings.apple,
          icon: Icons.apple,
          iconColor: AppColors.black,
          onPressed: onPressed,
        ),
      ),
    ],
  );
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.iconColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 12),
      side: const BorderSide(color: AppColors.border),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: AppSpacing.xs),
        Text(label, maxLines: 1, style: const TextStyle(fontSize: 10)),
      ],
    ),
  );
}

class _SignUpPrompt extends StatelessWidget {
  const _SignUpPrompt({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text(
        AppStrings.noAccount,
        style: TextStyle(color: AppColors.mutedText, fontSize: 12),
      ),
      GestureDetector(
        onTap: onPressed,
        child: const Text(
          AppStrings.signUp,
          style: TextStyle(
            color: AppColors.navy,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    ],
  );
}

class _TrustBadges extends StatelessWidget {
  const _TrustBadges();

  @override
  Widget build(BuildContext context) => const Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      _TrustBadge(
        icon: Icons.verified_user_outlined,
        label: AppStrings.secureBooking,
      ),
      _TrustBadge(
        icon: Icons.local_offer_outlined,
        label: AppStrings.bestPrice,
      ),
      _TrustBadge(
        icon: Icons.headset_mic_outlined,
        label: AppStrings.supportAlways,
      ),
    ],
  );
}

class _TrustBadge extends StatelessWidget {
  const _TrustBadge({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: 94,
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: const BoxDecoration(
            color: AppColors.fieldFill,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.sky, size: 20),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: const TextStyle(
            color: AppColors.navy,
            fontSize: 9,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
