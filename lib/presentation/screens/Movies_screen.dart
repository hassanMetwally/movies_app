// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/cubit/movies_cubit.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/data/models/movie.dart';
import 'package:movies_app/presentation/widgets/movie_item_card.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  late List<Movie> allMoviesList;
  late List<Movie> searchedMoviesList;
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<MoviesCubit>(context).getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appRed,
        leading: _isSearching? BackButton(color: AppColors.appGrey): Container(),
        title: _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlockWidget(),
    );
  }

  Widget _buildAppBarTitle() {
    if (_isSearching) {
      return TextField(
        controller: _searchTextController,
        cursorColor: AppColors.appGrey,
        decoration: InputDecoration(
          hintText: 'Find a Movie...',
          border: InputBorder.none,
          hintStyle: TextStyle(color: AppColors.appGrey, fontSize: 18),
        ),
        style: TextStyle(color: AppColors.appGrey, fontSize: 18),
        onChanged: (searchedMovie) {
          addSearchedItemToSearchedList(searchedMovie);
        },
      );
    } else {
      return Text(
        'Movies',
        style: TextStyle(color: AppColors.appGrey),
      );
    }
  }

  void addSearchedItemToSearchedList(String searchedMovie) {
    searchedMoviesList = allMoviesList
        .where((movie) =>
        movie.name.toLowerCase().startsWith(searchedMovie))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
            onPressed: () {
              _clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.close,
              color: AppColors.appGrey,
            ))
      ];
    } else {
      return [
        IconButton(
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: AppColors.appGrey,
            )
        ),
      ];
    }
  }

  void _startSearch(){
    _isSearching = true;
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
  }

  void _stopSearching(){
    _clearSearch();
    _isSearching = false;
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }


  Widget buildBlockWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
      if (state is MoviesLoaded) {
        allMoviesList = (state).movies;
        return buildLoadedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget buildLoadedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: AppColors.appGrey,
        child: buildMoviesListWidget(),
      ),
    );
  }

  Widget buildMoviesListWidget() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _searchTextController.text.isEmpty? allMoviesList.length:searchedMoviesList.length ,
        itemBuilder: (context, index) {
          return MovieItemCard(movie: _searchTextController.text.isEmpty? allMoviesList[index]: searchedMoviesList[index]);
        });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.appRed,
      ),
    );
  }
}
