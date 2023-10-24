import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

import '../../../../generated/l10n.dart';
import '../../../../resources/colors.dart';
import '../../../../widgets/custom_textfield/custom_textfield.dart';
import 'custom_button.dart';
import 'login_social.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              S.of(context).create_account,
              overflow: TextOverflow.clip,
              style: TextStyle(fontSize: 64.0),
              textAlign: TextAlign.center,
            ),
          
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: LoginSocial(
                onFacebookPressed: () {},
                onGooglePressed: () {},
              ),
            ),
          
            Text(
              S.of(context).or_use_your_email_for_registration,
              style: const TextStyle(
                color: AppColors.primaryBlack,
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 24.0,bottom: 8.0),
              child: CustomTextField(
                  textFieldType: TextFieldType.email,
                  decorationConfig: textFieldDecorationConfig(
                    controller: _emailController,
                    hint: S.of(context).email,
                  ),
                  textFieldConfig:
                      textFieldConfig(controller: _emailController),
                ),
            ),
            
            CustomTextField(
                textFieldType: TextFieldType.password,
                decorationConfig: textFieldDecorationConfig(
                  controller: _passwordController,
                  hint: S.of(context).password,
                ),
                textFieldConfig:
                    textFieldConfig(controller: _passwordController),
              ),
            
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 48.0),
              child: CustomTextField(
                  textFieldType: TextFieldType.password,
                  decorationConfig: textFieldDecorationConfig(
                    controller: _confirmPasswordController,
                    hint: S.of(context).confirm_password,
                  ),
                  textFieldConfig:
                      textFieldConfig(controller: _confirmPasswordController),
                ),
            ),
          
            _buildSignUpButton(context),
          ],
        ),
      );


  Widget _buildSignUpButton(BuildContext context) => Container(
      constraints: const BoxConstraints(
        maxWidth: 250.0,
      ),
      child: InkWellWrapper(
        onTap: () {},
        width: 250,
        paddingChild: const EdgeInsets.symmetric(vertical: 16),
        border: Border.all(
          color: AppColors.primaryBlack,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(30.0),
        color: AppColors.primaryBlack,
        child: Text(
          S.of(context).sign_up,
          style: const TextStyle(
            color: AppColors.primaryWhite,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
          textAlign: TextAlign.center,
        ),
      ));

  TextFieldConfig textFieldConfig({required TextEditingController controller}) {
    return TextFieldConfig(
      validatorMode: AutovalidateMode.onUserInteraction,
      enableSuggestions: false,
      controller: controller,
      style: Theme.of(context)
          .textTheme
          .titleSmall
          ?.copyWith(color: AppColors.primaryBlack.withOpacity(0.3)),
      cursorColor: AppColors.primaryBlack.withOpacity(0.3),
    );
  }

  TextFieldDecorationConfig textFieldDecorationConfig(
      {required TextEditingController controller,
      String? hint,
      Widget? prefixIcon,
      Widget? suffixIcon}) {
    return TextFieldDecorationConfig(
      contentPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 22),
      fillColor: AppColors.primaryWhite,
      filled: true,
      hintText: hint,
      hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.primaryBlack.withOpacity(0.3)),
      errorStyle:
          Theme.of(context).textTheme.labelSmall?.copyWith(color: Colors.red),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
