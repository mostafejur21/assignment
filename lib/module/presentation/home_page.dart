import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/module/controller/memes_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Memes")),
        body: GetBuilder<MemesController>(builder: (controller) {
          return Column(
            children: [
              ListView.builder(
                itemCount: controller.memes.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(controller.memes[index].name));
                },
              ),
            ],
          );
        }));
  }
}
