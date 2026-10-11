import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/screens/MovieDetailsScreen/cubit/state.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';
import 'package:movie_app/utiles/network/dio_serves.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit() : super(MovieDetailsInitialState());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);
  Movies? movieDetails;
  List<Movies> similarMovies = [];

  Future<void> getMovieDetails(num movieId) async {
    emit(MovieDetailsLoadingState());

    try {
      Response response = await DioServes.getMovieDetailsData(
        query: {"movie_id": movieId},
      );

      final movieData = response.data?['data']?['movie'];

      if (response.statusCode == 200 && movieData != null) {
        movieDetails = Movies.fromJson(movieData);
        emit(MovieDetailsSuccessState());
       await getSimilarMovies(movieId);
      }
    } catch (error) {
      emit(MovieDetailsErrorState(error.toString()));
    }

  }
  Future<void> getSimilarMovies(num movieId) async {
    try {
      Response response = await DioServes.getMovieSuggestions(
        query: {"movie_id": movieId},
      );
      if (response.statusCode == 200 && response.data != null) {
        MoviesModel model = MoviesModel.fromJson(response.data);
        similarMovies = model.data?.movies ?? [];
        emit(MovieDetailsSuccessState());
      }
    } catch (error) {
      emit(MovieDetailsErrorState(error.toString()));
    }
  }
}