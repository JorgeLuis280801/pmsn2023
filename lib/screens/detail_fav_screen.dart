import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/favoritesdb.dart';
import 'package:pmsn2023/models/actor_model.dart';
import 'package:pmsn2023/models/favorites_model.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:convert';
import 'dart:ui';
import 'package:intl/intl.dart';

class DetailFavScreen extends StatefulWidget {
  const DetailFavScreen({super.key});

  @override
  State<DetailFavScreen> createState() => _DetailFavScreenState();
}

class _DetailFavScreenState extends State<DetailFavScreen> {

  String? trailerUrl;
  ActorModel? actorModel;
  FavoritesDB? favoritesDB;
  FavoriteModel? favoriteModel;

  late YoutubePlayerController _playerController;

  @override
  void initState() {
    super.initState();
    favoritesDB = FavoritesDB();
  }

  Future<String> fetchfavoriteModelTrailer(int favoriteModelId) async {
    final apiKey = 'b7246b6e44dee1713f99286903de41e0';
    final language = 'es-MX';
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$favoriteModelId/videos?api_key=$apiKey&language=$language');

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

  Future<List<ActorModel>> fetchfavoriteModelActors(int favoriteModelId) async {
    final apiKey = 'b7246b6e44dee1713f99286903de41e0'; // Reemplaza con tu clave de API de TMDb
    final language = 'es-MX';
    final url = Uri.parse('https://api.themoviedb.org/3/movie/$favoriteModelId/credits?api_key=$apiKey&language=$language');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final cast = data['cast'] as List;
      final filteredActors = cast
          .where((actorData) => actorData['known_for_department'] == 'Acting')
          .take(10) // Muestra solo los primeros 10 actores
          .map((actorData) => ActorModel.fromJson(actorData))
          .toList();
      return filteredActors;
    } else {
      throw Exception('Failed to load movie credits');
    }
  }

  @override
  Widget build(BuildContext context) {
    favoriteModel = ModalRoute.of(context)!.settings.arguments as FavoriteModel;

    final ElevatedButton btnFav = ElevatedButton(
      onPressed: (){
        showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: const Text("Confirmacion de borrado!!"),
                        content: const Text("Estas seguro de querer eliminar esta pelicula de tus favoritas?"),
                        actions: [
                          TextButton(
                            onPressed: (){
                              favoritesDB!.DELETEFav('tblFavoritos', favoriteModel!.clave_P!)
                              .then((value) {
                                Navigator.pop(context);
                                GlobalValue.flagFavoritos.value = !GlobalValue.flagFavoritos.value;
                              });
                            }, 
                            child: const Text('Borrar',
                            style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)))
                          ),
                          TextButton(
                            onPressed: ()=>Navigator.pop(context), 
                            child: const Text('Cancelar',
                            style: TextStyle(color: Color.fromARGB(255, 3, 97, 17)),)
                          ),
                        ],
                      );
                    }
                  );
      }, 
      child: const Row(
        children: [
          Text('Eliminar de mis favoritos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        ],
      )
    );

    fetchfavoriteModelTrailer(favoriteModel!.clave_P!).then((key) {
      setState(() {
        _playerController = YoutubePlayerController(
          initialVideoId: key,
          flags: const YoutubePlayerFlags(
            mute: true,
            autoPlay: false
          ),
        );
      });
    });

    Widget? reproductor;
    Widget? listaActores;

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

    try {
      listaActores = Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: FutureBuilder<List<ActorModel>>(
            future: fetchfavoriteModelActors(favoriteModel!.clave_P!), 
            builder: (context, snapshot) {
              final num_Actores = snapshot.data ?? [];
              if (num_Actores.length == 10) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Row(
                      children: num_Actores.map((actorModel) {
                        return Padding(
                          padding: EdgeInsets.only(right: 5, left: 5),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2.0
                                  )
                                ),
                                child: ClipOval(
                                  child: Image.network('https://image.tmdb.org/t/p/w500${actorModel!.profilePath!}',
                                    width: 75,
                                    height: 75,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(actorModel!.name!, 
                                style: const TextStyle(
                                  fontSize: 15, 
                                  fontWeight: FontWeight.bold, 
                                  color: Colors.black
                                ),
                              ),
                              Text(actorModel!.character!, 
                                style: const TextStyle(
                                  fontSize: 15, 
                                  color: Colors.black
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                );
              }else if (num_Actores.length < 10){
                return CircularProgressIndicator();
              }else {
                return CircularProgressIndicator();
              }
            },
          ),
        )
      );
    } catch (e) {
      listaActores = Text('');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(favoriteModel!.titulo!),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.network('https://image.tmdb.org/t/p/w500/${favoriteModel!.poster!}', 
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
                        child: Text(favoriteModel!.sinopsis!.toString(), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
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
                    child: Column(
                      children: [
                        const Text('Calificacion', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.black, 
                          fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        RatingBarIndicator(
                            rating: favoriteModel!.valoracion!,
                            itemBuilder: (context, index) => const Icon(
                                Icons.movie,
                                color: Colors.amber,
                            ),
                            itemCount: 10,
                            itemSize: 30.0,
                        ),
                        const SizedBox(height: 8),
                        Text('${favoriteModel!.valoracion!}/10', 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.black, 
                          fontSize: 15),
                        ),
                      ],
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
                    child: Column(
                      children: [
                        const Text('Trailer', 
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.black, 
                          fontSize: 20),
                        ),
                        const SizedBox(height: 8),
                        reproductor,
                      ],
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
                  child: Column(
                    children: [
                      const Text('Actores', 
                          style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          color: Colors.black, 
                          fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      listaActores,
                    ],
                  ),
                ),
                btnFav
              ]
            )
          ],
        ),
      ),  
    );
  }
}