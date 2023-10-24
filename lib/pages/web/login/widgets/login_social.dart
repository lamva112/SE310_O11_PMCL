import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../resources/colors.dart';
import 'custom_button.dart';

class LoginSocial extends StatelessWidget {
  const LoginSocial({
    required this.onFacebookPressed,
    required this.onGooglePressed,
    Key? key,
  }) : super(key: key);

  final VoidCallback onFacebookPressed;
  final VoidCallback onGooglePressed;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildGoogle(context),
          const SizedBox(
            width: 24,
          ),
          _buildFacebook(context),
        ],
      );

  Widget _buildGoogle(BuildContext context) => SizedBox.square(
        dimension: 48.0,
        child: CustomButton(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBlack,
          ),
          onPressed: onGooglePressed,
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(
            'assets/images/svg/google.svg',
            color: AppColors.primaryWhite,
          ),
        ),
      );

  Widget _buildFacebook(BuildContext context) => SizedBox.square(
        dimension: 48.0,
        child: CustomButton(
          padding: EdgeInsets.zero,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryBlack,
          ),
          onPressed: onFacebookPressed,
          child: const Center(
            child: Icon(
              Icons.facebook,
              color: AppColors.primaryWhite,
              size: 36.0,
            ),
          ),
        ),
      );
}
