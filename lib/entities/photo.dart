class Photo{
  String title = 'null';
  String imgUrl = 'null';
  String thumbnailUrl = 'null';

  Photo({required this.title, required this.imgUrl, required this.thumbnailUrl});

  Photo.fromMap(Map map){
    title = map['title'];
    imgUrl = map['url'];
    thumbnailUrl = map['thumbnailUrl'];
  }
}