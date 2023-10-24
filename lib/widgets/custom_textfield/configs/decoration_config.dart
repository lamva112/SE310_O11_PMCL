import 'package:flutter/material.dart';

class TextFieldDecorationConfig {
  final InputBorder? errorBorder;
  final InputBorder? focusedBorder;
  final InputBorder? focusedErrorBorder;
  final InputBorder? disabledBorder;
  final InputBorder? enabledBorder;
  final InputBorder? border;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool enabled;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;
  final Widget? label;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final String? helperText;
  final TextStyle? helperStyle;
  final TextStyle? errorStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? filled;
  final Color? fillColor;
  final Color? focusColor;
  final Color? hoverColor;
  final BoxConstraints? constraints;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextDirection? hintTextDirection;
  final Color? visiblePasswordIconColor;
  final bool showVisiblePasswordIcon;
  final double? visiblePasswordIconSize;
  final bool? isCollapsed;
  final bool? isDense;
  final String? showCounterText;
  final TextStyle? counterStyle;
  final String? errorText;
  final Color? suffixBtnSplashColor;
  final Color? suffixBtnHighlightColor;
  final String? errorMessage;
  final Widget? suffix;

  const TextFieldDecorationConfig({
    this.suffixIcon,
    this.suffixIconConstraints,
    this.isCollapsed,
    this.isDense,
    this.border,
    this.disabledBorder,
    this.enabledBorder,
    this.errorBorder,
    this.focusedBorder,
    this.focusedErrorBorder,
    this.hintStyle,
    this.hintText,
    this.enabled = true,
    this.prefixIcon,
    this.floatingLabelStyle,
    this.helperStyle,
    this.helperText,
    this.label,
    this.labelStyle,
    this.labelText,
    this.errorStyle,
    this.contentPadding,
    this.filled,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.constraints,
    this.floatingLabelBehavior,
    this.hintTextDirection,
    this.prefixIconConstraints,
    this.visiblePasswordIconColor,
    this.showVisiblePasswordIcon = true,
    this.visiblePasswordIconSize,
    this.showCounterText,
    this.counterStyle,
    this.errorText,
    this.suffixBtnHighlightColor,
    this.suffixBtnSplashColor,
    this.errorMessage,
    this.suffix,
  });
}
