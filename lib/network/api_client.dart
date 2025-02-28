import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'response_model.dart';

abstract interface class ApiClient {
  Future<ResponseModel?> postApi({
    required String url,
    required Map<String, dynamic> body,
  });

  Future<ResponseModel?> putApi({
    required String url,
    required Map<String, dynamic> body,
  });

  Future<ResponseModel?> patchApi({
    required String url,
    required Map<String, dynamic> body,
  });

  Future<ResponseModel?> deleteApi({
    required String url,
    required Map<String, dynamic> body,
  });

  Future<ResponseModel?> getApi({
    required String url,
  });

  Future<ResponseModel?> multipartApi({
    required String url,
    required File file,
    required Map<String, String> body,
    required String imageKey,
    MediaType? mediaType,
  });
}

abstract class SocketService {
  Future<void> connect();
  void emit(String event, dynamic data);
  void on(String event, Function(dynamic) callback);
  void off(String event);
  Stream<dynamic> get stream;
}
