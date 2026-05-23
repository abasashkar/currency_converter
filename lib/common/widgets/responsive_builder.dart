import 'package:currency_app/common/constants/app_constants.dart';
import 'package:flutter/material.dart';
class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width >= AppConstants.tabletBreakpoint) {
      return desktop ?? tablet ?? mobile;
    }
    if (width >= AppConstants.mobileBreakpoint) {
      return tablet ?? mobile;
    }
    return mobile;
  }
}
