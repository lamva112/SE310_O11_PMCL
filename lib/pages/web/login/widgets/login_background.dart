
import 'package:flutter/material.dart';
import 'login_info.dart';

import '../../../../resources/colors.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({
    required this.onSignInPressed,
    required this.onSignUpPressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onSignInPressed;
  final VoidCallback onSignUpPressed;

  @override
  Widget build(BuildContext context) => Container(
        color: AppColors.primaryBlack,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: LoginInfo(
                content: 'To keep connected with us please login with your personal info',
                label: 'Sign in',
                onPressed: onSignInPressed,
                title: 'Welcome Back!',
              ),
            ),
            Expanded(
              child: LoginInfo(
                content: 'Enter your personal details and start journey with us',
                label: 'Sign up',
                onPressed: onSignUpPressed,
                title: 'Hello, Friend!',
              ),
            ),
          ],
        ),
      );
}
