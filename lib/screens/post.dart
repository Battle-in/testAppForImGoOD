import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/comment.dart';

import 'package:test_app_im_good/entities/post_entity.dart';
import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/screens/make_comment_screen.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key, required this.post, required this.store})
      : super(key: key);
  final Store<AppState> store;
  final Post post;

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadCommentsAction(context: context, postId: post.id));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Пост'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_rounded),
        ),
        body: Padding(
            padding: const EdgeInsets.all(10),
            child: StoreConnector<AppState, List<Comment>>(
              builder: (BuildContext context, comments) {
                if (comments.isEmpty) {
                  return ListView(
                    children: [
                      Text(
                        post.title,
                        style: const TextStyle(
                            fontSize: 36, fontWeight: FontWeight.bold),
                      ),
                      const Divider(),
                      Text(
                        post.body.replaceAll('[enter]', '\n'),
                        style: const TextStyle(fontSize: 24),
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 15,
                      ),
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ],
                  );
                } else {
                  List<Widget> widgets = [
                    Text(
                      post.title,
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Text(
                      post.body.replaceAll('[enter]', '\n'),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const Divider(),
                  ];

                  for (Comment comment in comments) {
                    widgets.add(ListTile(
                      title: Text(comment.name),
                      subtitle: Text(comment.body.replaceAll('[enter]', '\n')),
                      trailing: Text(comment.email),
                    ));
                    widgets.add(const Divider());
                  }

                  widgets.add(const SizedBox(
                    height: 30,
                  ));
                  widgets.add(Center(
                    child: TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MakeCommentScreen(store: store, postId: post.id,)));
                      },
                      child: const Text('Добавить комментарий'),
                    ),
                  ));
                  widgets.add(const SizedBox(
                    height: 30,
                  ));

                  return ListView(
                    children: widgets,
                  );
                }
              },
              converter: (store) => store.state.comments,
            )));
  }

  Future<void> _addComment(BuildContext context, String postId) async {
    InputDecoration inputDecoration =
        const InputDecoration(border: OutlineInputBorder());

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController commController = TextEditingController();

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Ваш комментарий'),
            content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Имя'),
                  TextField(
                    controller: nameController,
                    decoration: inputDecoration
                  ),
                  const Text('email'),
                  TextField(
                    controller: emailController,
                    decoration: inputDecoration,
                  ),
                  const Text('Комментарий'),
                  TextField(
                    controller: commController,
                    decoration: inputDecoration,
                  )
                ],
              ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Отменить')),
              TextButton(
                  child: const Text('Отправить'),
                  onPressed: () {
                    store.dispatch(SendCommentAction(
                        comment: Comment(
                            id: '0',
                            name: nameController.text,
                            email: emailController.text,
                            body: commController.text),
                        postId: postId));
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }
}
