import 'dart:convert';

import 'package:get/get.dart';
import 'package:myapp/data/get_memes_repo.dart';
import 'package:myapp/data/models/meme_list_model.dart';
import 'package:myapp/domain/repo/urls.dart';

class MemesController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Meme> _memes = [];
  List<Meme> get memes => _memes;

  @override
  void onInit() {
    super.onInit();
    fetchMemes();
  }

  void fetchMemes() async {
    _isLoading = true;
    update();
    ApiCaller().fetchMemes(urls: Urls.GET_MEMES).then((e) async {
      if (e['status'] == 200) {
        final data = jsonDecode(e['data']);
        MemeResponse memeResponse = MemeResponse.fromJson(data);
        _memes.assignAll(memeResponse.memes);
        _isLoading = false;
        update();
      } else {
        _isLoading = false;
        update();
      }
    });
  }
}
