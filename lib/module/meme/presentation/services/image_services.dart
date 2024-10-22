import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  Future<File> downloadImage(String url, String fileName) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName.jpg';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return file;
    } else {
      throw Exception('Failed to download image');
    }
  }

  Future<void> saveCroppedImage(CroppedFile croppedFile, String fileName) async {
    // Requesting storage permission
    if (await Permission.storage.request().isGranted ||
        await Permission.manageExternalStorage.request().isGranted) {
      try {
        // Use the appropriate directory to save the file on external storage
        final directory = await getExternalStorageDirectory();
        final path = '${directory!.path}/${fileName}_cropped.jpg';

        // Copy the cropped image to the external storage path
        final savedFile = await File(croppedFile.path).copy(path);

        Get.snackbar('Success', 'Cropped image saved successfully at $path');
      } catch (e) {
        Get.snackbar('Error', 'Failed to save cropped image: $e');
      }
    } else {
      Get.snackbar('Permission denied',
          'Storage permission is required to save the cropped image.');
    }
  }

  Future<void> cropImage(String url, String fileName) async {
    try {
      // Download the image from the URL
      final imageFile = await downloadImage(url, fileName);

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
        await saveCroppedImage(croppedFile, fileName);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to crop image: $e');
    }
  }

}
