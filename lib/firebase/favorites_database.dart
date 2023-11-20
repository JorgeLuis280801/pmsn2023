import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Fav_Firebase {
  
  FirebaseFirestore _firebase = FirebaseFirestore.instance;
  CollectionReference? _favoritesCollection;
  Fav_Firebase(){
    _favoritesCollection = _firebase.collection('co');
  }

  Future<void> insFavorite(Map<String,dynamic> map) async{
    return _favoritesCollection!.doc().set(map);
  }

  Future<void> updFavorite(Map<String,dynamic> map, String id) async {
    return _favoritesCollection!.doc(id).update(map);
  }

  Future<void> delFavorite(String id) async {
    return _favoritesCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllFavorites() {
    return _favoritesCollection!.snapshots();
  }

}