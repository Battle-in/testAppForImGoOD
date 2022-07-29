import 'package:flutter/material.dart';

import 'package:test_app_im_good/entities/album.dart';
import 'package:test_app_im_good/entities/photo.dart';

import 'package:test_app_im_good/redux/my_redux.dart';
import 'package:test_app_im_good/screens/body/auxiliary_widgets/photo_tile.dart';



class AlbumScreen extends StatelessWidget {
  const AlbumScreen({Key? key, required this.store, required this.album}) : super(key: key);
  final Store<AppState> store;
  final Album album;

  @override
  Widget build(BuildContext context) {
    store.dispatch(LoadPhotoAction(context: context, albumId: album.id));store.dispatch(LoadPhotoAction(context: context, albumId: album.id));
    return Scaffold(
      appBar: AppBar(title: const Text('Они кликабельны'), centerTitle: true,),
      body: StoreConnector<AppState, List<Photo>>(
        builder: (BuildContext context, photos){
          if (photos.isEmpty){
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.separated(
                itemBuilder: (BuildContext context, index){
                  return PhotoTile(
                    photo: photos[index],
                  );
                },
                separatorBuilder: (BuildContext context, index) => const Divider(),
                itemCount: photos.length
            );
          }
        },
        converter: (store) => store.state.photos,
      ),
    );
  }
}
