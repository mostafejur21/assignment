import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'; // Ensure this is imported
import 'package:myapp/module/meme/data/model/memes_model.dart';

class MemeDetailsPage extends StatelessWidget {
  final Meme meme;
  const MemeDetailsPage({super.key, required this.meme});

  Future<File> _downloadImage(String url) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${meme.name}.jpg';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }

  Future<void> _saveCroppedImage(CroppedFile croppedFile) async {
    // Requesting storage permission
    if (await Permission.storage.request().isGranted || await Permission.manageExternalStorage.request().isGranted) {
      try {
        // Use the appropriate directory to save the file on external storage
        final directory = await getExternalStorageDirectory();
        final path = '${directory!.path}/${meme.name}_cropped.jpg';

        // Copy the cropped image to the external storage path
        final savedFile = await File(croppedFile.path).copy(path);

        Get.snackbar('Success', 'Cropped image saved successfully at $path');
      } catch (e) {
        Get.snackbar('Error', 'Failed to save cropped image: $e');
      }
    } else {
      Get.snackbar('Permission denied', 'Storage permission is required to save the cropped image.');
    }
  }

  Future<void> _cropImage(String url) async {
    try {
      // Download the image from the URL
      final imageFile = await _downloadImage(url);

      // Crop the image using ImageCropper
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: "Edit",
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: "Edit"),
        ],
      );

      if (croppedFile != null) {
        Get.snackbar('Success', 'Image cropped successfully!');
        // Save the cropped image to the device
        await _saveCroppedImage(croppedFile);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to crop image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meme.name),
        actions: [
          IconButton(
            onPressed: () async {
              await _cropImage(meme.url);
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Image.network(meme.url, height: 200),
          ),
          const SizedBox(height: 10),
          Text("Meme Title: ${meme.name}", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Meme Width: ${meme.width}", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Meme Height: ${meme.height}", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Meme Box Count: ${meme.boxCount}", style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          Text("Meme Captions: ${meme.captions}", style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
