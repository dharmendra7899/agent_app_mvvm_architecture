import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:agent_app/data/app_exceptions.dart' show BadRequestException, InternetException;
import 'package:agent_app/data/network/base_api_services.dart' show BaseApiServices;


class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      final response = await http
          .post(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responseJson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responseJson;
  }

  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      case 400:
        throw BadRequestException("Invalid HTTP method");
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}
