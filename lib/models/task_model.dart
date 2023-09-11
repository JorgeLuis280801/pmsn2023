class TaskModel {
  
  int? id_Tarea;
  String? nom_Tarea;
  String? desc_tarea;
  bool? sta_Tarea;

  TaskModel({this.id_Tarea,this.nom_Tarea,this.desc_tarea,this.sta_Tarea});

  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      id_Tarea: map['id_Tarea'],
      nom_Tarea: map['nom_tarea'],
      desc_tarea: map['desc_tarea'],
      sta_Tarea: map['sta_Tarea']
    );
  }

}