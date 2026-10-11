abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {}

class LoginErrorState extends LoginState {
  final String Errormessage;
  LoginErrorState(this.Errormessage);
}
class GetUserLoadingState extends LoginState {}

class GetUserSuccessState extends LoginState {}

class GetUserErrorState extends LoginState {
  final String error;
  GetUserErrorState(this.error);
}
class LoginChangePasswordVisibilityState extends LoginState {}
