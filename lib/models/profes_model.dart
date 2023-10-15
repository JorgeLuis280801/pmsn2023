class ProfesModel {
  
  int? id_Profe;
  String? nom_Profe;
  String? email;
  int? id_Carrera;

  ProfesModel({this.id_Profe,this.nom_Profe,this.email,this.id_Carrera});

  factory ProfesModel.fromMap(Map<String, dynamic> map){
    return ProfesModel(
      id_Profe: map['id_Profe'],
      nom_Profe: map['nom_Profe'],
      email: map['email'],
      id_Carrera: map['id_Carrera']
    );
  }

}