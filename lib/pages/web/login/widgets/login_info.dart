import 'package:flutter/material.dart';
import 'package:se310_o11_pmcl/pages/web/login/widgets/custom_button.dart';
import 'package:se310_o11_pmcl/resources/colors.dart';
import 'package:se310_o11_pmcl/widgets/ink_well_wrapper.dart';

class LoginInfo extends StatelessWidget {
  const LoginInfo({
    required this.content,
    required this.label,
    required this.onPressed,
    required this.title,
    Key? key,
  }) : super(key: key);

  final String content;
  final String label;
  final VoidCallback onPressed;
  final String title;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              // style: AppTextStyles.h1().copyWith(
              //   fontSize: 64.0,
              //   color: AppColors.white,
              // ),
              style: const TextStyle(
                color: AppColors.primaryWhite,
                fontWeight: FontWeight.bold,
                fontSize: 64,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32,
            ),
            Text(
              content,
              // style: AppTextStyles.h3().copyWith(
              //   color: AppColors.white,
              //   fontWeight: FontWeight.normal,
              // ),
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryWhite),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 64.0,
            ),
            InkWellWrapper(
              onTap: onPressed,
                paddingChild:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.primaryWhite),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    letterSpacing: 0.5,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      );

    
}
