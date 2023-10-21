class FavoriteModel {
  int? id_Pelicula;
  int? clave_P;
  String? titulo;
  String? sinopsis;
  double? valoracion;
  String? poster;

  FavoriteModel({
    this.id_Pelicula, 
    this.clave_P,
    this.titulo, 
    this.sinopsis, 
    this.valoracion,
    this.poster
  });

  factory FavoriteModel.fromMap(Map<String, dynamic> map){
    return FavoriteModel(
      id_Pelicula: map['id_Pelicula'],
      clave_P: map['clave_P'],
      titulo: map['titulo'],
      sinopsis: map['sinopsis'],
      valoracion: (map['valoracion'] is int)
        ? (map['valoracion'] as int).toDouble()
        : map['valoracion'],
      poster: map['poster'] 
    );
  }
}