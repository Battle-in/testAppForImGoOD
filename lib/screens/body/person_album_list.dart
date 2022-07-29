import 'package:flutter/material.dart';
import 'package:test_app_im_good/entities/album.dart';

import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/screens/album.dart';

class PersonAlbumList extends StatelessWidget {
  const PersonAlbumList({Key? key, required this.store}) : super(key: key);
  final Store<AppState> store;

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadAlbumsAction(context));
    return StoreConnector<AppState, List<Album>>(
        builder: (BuildContext context, List<Album> albums) {
          return Center(
            child: albums.isEmpty
                ? const CircularProgressIndicator()
                : _albumList(context, albums),
          );
        },
        converter: (store) => store.state.albums);
  }

  Widget _albumList(BuildContext context, List<Album> albums) {
    return ListView.separated(
        itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AlbumScreen(store: store, album: albums[index])));
            },
            child: ListTile(
              title: Text(albums[index].title),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: albums.length
    );
  }
}
