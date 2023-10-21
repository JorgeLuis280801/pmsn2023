import 'package:flutter/material.dart';
import 'package:pmsn2023/models/favorites_model.dart';

Widget itemFavMovWidget(FavoriteModel fav, context){
  return GestureDetector(
    onTap: ()=> Navigator.pushNamed(context, '/dfav', arguments: fav),
    child: FadeInImage(
      fit: BoxFit.fill,
      fadeInDuration: const Duration(milliseconds: 500),
      placeholder: const AssetImage('assets/GIF/loading.gif'), 
      image: NetworkImage('https://image.tmdb.org/t/p/w500/${fav.poster}')
    ),
  );
}