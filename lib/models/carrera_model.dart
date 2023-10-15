class CarreraModel {
  
  int? id_Carrera;
  String? nom_Carrera;

  CarreraModel({this.id_Carrera,this.nom_Carrera});

  factory CarreraModel.fromMap(Map<String, dynamic> map){
    return CarreraModel(
      id_Carrera: map['id_Carrera'],
      nom_Carrera: map['nom_Carrera']
    );
  }

}