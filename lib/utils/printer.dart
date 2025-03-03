import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Printer {
  static void printRequest(http.Request request) async {
    if (kDebugMode) {
      print("╔═╣ Request ║ ${request.method.toUpperCase()} ");
      print("║");
      print("║  ${request.url}");
      print("║");
      print(
        "║═╣ Headers ║══════════════════════════════════════════════════════════════════════════════",
      );
      prettyPrint(jsonEncode(request.headers));
      print(
        "║═╣ Body ║═════════════════════════════════════════════════════════════════════════════════",
      );

      if (request.body.isNotEmpty) {
        prettyPrint(request.body);
      } else {
        print("║  (Empty Body)");
      }

      print(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      );
    }
  }

  static void printResponse(http.Response response) {
    if (kDebugMode) {
      print("╔═╣ Response ║ Status: ${response.statusCode}");
      print("║");
      print("║  ${response.request?.url}");
      print("║");
      print(
        "║═╣ Body ║═════════════════════════════════════════════════════════════════════════════════",
      );

      if (response.body.isNotEmpty) {
        prettyPrint(response.body);
      } else {
        print("║  (Empty Body)");
      }

      print(
        '╚══════════════════════════════════════════════════════════════════════════════════════════╝',
      );
    }
  }

  static void prettyPrint(String jsonString) {
    try {
      final jsonData = jsonDecode(jsonString);
      const encoder = JsonEncoder.withIndent('  ');
      final prettyString = encoder.convert(jsonData);

      if (prettyString.length > 1000) {
        int startIndex = 0;
        while (startIndex < prettyString.length) {
          int endIndex =
              (startIndex + 1000 <= prettyString.length - 1)
                  ? startIndex + 1000
                  : prettyString.length - 1;

          while (endIndex > startIndex && prettyString[endIndex] != '\n') {
            endIndex--;
          }
          endIndex =
              endIndex < prettyString.length
                  ? endIndex
                  : prettyString.length - 1;

          if (kDebugMode) {
            print(prettyString.substring(startIndex, endIndex));
          }
          startIndex = endIndex + 1;
        }
      } else {
        if (kDebugMode) {
          print(prettyString);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("║ Invalid JSON, raw output:");
        print(jsonString);
      }
    }
  }
}
