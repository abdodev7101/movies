abstract class RegisterState {}
class RegisterInitialState extends RegisterState {}
class RegisterAvatarChangedState extends RegisterState {}
class RegisterLoadingState extends RegisterState {}
class RegisterSuccessState extends RegisterState {}
class RegisterErrorState extends RegisterState {
  final String Errormessage;
  RegisterErrorState(this.Errormessage);
}