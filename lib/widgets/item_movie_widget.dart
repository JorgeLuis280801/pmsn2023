import 'package:flutter/material.dart';
import 'package:pmsn2023/models/popular_model.dart';

Widget itemMovieWidget(PopularModel movie, context){
  return Hero(
    tag: 'moviePoster_${movie!.id}',
    child: GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, '/detail', arguments: movie),
      child: FadeInImage(
        fit: BoxFit.fill,
        fadeInDuration: const Duration(milliseconds: 500),
        placeholder: const AssetImage('assets/GIF/loading.gif'), 
        image: NetworkImage('https://image.tmdb.org/t/p/w500/${movie.posterPath}')
      ),
    ),
  );
}