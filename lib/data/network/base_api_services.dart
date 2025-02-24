import 'package:agent_app/data/response/api_response.dart';

abstract class BaseApiServices {

  Future<ApiResponse<T>> getGetApiResponse<T>(String url);

  Future<ApiResponse<T>> getPostApiResponse<T>(String url, dynamic data);
}
