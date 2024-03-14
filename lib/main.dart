// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:movies_app/app_router.dart';


void main() {
  runApp(MoviesApp(appRouter: AppRouter(),));
}

class MoviesApp extends StatelessWidget {
  
  final AppRouter appRouter;

  const MoviesApp({super.key, required this.appRouter});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
