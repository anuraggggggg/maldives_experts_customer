import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    required this.controller,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.onFieldSubmitted,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onFieldSubmitted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: AppTextStyles.fieldLabel),
      const SizedBox(height: AppSpacing.sm),
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        onFieldSubmitted: onFieldSubmitted,
        obscureText: obscureText,
        validator: validator,
        style: AppTextStyles.fieldText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: AppTextStyles.fieldHint,
          prefixIcon: prefixIcon == null
              ? null
              : Icon(prefixIcon, color: AppColors.inactive, size: 20),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.authFieldFill,
          contentPadding: const EdgeInsets.symmetric(
            vertical: AppSpacing.regular,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            borderSide: const BorderSide(color: AppColors.divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
            borderSide: const BorderSide(color: AppColors.authBlue, width: 1.5),
          ),
        ),
      ),
    ],
  );
}
