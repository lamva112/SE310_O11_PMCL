import '../../core/core.dart';
import '../../data/data.dart';
import '../blocs.dart';

class LoginBloc extends BaseBloc<LoginState> {
  final IAuthRepository _questionRepository;
  final ISharedPreferencesRepository sharedPreferencesRepo;

  LoginBloc(this._questionRepository, this.sharedPreferencesRepo);

  Stream<bool?> get successStream =>
      stateStream.map((event) => event.success).distinct();
  Stream<String?> get errorStream => stateStream.map((event) => event.error);

  Stream<User?> get quesTionStream => stateStream.map((event) => event.user);

  Stream<bool?> get isSuccessStream =>
      stateStream.map((event) => event.isSignInSuccess);

  Future<void> signIn(String email, String password) async {
    _questionRepository
        .signInWithEmail(email, password)
        .then(
          (value) => value.fold(
            (e) => emit(LoginState(state: state, error: e.toString())),
            (data) async {
              emit(LoginState(state: state, user: data));
            },
          ),
        )
        .catchError((e) => emit(LoginState(state: state, error: e.toString())));
  }

  Future<bool> saveToken(String token) {
    return sharedPreferencesRepo.changeToken(token);
  }

  Future<void> signUp1(User user) async {
    _questionRepository
        .signUpWithEmail(user)
        .then(
          (value) => value.fold(
            (e) => emit(LoginState(state: state, error: e.toString())),
            (data) async {
              emit(LoginState(state: state, isSignInSuccess: data));
            },
          ),
        )
        .catchError((e) => emit(LoginState(state: state, error: e.toString())));
  }

  Future<bool?> SingUp(User user) async {
    final singleVocal = await _questionRepository.signUpWithEmail(user);
    return singleVocal.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }

  Future<User?> signIn1(String email, String password) async {
    final singleVocal = await _questionRepository.signInWithEmail(email, password);
    return singleVocal.fold((failure) {
      return Future.error(failure);
    }, (data) {
      return data;
    });
  }
}
