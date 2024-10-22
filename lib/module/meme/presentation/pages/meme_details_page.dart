import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/module/meme/presentation/services/image_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'; // Ensure this is imported
import 'package:myapp/module/meme/data/model/memes_model.dart';

class MemeDetailsPage extends StatelessWidget {
  final Meme meme;

  const MemeDetailsPage({super.key, required this.meme});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meme.name),
        actions: [
          IconButton(
            onPressed: () async {
              await ImageService().cropImage(meme.url, meme.name);
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: Image.network(
                    meme.url,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    side: BorderSide(
                      color: Colors.black,
                      width: 4.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "#${meme.id}",
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.amber,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          meme.name,
                          style: const TextStyle(
                            fontSize: 34.0,
                            color: Colors.black87,
                          ),
                        ),
                        Text("caption: ${meme.captions}",
                            style: const TextStyle(fontSize: 18)),
                        Text("box count: ${meme.boxCount}",
                            style: const TextStyle(fontSize: 18)),
                        Text("height: ${meme.height}",
                            style: const TextStyle(fontSize: 18)),
                        Text("width: ${meme.width}",
                            style: const TextStyle(fontSize: 18)),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
