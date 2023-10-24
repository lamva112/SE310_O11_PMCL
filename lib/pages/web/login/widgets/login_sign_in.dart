import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/pages/web/login/widgets/custom_button.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

import '../../../../generated/l10n.dart';
import '../../../../router/router.dart';
import '../../../../widgets/custom_textfield/custom_textfield.dart';
import 'login_social.dart';

class LoginSignIn extends StatefulWidget {
  const LoginSignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginSignIn> createState() => __LoginSignInState();
}

class __LoginSignInState extends State<LoginSignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 48.0,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                S.of(context).sign_in_to_project,
                style: const TextStyle(
                  fontSize: 64.0,
                  color: AppColors.primaryBlack,
                  fontWeight: FontWeight.bold,
                ),
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
                S.of(context).or_use_your_email_account,
                style: const TextStyle(
                  color: AppColors.primaryBlack,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8.0),
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
              SizedBox(
                height: 48.0,
              ),
              _buildSignInButton(context),
            ],
          ),
        ),
      );

  Widget _buildSignInButton(BuildContext context) => Container(
        constraints: const BoxConstraints(
          maxWidth: 250.0,
        ),
        child: InkWellWrapper(
          paddingChild: EdgeInsets.symmetric(vertical: 16),
          width: 250,
          onTap: () {
            Navigator.pushNamed(context, Routes.home);
          },
          border: Border.all(
            color: AppColors.primaryBlack,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(30.0),
          color: AppColors.primaryBlack,
          child: Text(
            S.of(context).sign_in,
            style: const TextStyle(
              color: AppColors.primaryWhite,
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );

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
      contentPadding: EdgeInsets.symmetric(horizontal: 28, vertical: 22),
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
        borderSide: BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryBlack),
        borderRadius: BorderRadius.circular(15),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(15),
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }
}
