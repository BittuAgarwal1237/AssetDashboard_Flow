import 'package:flutter/material.dart';
import 'app_constants.dart';

/// Device size categories
enum DeviceSize { smallMobile, mobile, tablet, desktop }

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget? smallMobile;
  final Widget? tablet;
  final Widget desktop;

  const Responsive({
    super.key,
    required this.mobile,
    this.smallMobile,
    this.tablet,
    required this.desktop,
  });

  // ======================== Device Detection ========================

  static bool isSmallMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint &&
      MediaQuery.of(context).size.shortestSide < AppConstants.smallMobileBreakpoint;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < AppConstants.mobileBreakpoint;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.mobileBreakpoint &&
      MediaQuery.of(context).size.width < AppConstants.desktopBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= AppConstants.desktopBreakpoint;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  static DeviceSize deviceSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final shortest = MediaQuery.of(context).size.shortestSide;
    if (width < AppConstants.mobileBreakpoint && shortest < AppConstants.smallMobileBreakpoint) {
      return DeviceSize.smallMobile;
    }
    if (width < AppConstants.mobileBreakpoint) return DeviceSize.mobile;
    if (width < AppConstants.desktopBreakpoint) return DeviceSize.tablet;
    return DeviceSize.desktop;
  }

  // ======================== Adaptive Helpers ========================

  /// Grid columns based on device size and orientation
  static int gridColumns(BuildContext context) {
    final device = deviceSize(context);
    final landscape = isLandscape(context);

    switch (device) {
      case DeviceSize.smallMobile:
        return landscape ? 2 : 1;
      case DeviceSize.mobile:
        return landscape ? 2 : 2;
      case DeviceSize.tablet:
        return landscape ? 3 : 2;
      case DeviceSize.desktop:
        return 4;
    }
  }

  /// Adaptive padding based on screen size
  static double adaptivePadding(BuildContext context) {
    final device = deviceSize(context);
    switch (device) {
      case DeviceSize.smallMobile:
        return 8;
      case DeviceSize.mobile:
        return 12;
      case DeviceSize.tablet:
        return 20;
      case DeviceSize.desktop:
        return 24;
    }
  }

  /// Horizontal padding that accounts for landscape extra space
  static EdgeInsets adaptiveHPadding(BuildContext context) {
    final p = adaptivePadding(context);
    final landscape = isLandscape(context);
    return EdgeInsets.symmetric(
      horizontal: landscape ? p * 1.5 : p,
      vertical: p,
    );
  }

  /// Adaptive spacing between elements
  static double adaptiveSpacing(BuildContext context) {
    final device = deviceSize(context);
    switch (device) {
      case DeviceSize.smallMobile:
        return 8;
      case DeviceSize.mobile:
        return 12;
      case DeviceSize.tablet:
        return 16;
      case DeviceSize.desktop:
        return 20;
    }
  }

  /// Adaptive font scale factor
  static double fontScale(BuildContext context) {
    final device = deviceSize(context);
    switch (device) {
      case DeviceSize.smallMobile:
        return 0.85;
      case DeviceSize.mobile:
        return 0.92;
      case DeviceSize.tablet:
        return 1.0;
      case DeviceSize.desktop:
        return 1.0;
    }
  }

  /// Dialog width that works across all device sizes
  static double dialogWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final device = deviceSize(context);
    switch (device) {
      case DeviceSize.smallMobile:
      case DeviceSize.mobile:
        return width * 0.92;
      case DeviceSize.tablet:
        return width * 0.7;
      case DeviceSize.desktop:
        return 500;
    }
  }

  /// Chart height adaptive
  static double chartHeight(BuildContext context) {
    final device = deviceSize(context);
    final landscape = isLandscape(context);
    if (landscape && (device == DeviceSize.smallMobile || device == DeviceSize.mobile)) {
      return 200;
    }
    switch (device) {
      case DeviceSize.smallMobile:
        return 180;
      case DeviceSize.mobile:
        return 220;
      case DeviceSize.tablet:
        return 260;
      case DeviceSize.desktop:
        return 300;
    }
  }

  /// Whether to use compact mode (icon-only buttons, etc.)
  static bool useCompactMode(BuildContext context) {
    final device = deviceSize(context);
    return device == DeviceSize.smallMobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppConstants.desktopBreakpoint) {
          return desktop;
        } else if (constraints.maxWidth >= AppConstants.mobileBreakpoint) {
          return tablet ?? desktop;
        } else if (constraints.maxWidth < AppConstants.smallMobileBreakpoint &&
            smallMobile != null) {
          return smallMobile!;
        } else {
          return mobile;
        }
      },
    );
  }
}

// ======================== Extension ========================

extension ResponsiveExtension on BuildContext {
  // Device checks
  bool get isSmallMobileScreen => Responsive.isSmallMobile(this);
  bool get isMobileScreen => Responsive.isMobile(this);
  bool get isTabletScreen => Responsive.isTablet(this);
  bool get isDesktopScreen => Responsive.isDesktop(this);
  bool get isLandscapeScreen => Responsive.isLandscape(this);
  bool get isPortraitScreen => Responsive.isPortrait(this);

  // Device size
  DeviceSize get device => Responsive.deviceSize(this);

  // Adaptive values
  int get gridColumns => Responsive.gridColumns(this);
  double get adaptivePadding => Responsive.adaptivePadding(this);
  EdgeInsets get adaptiveHPadding => Responsive.adaptiveHPadding(this);
  double get adaptiveSpacing => Responsive.adaptiveSpacing(this);
  double get fontScale => Responsive.fontScale(this);
  double get dialogWidth => Responsive.dialogWidth(this);
  double get chartHeight => Responsive.chartHeight(this);
  bool get useCompactMode => Responsive.useCompactMode(this);

  // Screen dimensions
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
  double get shortestSide => MediaQuery.of(this).size.shortestSide;
}
