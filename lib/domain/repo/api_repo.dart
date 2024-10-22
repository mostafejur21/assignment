import 'package:myapp/module/meme/data/model/memes_model.dart';

abstract class ApiCaller {
  Future<MemeResponse> fetchMemes();
}
