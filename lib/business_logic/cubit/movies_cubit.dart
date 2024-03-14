import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/data/repositories/movies_repository.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final MoviesRepository moviesRepository;
  List<Movie> movies =[];
  MoviesCubit(this.moviesRepository) : super(MoviesInitial());

  List<Movie> getMovies(){
    moviesRepository.getMovies().then((movies) {
      emit(MoviesLoaded(movies));
      this.movies = movies;
    });
    return movies;
  }
}
