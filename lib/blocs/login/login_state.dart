import 'package:equatable/equatable.dart';

import '../../data/data.dart';

class LoginState extends Equatable {
  final bool? success;
  final String? error;
  final User? user;
  final bool? isSignInSuccess;
  LoginState({
    LoginState? state,
    bool? success,
    String? error,
    User? user,
    bool? isSignInSuccess,
  })  : success = success ?? state?.success,
        error = error ?? state?.error,
        user = user ?? state?.user,isSignInSuccess = isSignInSuccess ?? state?.isSignInSuccess;

  @override
  List<Object?> get props => [success, error,user,isSignInSuccess];
}
