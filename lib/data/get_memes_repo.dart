
import 'package:myapp/data/services/network_caller/network_response.dart';
import 'package:myapp/data/services/network_caller/request_method/get_request.dart';

class ApiCaller {
  Future fetchMemes({required String urls}) async {
    final NetworkResponse response = await GetRequest.execute(urls);
    return response;
  }
}
