import 'dart:io';

import 'package:flutter/material.dart';

class PostImagePreviewer extends StatelessWidget {
  File postImage;
  final VoidCallback onRemove;

  PostImagePreviewer(this.postImage, {this.onRemove});

  @override
  Widget build(BuildContext context) {
    double avatarBorderRadius = 10.0;

    var imagePreview = Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(avatarBorderRadius)),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(avatarBorderRadius),
            child: Container(
              child: null,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: FileImage(postImage), fit: BoxFit.cover)),
            )),
      ),
    );

    if (onRemove == null) return imagePreview;

    return Stack(
      children: <Widget>[
        imagePreview,
        Positioned(
          right: 10.0,
          top: 10.0,
          child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: FloatingActionButton(
              onPressed: onRemove,
              backgroundColor: Colors.black87,
              child: Icon(Icons.clear, color: Colors.white, size: 20.0,),
            ),
          )
        ),
      ],
    );
  }
}
