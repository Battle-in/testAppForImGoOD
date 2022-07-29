class Comment{
  String id = 'null';
  String name = 'null';
  String email = 'null';
  String body = 'null';

  Comment({required this.id ,required this.name, required this.email, required this.body});

  Comment.fromMap(Map map){
    id = map['id'].toString();
    name = map['name'];
    email = map['email'];
    body = map['body'];
  }

  String toStrJs(){
    return 'comment: {'
        '"id": "$id",'
        '"name": "$name",'
        '"email": "$email",'
        '"body": "$body"'
        '}';
  }

  Map toMap(){
    return {
      "id": id,
      "name": name,
      "email": email,
      "body": body
    };
  }

  @override
  String toString() {
    return 'Comment{id: $id, name: $name, email: $email, body: $body}';
  }
}