abstract class ProfileState{}
class ProfileInitialState extends ProfileState{}
class ProfileLoadingState extends ProfileState{}
class ProfileSuccessState extends ProfileState{}
class ProfileErrorState extends ProfileState{
  String Error;
  ProfileErrorState(this.Error);
}
class DeleteUserLoadingState extends ProfileState{}
class DeleteUserSuccessState extends ProfileState{}
class DeleteUserErrorState extends ProfileState{
  String error;
  DeleteUserErrorState(this.error);
}
class UpdateUserLoadingState extends ProfileState{}
class UpdateUserSuccessState extends ProfileState{}
class UpdateUserErrorState extends ProfileState{
  String error;
  UpdateUserErrorState(this.error);
}
class SignOutLoadingState extends ProfileState {}
class SignOutSuccessState extends ProfileState {}
class SignOutErrorState extends ProfileState {
  final String error;
  SignOutErrorState(this.error);
}