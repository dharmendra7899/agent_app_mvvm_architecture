import 'package:agent_app/data/network/network_api_services.dart'
    show NetworkApiServices;
import 'package:agent_app/res/widgets/app_urls.dart' show AppUrls;
import 'package:flutter/cupertino.dart' show debugPrint;

class AuthRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> apiLogin(dynamic data) async {
    debugPrint("URLS: ${AppUrls.loginEndPoint}");
    debugPrint("Response: $data");
    try {
      final response = await _network.getPostApiResponse(
        AppUrls.loginEndPoint,
        data,

      );
      debugPrint("Response652364723674: $response");
      return response.data;
    } catch (e) {
      debugPrint("Response catch: $e");
      rethrow; //Big Brain
    }
  }

  Future<dynamic> signUp(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(
        AppUrls.registerEndPoint,
        data,
      );
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}
