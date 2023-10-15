class TaskModel {
  
  int? id_Tarea;
  String? nom_tarea;
  String? fec_expiracion;
  String? fec_recordatorio;
  String? desc_tarea;
  int? realizada;
  int? id_Profe;

  TaskModel({this.id_Tarea,this.nom_tarea,this.fec_expiracion,this.fec_recordatorio,this.desc_tarea,this.realizada,this.id_Profe});

  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      id_Tarea: map['id_Tarea'],
      nom_tarea: map['nom_tarea'],
      fec_expiracion: map['fec_expiracion'],
      fec_recordatorio: map['fec_recordatorio'],
      desc_tarea: map['desc_tarea'],
      realizada: map['realizada'],
      id_Profe: map['id_Profe']
    );
  }

}