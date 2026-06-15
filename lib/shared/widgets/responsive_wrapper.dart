import 'package:flutter/material.dart';
import 'package:group_flutter_pages_demo/core/constants/app_constants.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({required this.child, super.key, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppConstants.contentMaxWidth),
        child: Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}

enum ScreenSize { mobile, tablet, desktop }

ScreenSize screenSize(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  if (width < AppConstants.mobileBreakpoint) return ScreenSize.mobile;
  if (width < AppConstants.tabletBreakpoint) return ScreenSize.tablet;
  return ScreenSize.desktop;
}

int crossAxisCount(BuildContext context, {int mobile = 1, int tablet = 2, int desktop = 3}) {
  return switch (screenSize(context)) {
    ScreenSize.mobile => mobile,
    ScreenSize.tablet => tablet,
    ScreenSize.desktop => desktop,
  };
}
