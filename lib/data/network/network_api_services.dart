import 'dart:convert';
import 'dart:io';
import 'package:agent_app/data/response/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:agent_app/data/app_exceptions.dart';
import 'package:agent_app/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  Future<ApiResponse<T>> _handleResponse<T>(http.Response response) async {
    try {
      switch (response.statusCode) {
        case 200:
          dynamic jsonResponse = jsonDecode(response.body);
          return ApiResponse.completed(jsonResponse);
        case 400:
          throw BadRequestException("Invalid HTTP method or request format.");
        case 401:
          throw UnauthorizedException("Unauthorized access. Please log in.");
        case 408:
          throw ServerTimeOut("Server took too long to respond.");
        case 500:
          throw AppExceptions("Internal server error. Please try again later.");
        default:
          throw AppExceptions("Error ${response.statusCode}: ${response.reasonPhrase}");
      }
    } catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<T>> getGetApiResponse<T>(String url) async {
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      return await _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse.error("No internet connection available.");
    } on Exception catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  @override
  Future<ApiResponse<T>> getPostApiResponse<T>(String url, dynamic data) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      return await _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse.error("No internet connection available.");
    } on Exception catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<T>> getPutApiResponse<T>(String url, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));
      return await _handleResponse<T>(response);
    } on SocketException {
      return ApiResponse.error("No internet connection available.");
    } on Exception catch (e) {
      return ApiResponse.error(e.toString());
    }
  }

  Future<ApiResponse<T>> uploadFile<T>(String url, File file, String fieldName) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));
      var response = await request.send();
      var responseBody = await http.Response.fromStream(response);
      return await _handleResponse<T>(responseBody);
    } on SocketException {
      return ApiResponse.error("No internet connection available.");
    } on Exception catch (e) {
      return ApiResponse.error(e.toString());
    }
  }
}
