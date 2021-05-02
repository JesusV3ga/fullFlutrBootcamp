class Task{
  String? name;
  int? seconds;

  Task({required this.name, required this.seconds});

  Task.fromMAPSQL(Map<String, dynamic> mapSQL){
    name = mapSQL["name"];
    seconds = mapSQL["seconds"];
  }

  Map<String, dynamic> toMapSQL(){
    return{
      "name": name,
      "seconds": seconds
    };
  }
}