

// ignore_for_file: prefer_const_constructors

import 'package:dio/dio.dart';
import 'package:movies_app/constants/settings.dart';

class MoviesWebServices{
  late Dio dio;
  MoviesWebServices(){
    BaseOptions options = BaseOptions(
      baseUrl: baseURL,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 20),
      receiveTimeout: Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getMovies() async {
    try{
      Response response = await dio.get('character');
      return response.data['results'];
    }catch(e){
      print(e);
      return [];
    }
  }

}