import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget largeScreen;
  final Widget? mediumScreen;
  final Widget? smallScreen;

  const ResponsiveWidget({
    Key? key,
    required this.largeScreen,
    this.mediumScreen,
    this.smallScreen,
  }) : super(key: key);

  static const double breakPointA = 640;
  static const double breakPointB = 1008;

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width <= breakPointA;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= breakPointB;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > breakPointA && MediaQuery.of(context).size.width < breakPointB;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakPointB) {
          return largeScreen;
        } else if (constraints.maxWidth < breakPointB && constraints.maxWidth > breakPointA) {
          return mediumScreen ?? largeScreen;
        } else {
          return smallScreen ?? largeScreen;
        }
      },
    );
  }
}
