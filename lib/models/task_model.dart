class TaskModel {
  
  int? id_Tarea;
  String? nom_Tarea;
  String? desc_tarea;
  String? sta_Tarea;

  TaskModel({this.id_Tarea,this.nom_Tarea,this.desc_tarea,this.sta_Tarea});

  factory TaskModel.fromMap(Map<String, dynamic> map){
    return TaskModel(
      id_Tarea: map['id_Tarea'],
      nom_Tarea: map['nom_Tarea'],
      desc_tarea: map['desc_Tarea'],
      sta_Tarea: map['sta_Tarea']
    );
  }

}