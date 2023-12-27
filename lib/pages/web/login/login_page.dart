import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import '../../../blocs/blocs.dart';
import '../../../core/core.dart';
import '../../../data/data.dart';
import '../../../resources/colors.dart';
import '../../../router/router.dart';
import 'widgets/login_background.dart';
import 'widgets/login_sign_in.dart';
import 'widgets/login_sign_up.dart';

class LoginPage extends StatefulWidget {
  final LoginBloc bloc;
  const LoginPage({super.key, required this.bloc});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseState<LoginPage, LoginBloc>
    with TickerProviderStateMixin {
  var selectedDate = DateTime.now();
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

  var user = User(
    id: '1',
    email: 'user1@example.com',
    passWord: 'password123',
    userName: 'User One',
    dateOfBirth: '1990-01-15', // assuming 'YYYY-MM-DD' format
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
          StreamBuilder<bool?>(
              stream: bloc.isSuccessStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("data co roi ${snapshot.data}");
                  if (snapshot.data == true) {}
                }
                return Positioned(
                  bottom: 0.0,
                  left: maxWidthHalf * _signUpX.value,
                  right: -maxWidthHalf * _signUpX.value,
                  top: 0.0,
                  child: LoginSignUp(
                    onChanged: (value) {
                      bloc.SingUp(value).then((data) {
                        AwesomeDialog(
                            width: 600,
                            context: context,
                            dialogType: data == true? DialogType.info: DialogType.error,
                            animType: AnimType.leftSlide,
                            title: data == true?'Sign Up Success':'an error occurred',
                            //desc: 'Each question can only be answered once !',
                            btnCancelOnPress: () {
                              Navigator.pop(context);
                            },
                            btnOkOnPress: () {
                              controller.forward();
                            }).show();
                      });
                    },
                  ),
                );
              }),
          StreamBuilder<User?>(
              stream: bloc.quesTionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data;
                  String? token = snapshot.data?.id;
                  if (token != null) {
                    bloc.saveToken(token).then((value) {
                      Navigator.pushNamed(context, Routes.home,
                          arguments: data);
                    });
                  }
                }
                return Positioned(
                  bottom: 0.0,
                  left: -maxWidthHalf * _signInX.value,
                  right: maxWidthHalf * _signInX.value,
                  top: 0.0,
                  child: LoginSignIn(
                    onChanged: (value) async {
                      String email = value["email"] as String;
                      String password = value["password"] as String;

                      //bloc.signIn(email, password);
                      Navigator.pushNamed(context, Routes.home,
                          arguments: user);
                    },
                  ),
                );
              }),
          Positioned(
            left: 24 - maxWidthHalf * _signInX.value,
            top: 24,
            child: _buildBlackLogo(),
          ),
        ],
      ),
    );
  }

  Widget _buildBlackLogo() => const Icon(
        Icons.headphones_sharp,
        color: AppColors.primaryBlack,
        size: 64.0,
      );

  Widget _buildWhiteLogo() => const Icon(
        Icons.headphones_sharp,
        color: AppColors.primaryWhite,
        size: 64.0,
      );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  // TODO: implement bloc
  LoginBloc get bloc => widget.bloc;
}
