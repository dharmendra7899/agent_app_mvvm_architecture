import 'package:agent_app/data/network/network_api_services.dart'
    show NetworkApiServices;
import 'package:agent_app/res/widgets/app_urls.dart' show AppUrls;

class AuthRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> apiLogin(dynamic data) async {
    try {
      final response = await _network.getPostApiResponse(
        AppUrls.loginEndPoint,
        data,
      );
      return response;
    } catch (e) {
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
