// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';

import '../../data/models/movie.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  movieInfo('About : ', movie.address),
                  buildDivider(318),
                  movieInfo('Director : ', movie.name),
                  buildDivider(305),
                  movieInfo('Writer : ', movie.name),
                  buildDivider(315),
                  movieInfo('Rating : ', '8.5'),
                  buildDivider(315),
                  movieInfo('Gender : ', movie.gender),
                  buildDivider(308),
                  movieInfo('Status : ', movie.status),
                  buildDivider(311),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(height: 600),
          ]))
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.appGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.name,
          style: TextStyle(color: AppColors.appWhite),
        ),
        background: Hero(
            tag: movie.movieId,
            child: Image.network(
              movie.image,
              fit: BoxFit.cover,
            )),
      ),
    );
  }

  Widget movieInfo(String title, String info) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(children: [
        TextSpan(
            text: title,
            style: TextStyle(
                color: AppColors.appWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18)),
        TextSpan(
            text: info,
            style: TextStyle(color: AppColors.appWhite, fontSize: 16)),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: AppColors.appRed,
      thickness: 2,
    );
  }
}
