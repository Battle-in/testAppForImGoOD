class Friend{
  String id = '1';
  String userName = 'null';
  String name = 'null';

  Friend({required this.id, required this.userName, required this.name});

  Friend.fromMap(Map map){
    id = map['id'].toString();
    name = map['name'] ?? 'undefined';
    userName = map['username'] ?? 'undefined' ;
  }
}