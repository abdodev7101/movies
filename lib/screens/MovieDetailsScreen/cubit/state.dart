abstract class MovieDetailsState {}
class MovieDetailsInitialState extends MovieDetailsState {}
class MovieDetailsLoadingState extends MovieDetailsState {}
class MovieDetailsSuccessState extends MovieDetailsState {}
class MovieDetailsErrorState extends MovieDetailsState {
  final String error;
  MovieDetailsErrorState(this.error);
}