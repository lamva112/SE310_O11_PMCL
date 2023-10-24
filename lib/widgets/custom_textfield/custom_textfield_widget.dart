import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_textfield.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.textFieldType,
    this.textFieldKey,
    this.textFieldConfig = const TextFieldConfig(),
    this.decorationConfig = const TextFieldDecorationConfig(),
    this.validator,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.onChanged,
    this.showCursor,
    this.isTransparent = false,
    this.onTap,
    this.borderRadius,
    this.inputFormatters,
  }) : super(key: key);

  final bool? showCursor;
  final TextFieldType textFieldType;
  final GlobalKey<EditableTextState>? textFieldKey;
  final TextFieldConfig textFieldConfig;
  final TextFieldDecorationConfig decorationConfig;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final bool isTransparent;
  final BorderRadius? borderRadius;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late final TextEditingController? _controller = widget.textFieldConfig.controller;
  bool _isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: widget.showCursor ?? true,
      showCursor: widget.showCursor ?? true,
      key: widget.textFieldKey,
      maxLength: widget.textFieldConfig.maxLength,
      focusNode: widget.textFieldConfig.focusNode,
      textAlign: widget.textFieldConfig.textAlign,
      textDirection: widget.textFieldConfig.textDirection,
      style: widget.textFieldConfig.style,
      autofocus: widget.textFieldConfig.autoFocus,
      maxLines: widget.textFieldType == TextFieldType.password ? 1 : widget.textFieldConfig.maxLines,
      controller: _controller,
      autocorrect: widget.textFieldConfig.autocorrect,
      initialValue: widget.textFieldConfig.initialValue,
      cursorColor: widget.textFieldConfig.cursorColor,
      cursorHeight: widget.textFieldConfig.cursorHeight,
      cursorWidth: widget.textFieldConfig.cursorWidth,
      cursorRadius: widget.textFieldConfig.cursorRadius,
      textCapitalization: widget.textFieldType == TextFieldType.name ? TextCapitalization.words : TextCapitalization.none,
      enabled: widget.textFieldConfig.isEnabled,
      enableSuggestions: widget.textFieldConfig.enableSuggestions,
      keyboardType: _getKeyboardType(),
      obscureText: widget.textFieldType == TextFieldType.password ? _isObscureText : false,
      onChanged: widget.onChanged,
      onEditingComplete: widget.onEditingComplete,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscuringCharacter: widget.textFieldConfig.obscureCharacter,
      onSaved: widget.onSaved,
      textAlignVertical: widget.textFieldConfig.textAlignVertical,
      readOnly: widget.textFieldConfig.readOnly,
      textInputAction: widget.textFieldConfig.textInputAction,
      scrollPadding: widget.textFieldConfig.scrollPadding ?? const EdgeInsets.all(20.0),
      autovalidateMode: widget.textFieldConfig.validatorMode ?? AutovalidateMode.always,
      validator: widget.validator ??
          (value) {
            return _verifyData(value);
          },
      decoration: InputDecoration(
        counterStyle: widget.decorationConfig.counterStyle ?? const TextStyle(height: double.minPositive, color: Colors.transparent),
        counterText: widget.decorationConfig.showCounterText,
        constraints: widget.decorationConfig.constraints,
        border: widget.decorationConfig.border,
        contentPadding: widget.decorationConfig.contentPadding,
        isCollapsed: widget.decorationConfig.isCollapsed ?? false,
        isDense: widget.decorationConfig.isDense ?? false,
        disabledBorder: widget.decorationConfig.disabledBorder,
        focusedBorder: widget.decorationConfig.focusedBorder ?? _getTextFieldBorder(),
        errorBorder: widget.decorationConfig.errorBorder ?? _getTextFieldBorder(isErrorType: true),
        focusedErrorBorder: widget.decorationConfig.focusedErrorBorder ?? _getTextFieldBorder(isErrorType: true),
        enabled: widget.decorationConfig.enabled,
        enabledBorder: widget.decorationConfig.enabledBorder ?? _getTextFieldBorder(),
        errorStyle: widget.decorationConfig.errorStyle ?? TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
        fillColor: widget.decorationConfig.fillColor,
        filled: widget.decorationConfig.filled,
        floatingLabelStyle: widget.decorationConfig.floatingLabelStyle,
        floatingLabelBehavior: widget.decorationConfig.floatingLabelBehavior,
        focusColor: widget.decorationConfig.focusColor,
        helperText: widget.decorationConfig.helperText,
        helperStyle: widget.decorationConfig.helperStyle,
        hintText: widget.decorationConfig.hintText,
        hintStyle: widget.decorationConfig.hintStyle,
        hintTextDirection: widget.decorationConfig.hintTextDirection,
        labelText: widget.decorationConfig.labelText,
        label: widget.decorationConfig.label,
        labelStyle: widget.decorationConfig.labelStyle,
        hoverColor: widget.decorationConfig.hoverColor,
        prefixIcon: widget.decorationConfig.prefixIcon,
        prefixIconConstraints: widget.decorationConfig.prefixIconConstraints,
        suffixIcon: _suffixIconBuilder(),
        suffixIconConstraints: widget.decorationConfig.suffixIconConstraints,
        suffix: widget.decorationConfig.suffix,
      ),
      inputFormatters: widget.inputFormatters,
    );
  }

  Widget? _suffixIconBuilder() {
    if (widget.decorationConfig.suffixIcon != null) {
      return widget.decorationConfig.suffixIcon;
    }

    if (widget.textFieldType == TextFieldType.password && widget.decorationConfig.showVisiblePasswordIcon) {
      return IconButton(
        icon: Icon(
          _isObscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: widget.decorationConfig.visiblePasswordIconColor ?? Colors.grey,
          size: widget.decorationConfig.visiblePasswordIconSize,
        ),
        splashColor: widget.decorationConfig.suffixBtnSplashColor,
        highlightColor: widget.decorationConfig.suffixBtnHighlightColor,
        onPressed: () {
          setState(() {
            _isObscureText = !_isObscureText;
          });
        },
      );
    }

    return null;
  }

  TextInputType _getKeyboardType() {
    switch (widget.textFieldType) {
      case TextFieldType.text:
      case TextFieldType.password:
        return TextInputType.text;
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.phoneNumber:
        return TextInputType.phone;
      case TextFieldType.multiline:
        return TextInputType.multiline;
      case TextFieldType.name:
        return TextInputType.name;
      case TextFieldType.number:
        return TextInputType.number;
    }
  }

  OutlineInputBorder _getTextFieldBorder({bool isErrorType = false}) {
    var defaultBorder = OutlineInputBorder(
      borderSide: BorderSide(color: isErrorType ? Colors.red : Colors.grey, width: 0.5),
      borderRadius: widget.borderRadius ?? const BorderRadius.all(Radius.circular(4.0)),
    );

    return defaultBorder;
  }

  String? _verifyData(String? value) {
    switch (widget.textFieldType) {
      case TextFieldType.text:
        return null;
      case TextFieldType.password:
        return TextFieldValidatorUtils.validatePassword(value, errorMessage: widget.decorationConfig.errorMessage);
      case TextFieldType.email:
        return TextFieldValidatorUtils.validateEmail(value, errorMessage: widget.decorationConfig.errorMessage);
      case TextFieldType.phoneNumber:
        return TextFieldValidatorUtils.validatePhoneNumber(value, errorMessage: widget.decorationConfig.errorMessage);
      case TextFieldType.multiline:
        return null;
      case TextFieldType.name:
        return TextFieldValidatorUtils.validateName(value, errorMessage: widget.decorationConfig.errorMessage);
      case TextFieldType.number:
        return null;
    }
  }
}
