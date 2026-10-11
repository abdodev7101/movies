abstract class ForgetPasswordState{}
class ForgetPasswordInitialState extends ForgetPasswordState{}
class ForgetPasswordLoadingState extends ForgetPasswordState{}
class ForgetPasswordSuuccessState extends ForgetPasswordState{}
class ForgetPasswordErrorState extends ForgetPasswordState{
  String Error;
  ForgetPasswordErrorState(this.Error);
}