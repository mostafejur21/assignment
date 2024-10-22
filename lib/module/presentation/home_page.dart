import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/module/controller/memes_controller.dart';
import 'package:myapp/module/presentation/meme_details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Memes")),
        body: GetBuilder<MemesController>(builder: (controller) {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: controller.memes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.to(()=> MemeDetailsPage(meme: controller.memes[index],));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.network(
                      controller.memes[index].url,
                      height: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      controller.memes[index].name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              );
            },
          );
        }));
  }
}
