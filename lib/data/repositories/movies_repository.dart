import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';

class MoviesRepository {
  final MoviesWebServices moviesWebServices;

  MoviesRepository(this.moviesWebServices);

  Future<List<Movie>> getMovies() async {
    final movies = await moviesWebServices.getMovies();
    return movies
        .map((movie) => Movie.fromJson(movie))
        .toList();
  }

}
