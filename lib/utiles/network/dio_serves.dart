import 'package:dio/dio.dart';
import 'package:movie_app/utiles/network/dio_end_points.dart';
import 'package:movie_app/utiles/remote/end_points.dart';

abstract class DioServes {
  static final dio = Dio();
  static getMoviesData({Map<String,dynamic>? quality,data,query})async{
    final response = await dio.get(
      "${DioEndPoints.movieUrl}${DioEndPoints.movieEndPoint}",
      queryParameters: query,
      data: data,
    );
    return response;
  }
  static Future<Response> getMovieDetailsData({Map<String, dynamic>? query}) async {
    return await dio.get(
      '${DioEndPoints.movieDetailsUrl}',
      queryParameters: query,
    );
  }
  static Future<Response> getMovieSuggestions({Map<String, dynamic>? query}) async {
    return await dio.get(
      '${DioEndPoints.movieSuggestionUrl}',
      queryParameters: query,
    );
  }
}