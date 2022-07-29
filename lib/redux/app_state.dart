import 'package:test_app_im_good/entities/album.dart';
import 'package:test_app_im_good/entities/comment.dart';
import 'package:test_app_im_good/entities/person_from_list.dart';
import 'package:test_app_im_good/entities/person.dart';
import 'package:test_app_im_good/entities/photo.dart';
import 'package:test_app_im_good/entities/post_entity.dart';

class AppState {
  int bodyIndex = 0;
  String currentUserId = '1';
  List<Friend> friends = [];
  Person person = Person.getDefault();
  List<Post> posts = [];
  List<Album> albums = [];
  List<Comment> comments = [];
  List<Photo> photos = [];

  AppState(
      {required this.bodyIndex,
      required this.currentUserId,
      required this.friends,
      required this.person,
      required this.posts,
      required this.albums,
      required this.comments,
      required this.photos,
      });

  AppState.initState();
}
