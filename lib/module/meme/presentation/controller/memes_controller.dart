import 'package:get/get.dart';
import 'package:myapp/module/meme/data/model/memes_model.dart';
import 'package:myapp/module/meme/data/repository/memes_repository.dart';

class MemesController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  List<Meme> _memes = [];
  List<Meme> _filteredMemes = [];
  List<Meme> get filteredMemes => _filteredMemes;
  List<Meme> get memes => _memes;

  final MemeRepository _memeRepository = MemeRepository();

  @override
  void onInit() {
    super.onInit();
    fetchMemes();
  }

  Future<void> fetchMemes() async {
    _isLoading = true;
    update();
    try {
      _memes = await _memeRepository.fetchMemes();
      _filteredMemes = _memes;
    } catch (e) {
      // Handle error (showing a message or logging it)
    } finally {
      _isLoading = false;
      update();
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
