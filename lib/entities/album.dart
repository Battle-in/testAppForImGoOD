class Album{
  String id = 'none';
  String title = 'none';

  Album({required this.id, required this.title});

  Album.fromMap(Map map){
    id = map['id'].toString();
    title = map['title'];
  }
}