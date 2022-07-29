import 'package:flutter/material.dart';

import 'package:test_app_im_good/redux/my_redux.dart';
import 'body/all_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    List<Widget> body = _body(context);
    return StoreConnector<AppState, int>(
      builder: (BuildContext context, bodyIndex) {
        return Scaffold(
          body: body[bodyIndex],
          bottomNavigationBar: _bottom(context),
        );
      },
      converter: (store) => store.state.bodyIndex,
    );
  }

  List<Widget> _body(BuildContext context){
    return [
      PersonsList(store: store),
      PersonPage(store: store),
      PersonPosts(store: store),
      PersonAlbumList(store: store)
    ];
  }

  Widget _bottom(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        currentIndex: store.state.bodyIndex,
        onTap: (newIndex) => store.dispatch(SetBodyIndexAction(newIndex: newIndex)),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Пользователи'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Пользователь'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Посты'),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Альбомы'),
        ]);
  }
}
