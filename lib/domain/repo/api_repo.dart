import 'package:myapp/data/models/meme_list_model.dart';

abstract class ApiCaller {
  Future<MemeResponse> fetchMemes();
}
