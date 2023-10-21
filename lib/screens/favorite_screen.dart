import 'package:flutter/material.dart';
import 'package:pmsn2023/assets/global_values.dart';
import 'package:pmsn2023/database/favoritesdb.dart';
import 'package:pmsn2023/models/favorites_model.dart';
import 'package:pmsn2023/widgets/item_favMov_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {

  FavoritesDB? favoritesDB;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoritesDB = FavoritesDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ValueListenableBuilder(
        valueListenable: GlobalValue.flagFavoritos, 
        builder: (context, value, _){
          return FutureBuilder(
            future: favoritesDB!.GETALLFAV(), 
            builder: (BuildContext context, AsyncSnapshot<List<FavoriteModel>> snapshot){
              if (snapshot.hasData) {
                return GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index){
                    return itemFavMovWidget(snapshot.data![index], context);
                  }
                );
              }else {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text('E we se nos cayo el sistema!! :v'),
                  );
                } else{
                  return CircularProgressIndicator();
                }
              }
            }
          );
        }
      ),
    );
  }
}