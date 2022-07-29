import 'package:flutter/material.dart';

import 'package:test_app_im_good/entities/photo.dart';

class PhotoTile extends StatefulWidget {
  const PhotoTile({Key? key, required this.photo}) : super(key: key);
  final Photo photo;

  @override
  State<PhotoTile> createState() => _PhotoTileState();
}

class _PhotoTileState extends State<PhotoTile> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        setState((){
          open = !open;
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
        ),
        height: open ? 400 : 100,
        duration: const Duration(milliseconds: 500),
        child: open ?
        Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Flexible(child: Text(widget.photo.title),),
            ),
            Flexible(child: Image.network(widget.photo.imgUrl))
          ],
        )
       :
       Row(
        children: [
          Image.network(widget.photo.thumbnailUrl),
          const SizedBox(
            width: 10,
          ),
          Flexible(child: Text(widget.photo.title))
        ],
        )
      ),
    );
  }
}
