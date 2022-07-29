import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/album.dart';
import 'package:test_app_im_good/entities/comment.dart';
import 'package:test_app_im_good/entities/person.dart';
import 'package:test_app_im_good/entities/person_from_list.dart';
import 'package:test_app_im_good/entities/photo.dart';
import 'package:test_app_im_good/entities/post_entity.dart';

class SetBodyIndexAction{
  int newIndex;

  SetBodyIndexAction({required this.newIndex});
}

class SetUserIdAction{
  String newId;
  BuildContext context;

  SetUserIdAction({required this.newId, required this.context});
}

class NextUserIdAction{BuildContext context; NextUserIdAction(this.context);}
class BeforeUserIdAction{BuildContext context; BeforeUserIdAction(this.context);}

class LoadFriendsAction{
  //for Scaffold message about bad request
  BuildContext context;

  LoadFriendsAction({required this.context});
}

class SetFriendsAction{
  List<Friend> newFriends;

  SetFriendsAction({required this.newFriends});
}

class LoadPersonAction{
  //for Scaffold message about bad request
  BuildContext context;

  LoadPersonAction({required this.context});
}

class SetPersonAction{
  Person newPerson;

  SetPersonAction({required this.newPerson});
}

class LoadPostsAction{
  BuildContext context;

  LoadPostsAction({required this.context});
}

class SetPostsAction{
  List<Post> newPosts;

  SetPostsAction({required this.newPosts});
}

class LoadAlbumsAction{
  BuildContext context;

  LoadAlbumsAction(this.context);
}

class SetAlbumsAction{
  List<Album> newAlbumsAction;

  SetAlbumsAction({required this.newAlbumsAction});
}

class LoadCommentsAction{
  BuildContext context;
  String postId;

  LoadCommentsAction({required this.context, required this.postId});
}

class SetCommentsAction{
  List<Comment> newComments;

  SetCommentsAction({required this.newComments});
}

class SendCommentAction{
  Comment comment;
  String postId;

  SendCommentAction({required this.comment, required this.postId});
}

class LoadPhotoAction{
  BuildContext context;
  String albumId;

  LoadPhotoAction({required this.context, required this.albumId});
}

class SetPhotosActions{
  List<Photo> newPhotos;


  SetPhotosActions({required this.newPhotos});
}