
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screens/browseScreen/cubit/state.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';
import 'package:movie_app/utiles/network/dio_serves.dart';

class BrowseCubit extends Cubit<BrowseState> {
  BrowseCubit() : super(BrowseInitialState());
  static BrowseCubit get(context) => BlocProvider.of<BrowseCubit>(context);

  MoviesModel? moviesModel;
  int selectedIndex = 0;
  List<Movies> movies = [];
  List<String> genres = [];
  List<Movies> get selectedMovies => movies;
   getInitialData() async {
    try {
      emit(BrowseLoadingState());
      Response response = await DioServes.getMoviesData();
      if (response.statusCode == 200) {
        moviesModel = MoviesModel.fromJson(response.data);
        List<Movies> allMovies = moviesModel?.data?.movies ?? [];
        Set<String> extractedGenres = {};
        for (var movie in allMovies) {
          if (movie.genres != null) {
            extractedGenres.addAll(movie.genres!);
          }
        }
        genres = extractedGenres.toList();

        if (genres.isNotEmpty) {
          getMoviesByGenre(genres[selectedIndex]);
        }
      }
    } catch (error) {
      print(error.toString());
      emit(BrowseErrorState(error.toString()));
    }
  }

  void changeGenre(int index) {
    selectedIndex = index;
    emit(BrowseChangeGenreState());

    getMoviesByGenre(genres[selectedIndex]);
  }

  Future<void> getMoviesByGenre(String genreName) async {
    try {
      emit(BrowseLoadingState());
      Response response = await DioServes.getMoviesData(
        query: {
          "genre": genreName,
        },
      );
      if (response.statusCode == 200) {
        moviesModel = MoviesModel.fromJson(response.data);
        movies = moviesModel?.data?.movies ?? [];
        emit(BrowseSuccessState());
      }
    } catch (error) {
      print(error.toString());
      emit(BrowseErrorState(error.toString()));
    }
  }
}