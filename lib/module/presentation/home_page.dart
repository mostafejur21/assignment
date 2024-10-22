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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                Get.find<MemesController>().searchMemes(value);
              },
              decoration: const InputDecoration(
                hintText: "Search Memes",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          GetBuilder<MemesController>(
            builder: (controller) {
              if (controller.isLoading) {
                // Show a loading indicator while the data is being fetched
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.filteredMemes.isEmpty) {
                // Show a message if no memes are available
                return const Center(
                  child: Text("No memes available"),
                );
              }

              return Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: controller.filteredMemes.length,
                  itemBuilder: (context, index) {
                    final meme = controller.filteredMemes[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => MemeDetailsPage(meme: meme));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            meme.url,
                            height: 200,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            meme.name,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
