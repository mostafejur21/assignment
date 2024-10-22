import 'dart:convert';

import 'package:get/get.dart';
import 'package:myapp/data/models/meme_list_model.dart';
import 'package:myapp/domain/repo/urls.dart';
import 'package:http/http.dart' as http;

class MemesController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Meme> _memes = [];
  List<Meme> _filteredMemes = [];
  List<Meme> get filteredMemes => _filteredMemes;
  List<Meme> get memes => _memes;

  @override
  void onInit() {
    super.onInit();
    fetchMemes();
  }

  Future<bool> fetchMemes() async {
    _isLoading = true;
    update();
    final response = await http.get(Uri.parse(Urls.GET_MEMES));
    if (response.statusCode == 200) {
      _isLoading = false;
      _memes = MemeResponse.fromJson(jsonDecode(response.body)).memes;
      _filteredMemes = _memes;
      update();
      return true;
    } else {
      _isLoading = false;
      update();
      return false;
    }
  }

  void searchMemes(String query) {
    if (query.isEmpty) {
      _filteredMemes = _memes;
    } else {
      _filteredMemes = _memes.where((meme) => meme.name.toLowerCase().contains(query.toLowerCase())).toList();
    }
    update();
  }
}
