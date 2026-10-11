import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/screens/searchScreen/cubit/state.dart';
import 'package:movie_app/utiles/models/MoviesModels/movies_model.dart';
import 'package:movie_app/utiles/network/dio_serves.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of<SearchCubit>(context);
 final searchController = TextEditingController();

  List<Movies> results = [];
  Timer? _debounce;

  void onSearchChanged(String text) {
    _debounce?.cancel();
    if (text.trim().isEmpty) {
      results = [];
      emit(SearchInitialState());
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 500), () => search(text.trim()));
  }

  Future<void> search(String text) async {
    try {
      emit(SearchLoadingState());
      Response response = await DioServes.getMoviesData(
        query: {"query_term": text},
      );
      if (response.statusCode == 200) {
        results = MoviesModel.fromJson(response.data).data?.movies ?? [];
        emit(SearchSuccessState());
      } else {
        emit(SearchErrorState('Error: ${response.statusCode}'));
      }
    } catch (e) {
      emit(SearchErrorState(e.toString()));
    }
  }
  void clearSearch() {
    searchController.clear();
    results.clear();
    emit(SearchInitialState());
  }
  @override
  Future<void> close() {
    _debounce?.cancel();
    searchController.dispose();
    return super.close();
  }
}