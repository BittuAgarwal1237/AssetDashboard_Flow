import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class AppSearchField extends StatelessWidget {
  final TextEditingController controller;

  final ValueChanged<String>? onChanged;

  final String hint;

  const AppSearchField({
    super.key,
    required this.controller,
    this.onChanged,
    this.hint = "Search...",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: AppTextStyles.body(context),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}