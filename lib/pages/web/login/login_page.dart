import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../resources/colors.dart';
import 'widgets/login_background.dart';
import 'widgets/login_sign_in.dart';
import 'widgets/login_sign_up.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc bloc;
  const LoginPage({super.key, required this.bloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage,LoginBloc> with TickerProviderStateMixin{
    late final AnimationController controller = AnimationController(
    duration: const Duration(
      milliseconds: 500,
    ),
    vsync: this,
  );

  late final Animation<double> _slideX = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    ),
  );
  late final Animation<double> _signUpX = Tween(
    begin: 1.0,
    end: 0.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    ),
  );
  late final Animation<double> _signInX = Tween(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
    ),
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxWidthHalf = maxWidth * .5;
    return Scaffold(
      body: Stack(
        children: [
          LoginBackground(
            onSignInPressed: controller.reverse,
            onSignUpPressed: controller.forward,
          ),
          Positioned(
            left: 24.0,
            top: 24.0,
            child: _buildWhiteLogo(),
          ),
          AnimatedBuilder(
            animation: controller,
            builder: (_, __) => Positioned(
              bottom: 0.0,
              left: maxWidthHalf * _slideX.value,
              top: 0.0,
              child: _buildSlideContainer(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSlideContainer() {
    final maxWidth = MediaQuery.of(context).size.width;
    final maxWidthHalf = maxWidth * .5;
    return Container(
      color: AppColors.primaryWhite,
      width: maxWidthHalf,
      child: Stack(
        children: [
          Positioned(
            bottom: 0.0,
            left: maxWidthHalf * _signUpX.value,
            right: -maxWidthHalf * _signUpX.value,
            top: 0.0,
            child: const LoginSignUp(),
          ),
          Positioned(
            bottom: 0.0,
            left: -maxWidthHalf * _signInX.value,
            right: maxWidthHalf * _signInX.value,
            top: 0.0,
            child: const LoginSignIn(),
          ),
          Positioned(
            left:
                24 - maxWidthHalf * _signInX.value,
            top:24,
            child: _buildBlackLogo(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlackLogo() => const Icon(
        Icons.shop,
        color: AppColors.primaryBlack,
        size: 64.0,
      );

  Widget _buildWhiteLogo() => const Icon(
        Icons.shop,
        color: AppColors.primaryWhite,
        size: 64.0,
      );
      
        @override
        // TODO: implement bloc
        LoginBloc get bloc => widget.bloc;
}