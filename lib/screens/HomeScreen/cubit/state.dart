abstract class HomeScreenState{}
class HomeScreenInitialState extends HomeScreenState{}
class GetMoviesLoadingData extends HomeScreenState{}
class GetMoviesSuccessData extends HomeScreenState{}
class GetMoviesErrorData extends HomeScreenState{
  String Error;
  GetMoviesErrorData(this.Error);
}