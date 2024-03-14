// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';
import 'package:movies_app/data/models/movie.dart';

import '../../constants/settings.dart';

class MovieItemCard extends StatelessWidget {
  final Movie movie;

  const MovieItemCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: AppColors.appWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: (){
          Navigator.pushNamed(context, movieDetailsScreenRoute, arguments: movie);
        },
        child: GridTile(
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text('${movie.name}',  style: TextStyle(
              height: 1.3,
              fontSize: 16,
              color: AppColors.appWhite,
              fontWeight: FontWeight.bold,
            ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),

          ),
          child: Hero(
            tag: movie.movieId,
            child: Container(
              color: AppColors.appWhite,
              child: movie.image.isNotEmpty
                  ? FadeInImage.assetNetwork(
                      width:double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: 'assets/images/loading.gif',
                      image: movie.image)
                  : Image.asset('assets/images/placeholder.jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
