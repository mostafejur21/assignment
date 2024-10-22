
import 'package:http/http.dart' as http;

class ApiCaller {
  Future fetchMemes({required String urls}) async {
    final response = await http.get(Uri.parse(urls));
    return response;
  }
}
