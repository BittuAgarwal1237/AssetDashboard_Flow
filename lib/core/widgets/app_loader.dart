import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class AppLoader extends StatelessWidget {
  final double size;

  const AppLoader({
    super.key,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: size,
        width: size,
        child: const CircularProgressIndicator(
          strokeWidth: 3,
          color: AppColors.primary,
        ),
      ),
    );
  }
}