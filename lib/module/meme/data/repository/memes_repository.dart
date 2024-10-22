import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/domain/repo/urls.dart';
import 'package:myapp/module/meme/data/model/memes_model.dart';

class MemeRepository {
  Future<List<Meme>> fetchMemes() async {
    final response = await http.get(Uri.parse(Urls.GET_MEMES));
    if (response.statusCode == 200) {
      return MemeResponse.fromJson(jsonDecode(response.body)).memes;
    } else {
      throw Exception('Failed to load memes');
    }
  }
}
