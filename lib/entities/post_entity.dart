class Post{
  String id = 'none';
  String title = 'none';
  String body = 'none';

  Post({required this.id, required this.title, required this.body});

  Post.fromMap(Map map){
    id = map['id'].toString();
    title = map['title'];
    body = map['body'];
  }

  @override
  String toString() {
    return 'Post{id: $id, title: $title, body: $body}';
  }
}