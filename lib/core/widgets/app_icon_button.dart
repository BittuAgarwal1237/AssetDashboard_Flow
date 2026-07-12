import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';
import '../responsive.dart';

class AppButton extends StatelessWidget {
  final String title;

  final VoidCallback? onPressed;

  final IconData? icon;

  final bool loading;

  final bool outlined;

  final Color? color;

  final Color? textColor;

  final double? width;

  final double? height;

  final BorderRadius? borderRadius;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.icon,
    this.loading = false,
    this.outlined = false,
    this.color,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final buttonHeight = height ?? AppSizes.buttonHeight;

    final radius = borderRadius ??
        BorderRadius.circular(
          context.isDesktopScreen
              ? AppSizes.radiusLG
              : AppSizes.radiusMD,
        );

    if (outlined) {
      return SizedBox(
        width: width ?? double.infinity,
        height: buttonHeight,
        child: OutlinedButton.icon(
          onPressed: loading ? null : onPressed,
          icon: icon == null
              ? const SizedBox()
              : Icon(
            icon,
            size: AppSizes.iconMD,
          ),
          label: loading
              ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
            ),
          )
              : Text(
            title,
            style: AppTextStyles.body(context),
          ),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: radius,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: buttonHeight,
      child: ElevatedButton.icon(
        onPressed: loading ? null : onPressed,
        icon: loading
            ? const SizedBox.shrink()
            : icon == null
            ? const SizedBox.shrink()
            : Icon(
          icon,
          size: AppSizes.iconMD,
        ),
        label: loading
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : Text(
          title,
          style: AppTextStyles.button(context).copyWith(
            color: textColor ?? Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: color ?? AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
          ),
        ),
      ),
    );
  }
}