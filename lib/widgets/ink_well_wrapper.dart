import 'package:flutter/material.dart';

class InkWellWrapper extends StatelessWidget {
  final Color? color;
  final VoidCallback? onTap;
  final Widget child;
  final BorderRadius? borderRadius;
  final Color? splashColor;
  final Color? highlightColor;
  final Color? hoverColor;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? paddingChild;
  final EdgeInsetsGeometry margin;
  final Border? border;
  final BoxConstraints? childConstraints;
  final Gradient? gradient;

  const InkWellWrapper({
    Key? key,
    this.color,
    this.onTap,
    required this.child,
    this.borderRadius,
    this.splashColor = const Color.fromRGBO(102, 102, 102, 0.24),
    this.highlightColor = const Color.fromRGBO(102, 102, 102, 0.24),
    this.hoverColor = const Color.fromRGBO(102, 102, 102, 0.24),
    this.height,
    this.width,
    this.paddingChild,
    this.border,
    this.margin = EdgeInsets.zero,
    this.childConstraints,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius,
            border: border,
            gradient: gradient,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              highlightColor: highlightColor,
              splashColor: splashColor,
              hoverColor: hoverColor,
              child: Container(
                height: height,
                width: width,
                constraints: childConstraints,
                padding: paddingChild,
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
