import 'package:flutter/material.dart';

import '../constants/app_text_styles.dart';

class AppSectionTitle extends StatelessWidget {
  final String title;

  final Widget? action;

  const AppSectionTitle({
    super.key,
    required this.title,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.title(context),
          ),
        ),
        if (action != null) action!,
      ],
    );
  }
}