import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pmsn2023/models/popular_model.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key});

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  
  PopularModel? movie;
  String? trailerUrl;

  late YoutubePlayerController _playerController;

  Future<String> fetchMovieTrailer(int movieId) async {
    final apiKey = 'b7246b6e44dee1713f99286903de41e0';
    final language = 'es-MX';
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=$language');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      for (final video in results) {
        if(video['type'] == 'Trailer' && video['site'] == 'YouTube'){
          return video['key'];
        }
      }
    }
    return '';
  }
  
  @override
  Widget build(BuildContext context) {
    
    movie = ModalRoute.of(context)!.settings.arguments as PopularModel;

    fetchMovieTrailer(movie!.id!).then((key) {
      setState(() {
        _playerController = YoutubePlayerController(
          initialVideoId: key,
          flags: YoutubePlayerFlags(
            autoPlay: true,
            mute: true
          ),
        );
      });
    });

    Widget? reproductor;

    try {
      if (_playerController.initialVideoId != '') {
        reproductor = YoutubePlayer(
          controller: _playerController,
          actionsPadding: EdgeInsets.only(left: 16.0),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
          ],
        );
      }else{
        reproductor = const Text(
          'Trailer de la Pelicula no disponible :(',
          style: TextStyle(
            fontSize: 35.0,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        );
      }
    } catch (e) {
      reproductor = Text('');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(movie!.title!),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.network('https://image.tmdb.org/t/p/w500/${movie!.posterPath!}', 
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
            Container(
              width: double.infinity,
              height: double.infinity,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: 
                  Column(
                    children: [
                      const Center(
                        child: Text('Sinopsis', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),)
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(movie!.overview!.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: RatingBarIndicator(
                        rating: movie!.voteAverage!,
                        itemBuilder: (context, index) => const Icon(
                            Icons.movie,
                            color: Colors.amber,
                        ),
                        itemCount: 10,
                        itemSize: 30.0,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: reproductor,
                  ),
                )
              ]
            )
          ],
        ),
      ),  
    );
  }
}