import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/comment.dart';
import 'package:test_app_im_good/redux/my_redux.dart';

class MakeCommentScreen extends StatelessWidget {
  const MakeCommentScreen({Key? key, required this.postId, required this.store}) : super(key: key);
  final String postId;
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {

    InputDecoration inputDecoration =
    const InputDecoration(border: OutlineInputBorder());

    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController commController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Оставить комментарий'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: ListView(
          children: [
            const SizedBox(height: 30,),
            const Text('Имя'),
            TextField(
                controller: nameController,
                decoration: inputDecoration
            ),
            const Divider(),
            const Text('email'),
            TextField(
              controller: emailController,
              decoration: inputDecoration,
            ),
            const Divider(),
            const Text('Комментарий'),
            TextField(
              controller: commController,
              decoration: inputDecoration,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
            )
          ],
        ),
      )
    );
  }
}
