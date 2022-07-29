import 'package:flutter/material.dart';

import 'package:test_app_im_good/entities/post_entity.dart';

import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/screens/post.dart';

class PersonPosts extends StatelessWidget {
  const PersonPosts({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadPostsAction(context: context));
    return StoreConnector<AppState, List<Post>>(
        builder: (BuildContext context, List<Post> posts) {
          return Center(
            child: posts.isEmpty
                ? const CircularProgressIndicator()
                : _body(context, posts),
          );
        },
        converter: (store) => store.state.posts);
  }

  Widget _body(BuildContext context, List<Post> posts) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostScreen(
                              store: store,
                              post: posts[index],
                            )));
              },
              child: ListTile(
                title: Text(
                  posts[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  posts[index].body,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ));
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: posts.length);
  }
}
