import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pmsn2023/firebase/favorites_database.dart';

class Popular_Fire_Screen extends StatefulWidget {
  const Popular_Fire_Screen({super.key});

  @override
  State<Popular_Fire_Screen> createState() => _Popular_Fire_ScreenState();
}

class _Popular_Fire_ScreenState extends State<Popular_Fire_Screen> {

  Fav_Firebase? _fav_firebase;

  @override
  void initState() {
    super.initState();
    _fav_firebase = Fav_Firebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _fav_firebase!.getAllFavorites(), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.network(snapshot.data!.docs[index].get('image')),
                    Text(snapshot.data!.docs[index].get('title'))
                  ],
                );
              },
            );
          }else{
            if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            }else{
              return Center(
                child: Text('No hay datos :v'),
              );
            }
          }
        }
      ),
    );
  }
}