import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/core/application/bindings.dart';
import 'package:myapp/module/meme/presentation/pages/meme_home_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: SBindings(),
      title: 'Meme App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}