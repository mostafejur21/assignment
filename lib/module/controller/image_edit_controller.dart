import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class ImageEditController extends GetxController {
  var croppedFile = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  // // Function to pick an image from gallery
  // Future<void> pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     cropImage(File(pickedFile.path));
  //   }
  // }

  // Function to crop or rotate the image
  // Future<void> cropImage(File imageFile) async {
  //   CroppedFile? croppedImage = await ImageCropper().cropImage(
  //     sourcePath: imageFile.path,
  //   );

  //   if (croppedImage != null) {
  //     croppedFile.value = File(croppedImage.path);
  //   }
  // }

  // Future<File> downloadImage(String url) async {
  //   final response = await http.get(Uri.parse(url));

  //   final file = File('/temp_image.jpg');
  //   file.writeAsBytesSync(response.bodyBytes);
  //   return file;
  // }

  // Function to save the image locally
  Future<void> saveImage() async {}


}
