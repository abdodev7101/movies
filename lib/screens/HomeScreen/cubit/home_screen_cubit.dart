import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screens/HomeScreen/cubit/state.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';
import 'package:movie_app/utiles/network/dio_serves.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  HomeScreenCubit() : super(HomeScreenInitialState());
  static HomeScreenCubit get(context) =>
      BlocProvider.of<HomeScreenCubit>(context);
  List<Movies> movies = [];
  MoviesModel? moviesModel;
  List<Movies> genreMovies = [];
  final ScrollController scrollController = ScrollController();
  int currentIndex = 0;
  getMoviesData() async {
    try {
      emit(GetMoviesLoadingData());
      Response response = await DioServes.getMoviesData(
        query: {"quality": "3D"},
      );
      if (response.statusCode == 200) {
        moviesModel = MoviesModel.fromJson(response.data);
        movies = moviesModel?.data?.movies ?? [];
        filterMoviesByGenre();
        emit(GetMoviesSuccessData());
      }
    } catch (Error) {
      print(Error.toString());
      emit(GetMoviesErrorData(Error.toString()));
    }
  }

  Map<String, List<Movies>> moviesByGenre = {};

  void filterMoviesByGenre() {
    moviesByGenre.clear();
    for (final movie in movies) {
      for (final genre in movie.genres ?? <String>[]) {
        moviesByGenre.putIfAbsent(genre, () => []);
        moviesByGenre[genre]!.add(movie);
      }
    }
  }
  }
