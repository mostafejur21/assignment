import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:myapp/data/models/meme_list_model.dart';
import 'package:myapp/module/controller/image_edit_controller.dart';

class MemeDetailsPage extends StatelessWidget {
  final Meme meme;
  const MemeDetailsPage({super.key, required this.meme});

  @override
  Widget build(BuildContext context) {
    void cropedImage(String url) async {
      CroppedFile? croppedFile =
          await ImageCropper().cropImage(sourcePath: url, uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "Edit",
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: "Edit",
        )
      ]);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(meme.name),
        actions: [
          IconButton(
              onPressed: () async {
                cropedImage(meme.url);
              },
              icon: const Icon(Icons.image))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              meme.url,
              height: 200,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Meme Title: ${meme.name}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Meme Width: ${meme.width}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Meme Height: ${meme.height}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Meme Box Count: ${meme.boxCount}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Meme Captions: ${meme.captions}",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
