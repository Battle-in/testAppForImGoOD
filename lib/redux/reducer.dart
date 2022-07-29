import 'package:test_app_im_good/entities/album.dart';
import 'package:test_app_im_good/entities/comment.dart';
import 'package:test_app_im_good/entities/person.dart';
import 'package:test_app_im_good/entities/photo.dart';
import 'package:test_app_im_good/entities/post_entity.dart';
import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/entities/person_from_list.dart';


AppState reducer(AppState state, dynamic action) => AppState(
  bodyIndex: _bodyIndexReducer(state, action),
  currentUserId: _currentUserIdReducer(state, action),
  friends: _friendsReducer(state, action),
  person: _personReducer(state, action),
  posts: _postsReducer(state, action),
  albums: _albumsReducer(state, action),
  comments: _commentsReducer(state, action),
  photos: _photoReducer(state, action),
);

int _bodyIndexReducer(AppState state, dynamic action){
  if (action is SetBodyIndexAction){
    return action.newIndex;
  }

  if (action is SetUserIdAction){
    return 1;
  }

  return state.bodyIndex;
}

String _currentUserIdReducer(AppState state, dynamic action){
  if (action is SetUserIdAction){
    return action.newId;
  }

  if (action is NextUserIdAction){
    return (int.parse(state.currentUserId) + 1).toString();
  }

  if(action is BeforeUserIdAction){
    return (int.parse(state.currentUserId) - 1).toString();
  }

  return state.currentUserId;
}

List<Friend> _friendsReducer(AppState state, dynamic action){
  if(action is SetFriendsAction){
    return action.newFriends;
  }

  return state.friends;
}

Person _personReducer(AppState state, dynamic action){
  if (action is LoadPersonAction){
    return Person.getDefault();
  }

  if (action is SetPersonAction){
    return action.newPerson;
  }

  return state.person;
}

List<Post> _postsReducer(AppState state, dynamic action){
  if (action is SetPostsAction){
    return action.newPosts;
  }

  return state.posts;
}

List<Album> _albumsReducer(AppState state, dynamic action){
  if (action is SetAlbumsAction){
    return action.newAlbumsAction;
  }

  return state.albums;
}

List<Comment> _commentsReducer(AppState state, dynamic action){
  if (action is SetCommentsAction){
    return action.newComments;
  }

  return state.comments;
}

List<Photo> _photoReducer(AppState state, dynamic action){
  if (action is SetPhotosActions){
    return action.newPhotos;
  }

  return state.photos;
}