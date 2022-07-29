import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/album.dart';
import 'package:test_app_im_good/entities/comment.dart';
import 'package:test_app_im_good/entities/person_from_list.dart';
import 'package:test_app_im_good/entities/person.dart';
import 'package:test_app_im_good/entities/photo.dart';
import 'package:test_app_im_good/entities/post_entity.dart';
import 'package:test_app_im_good/redux/my_redux.dart';

import 'package:shared_preferences/shared_preferences.dart';

void loaderMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher nextDispatcher) {
  if (action is LoadFriendsAction) {
    _loadFriends(store, action);
  }

  if (action is LoadPersonAction ||
      action is NextUserIdAction ||
      action is BeforeUserIdAction ||
      action is SetUserIdAction) {
    _loadPerson(store, action);
  }

  if (action is LoadPostsAction) {
    _loadPosts(store, action);
  }

  if (action is LoadAlbumsAction) {
    _loadAlbums(store, action);
  }

  if (action is LoadCommentsAction) {
    _loadComments(store, action);
  }

  if (action is SendCommentAction) {
    _sendComment(store, action);
  }

  if (action is LoadPhotoAction){
    _loadPhoto(store, action);
  }

  nextDispatcher(action);
}

void _netError(BuildContext context, Function funk) {
  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Ошибка соединения, повторная попытка через 10 секунд')));
  Future.delayed(const Duration(seconds: 10), () {
    funk();
  });
}

Future<void> _loadFriends(
    Store<AppState> store, LoadFriendsAction action) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic data;
  List<Friend> friends = <Friend>[];

  try {
    if (prefs.get('friends') == null) {
      Response response =
          await Dio().get('https://jsonplaceholder.typicode.com/users');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = response.data;

        String toJs = '{"friends": [';

        for (int i = 0; i < data.length; i++) {
          toJs += '{'
              '"id" : "${data[i]['id']}",'
              '"name" : "${data[i]['name']}",'
              '"username" : "${data[i]['username']}",'
              '"email" : "${data[i]['email']}",'
              '"phone" : "${data[i]['phone']}",'
              '"website": "${data[i]['website']}",'
              '"company": '
              '{"name": "${data[i]['company']['name']}", '
              '"bg": "${data[i]['company']['bg']}", '
              '"catchPhrase": "${data[i]['company']['catchPhrase']}"}'
              '}';
          if (i < (data.length - 1)) {
            toJs += ',';
          }

          friends.add(Friend.fromMap(data[i]));
        }

        toJs += ']}';
        prefs.setString('friends', toJs);
      } else {
        _netError(action.context, () => _loadFriends(store, action));
      }
    } else {
      String strFriends = prefs.getString('friends') as String;
      data = jsonDecode(strFriends)['friends'];

      for (dynamic i in data) {
        friends.add(Friend.fromMap(i));
      }
    }

    store.dispatch(SetFriendsAction(newFriends: friends));
  } catch (e) {
    _netError(action.context, () => _loadFriends(store, action));
  }
}

Future<void> _loadPerson(Store<AppState> store, dynamic action) async {
  final prefs = await SharedPreferences.getInstance();
  Person person = await Person.getDefault();
  dynamic data;

  try {
    if (prefs.get('person${store.state.currentUserId}') == null) {
      Response response = await Dio().get(
          'http://jsonplaceholder.typicode.com/users/${store.state.currentUserId.toString()}');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = await response.data;
        prefs.setString(
            'person${store.state.currentUserId}', response.toString());
      } else {
        _netError(action.context, () => _loadPerson(store, action));
      }
    } else {
      String strPerson =
          prefs.getString('person${store.state.currentUserId}') as String;
      data = jsonDecode(strPerson);
    }

    person = Person.fromMap(data);

    store.dispatch(SetPersonAction(newPerson: person));
  } catch (e) {
    _netError(action.context, () => _loadPerson(store, action));
  }
}

Future<void> _loadPosts(Store<AppState> store, LoadPostsAction action) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic data;
  List<Post> newPosts = <Post>[];

  try {
    if (prefs.get('posts${store.state.currentUserId}') == null) {
      Response response = await Dio().get(
          'https://jsonplaceholder.typicode.com/posts?userId=${store.state.currentUserId}');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = response.data;

        String toJs = '{"posts": [';

        for (int i = 0; i < data.length; i++) {
          toJs += '{'
              '"id": "${data[i]['id']}",'
              '"title": "${data[i]['title']}",'
              '"body": "${data[i]['body'].replaceAll('\n', '[enter]')}"' //.replaceAll('\n', '[enter]')
              '}';
          if (i < (data.length - 1)) {
            toJs += ',';
          }
          newPosts.add(Post.fromMap(data[i]));
        }

        toJs += ']}';
        prefs.setString('posts${store.state.currentUserId}', toJs);
      } else {
        _netError(action.context, () => _loadPosts(store, action));
      }
    } else {
      String strFriends =
          prefs.getString('posts${store.state.currentUserId}') as String;
      data = jsonDecode(strFriends)['posts'];

      for (dynamic i in data) {
        newPosts.add(Post.fromMap(i));
      }
    }

    store.dispatch(SetPostsAction(newPosts: newPosts));
  } catch (e) {
    _netError(action.context, () => _loadPosts(store, action));
  }
}

Future<void> _loadAlbums(Store<AppState> store, LoadAlbumsAction action) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic data;
  List<Album> newAlbums = <Album>[];

  try {
    if (prefs.get('albums${store.state.currentUserId}') == null) {
      Response response = await Dio().get(
          'https://jsonplaceholder.typicode.com/albums?userId=${store.state.currentUserId}');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = response.data;

        String toJs = '{"albums": [';

        for (int i = 0; i < data.length; i++) {
          toJs += '{'
              '"id": "${data[i]['id']}",'
              '"title": "${data[i]['title']}"'
              '}';
          if (i < (data.length - 1)) {
            toJs += ',';
          }
          newAlbums.add(Album.fromMap(data[i]));
        }

        toJs += ']}';
        prefs.setString('albums${store.state.currentUserId}', toJs);
      } else {
        _netError(action.context, () => _loadAlbums(store, action));
      }
    } else {
      String strFriends =
          prefs.getString('albums${store.state.currentUserId}') as String;
      data = jsonDecode(strFriends)['albums'];

      for (dynamic i in data) {
        newAlbums.add(Album.fromMap(i));
      }
    }

    store.dispatch(SetAlbumsAction(newAlbumsAction: newAlbums));
  } catch (e) {
    _netError(action.context, () => _loadAlbums(store, action));
  }
}

Future<void> _loadComments(
    Store<AppState> store, LoadCommentsAction action) async {
  final prefs = await SharedPreferences.getInstance();
  dynamic data;
  List<Comment> newComments = <Comment>[];

  try {
    if (prefs.get('comments${store.state.currentUserId}[${action.postId}]') ==
        null) {
      Response response = await Dio().get(
          'https://jsonplaceholder.typicode.com/comments?postId=${action.postId}');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = response.data;

        String toJs = '{"comments": [';

        for (int i = 0; i < data.length; i++) {
          toJs += '{'
              '"id": "${data[i]['id']}",'
              '"name": "${data[i]['name']}",'
              '"email": "${data[i]['email']}",'
              '"body": "${(data[i]['body'].replaceAll('\n', '[enter]'))}"'
              '}';
          if (i < (data.length - 1)) {
            toJs += ',';
          }
          newComments.add(Comment.fromMap(data[i]));
        }
        toJs += ']}';
        prefs.setString(
            'comments${store.state.currentUserId}[${action.postId}]', toJs);
      } else {
        _netError(action.context, () => _loadComments(store, action));
      }
    } else {
      String strComments = prefs.getString(
          'comments${store.state.currentUserId}[${action.postId}]') as String;
      data = jsonDecode(strComments)['comments'];

      for (dynamic i in data) {
        newComments.add(Comment.fromMap(i));
      }
    }
    store.dispatch(SetCommentsAction(newComments: newComments));
  } catch (e) {
    _netError(action.context, () => _loadComments(store, action));
  }
}

Future<void> _sendComment(
    Store<AppState> store, SendCommentAction action) async {
  int fakeId = int.parse(store.state.comments.last.id) + 1;
  action.comment.id = fakeId.toString();

  try {
    Dio().post('https://jsonplaceholder.typicode.com/comments',
        data: action.comment.toMap());
  } catch (e) {
    //_netError(context, () => _sendComment(context, action));
  }
  final prefs = await SharedPreferences.getInstance();

  String getJs =
      prefs.getString('comments${store.state.currentUserId}[${action.postId}]')
          as String;

  getJs.replaceAll(']}', '');

  getJs += ',${action.comment.toStrJs()}]}';

  prefs.setString(
      'comments${store.state.currentUserId}[${action.postId}]', getJs);

  List<Comment> newComments = store.state.comments..add(action.comment);

  store.dispatch(SetCommentsAction(newComments: newComments));
}

Future<void> _loadPhoto(Store<AppState> store, LoadPhotoAction action) async{
  final prefs = await SharedPreferences.getInstance();
  dynamic data;
  List<Photo> newPhotos = <Photo>[];
  try {
    if (prefs.get('photos${store.state.currentUserId}[${action.albumId}]') ==
        null) {
      Response response = await Dio().get(
          'https://jsonplaceholder.typicode.com/photos?albumId=${action.albumId}');
      if ((response.statusCode ?? 0) >= 200 &&
          (response.statusCode ?? 0) < 300) {
        data = response.data;
        String toJs = '{"photos": [';

        for (int i = 0; i < data.length; i++) {
          toJs += '{'
              '"title": "${data[i]['title']}"'
              '"imgUrl": "${data[i]['url']}",'
              '"thumbnailUrl": ${data[i]['thumbnailUrl']}'
              '}';
          if (i < (data.length - 1)) {
            toJs += ',';
          }
          newPhotos.add(Photo.fromMap(data[i]));
        }
        toJs += ']}';
        prefs.setString(
            'photos${store.state.currentUserId}[${action.albumId}]', toJs);
      } else {
        _netError(action.context, () => _loadPhoto(store, action));
      }
    } else {
      String strComments = prefs.getString(
          'photos${store.state.currentUserId}[${action.albumId}]') as String;
      data = jsonDecode(strComments)['photos'];

      for (dynamic i in data) {
        newPhotos.add(Photo.fromMap(i));
      }
    }
    store.dispatch(SetPhotosActions(newPhotos: newPhotos));
  } catch (e) {
    _netError(action.context, () => _loadPhoto(store, action));
  }
}
