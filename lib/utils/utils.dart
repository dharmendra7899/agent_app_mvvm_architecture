
import 'package:another_flushbar/flushbar.dart' show Flushbar, FlushbarPosition;
import 'package:another_flushbar/flushbar_route.dart' show showFlushbar;
import 'package:flutter/material.dart';

class Utils {
  static void changeNodeFocus(
    BuildContext context, {
    FocusNode? current,
    FocusNode? next,
  }) {
    current!.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static void toastMessage(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(milliseconds: 3000),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        duration: duration,
        backgroundColor:  Colors.green,
      ),
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: const Duration(seconds: 3),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(Icons.error, size: 28, color: Colors.white),
      )..show(context),
    );
  }


  // average for ratings
  static double averageRatings(List<int> ratings) {
    double avg = 0;
    for (int i = 0; i < ratings.length; i++) {
      avg += ratings[i];
    }
    avg /= ratings.length;

    return avg;
  }
}
