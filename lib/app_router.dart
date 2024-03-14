// ignore_for_file: prefer_const_constructors, body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/data/repositories/movies_repository.dart';
import 'package:movies_app/data/web_services/movies_web_services.dart';
import 'package:movies_app/presentation/screens/Movies_screen.dart';
import 'package:movies_app/presentation/screens/movie_details_screen.dart';

import 'constants/settings.dart';
import 'data/models/movie.dart';

class AppRouter {
  late final MoviesRepository moviesRepository;
  late final MoviesCubit moviesCubit;

  AppRouter() {
    moviesRepository = MoviesRepository(MoviesWebServices());
    moviesCubit = MoviesCubit(moviesRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case moviesScreenRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => moviesCubit,
            child: MoviesScreen(),
          ),
        );
      case movieDetailsScreenRoute:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(builder: (_) => MovieDetailsScreen(movie: movie,));
    }
  }
}
