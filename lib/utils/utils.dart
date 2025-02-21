import 'dart:io';

import 'package:agent_app/res/contents/messages.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/res/widgets/custom_bottom_sheet.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:another_flushbar/flushbar.dart' show Flushbar, FlushbarPosition;
import 'package:another_flushbar/flushbar_route.dart' show showFlushbar;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
          style: context.textTheme.bodyMedium?.copyWith(color: Colors.white),
        ),
        duration: duration,
        backgroundColor: Colors.green,
      ),
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.all(12),
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

  bool shouldLogout = true;

  void setShouldLogout(bool val) {
    shouldLogout = val;
  }

  static String toTitleCase(String text) {
    if (text.isEmpty) return text;
    return text
        .split(' ')
        .map(
          (word) =>
              word.isNotEmpty
                  ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                  : '',
        )
        .join(' ');
  }

  DateTime selectedDateTime = DateTime.now();

  void pickDate({
    DateTime? firstDay,
    DateTime? lastDate,
    DateTime? dateForEditProfile,
    DateTime? selectedDateAndTime,
    required DateTime focusDate,
    required Function onDateSelected,
  }) {
    selectedDateTime = selectedDateAndTime ?? DateTime.now();
    CalendarDatePicker(
      initialDate: dateForEditProfile ?? firstDay ?? DateTime.now(),
      firstDate: firstDay ?? DateTime.now(),
      lastDate: lastDate ?? DateTime.now().add(const Duration(days: 18 * 365)),
      onDateChanged: (DateTime value) {
        selectedDateTime = value;
      },
    );
  }

  Future<File?> pickImage({
    required BuildContext context,
    required ImageSource img,
    bool allowMultiple = false,
    List<String> allowedExtensions = const ['pdf', 'jpg', 'png'],
  }) async {
    setShouldLogout(false);
    if (img == ImageSource.gallery) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: allowMultiple,
        allowedExtensions: allowedExtensions,
      );
      if (result != null) {
        File file = File(result.files.single.path!);
        int fileSizeInBytes = file.lengthSync();
        double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
        if (fileSizeInMB > 5 && context.mounted) {
          flushBarErrorMessage("File size must be less than 5MB", context);
        } else {
          Future.delayed(
            const Duration(seconds: 5),
          ).then((value) => setShouldLogout(true));
          return File(result.files.single.path!);
        }
      } else {
        Future.delayed(
          const Duration(seconds: 5),
        ).then((value) => setShouldLogout(true));
        return null;
      }
    }

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: img,
      imageQuality: 50,
      requestFullMetadata: true,
    );
    if (pickedFile != null) {
      Future.delayed(
        const Duration(seconds: 3),
      ).then((value) => setShouldLogout(true));
      return File(pickedFile.path);
    } else {
      if (context.mounted) {
        flushBarErrorMessage("Nothing is selected", context);
      }
    }
    Future.delayed(
      const Duration(seconds: 3),
    ).then((value) => setShouldLogout(true));
    return null;
  }

  static void chooseImages({
    required BuildContext context,
    required Function onCameraCLick,
    required Function onGalleryCLick,
  }) {
    return CustomBottomSheet().uploadStoreImage(
      context,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              onGalleryCLick();
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.photo, size: 30, color: appColors.primaryDark),
                const SizedBox(height: 6),
                Text('Gallery', style: context.textTheme.bodyLarge),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              onCameraCLick();
              Navigator.pop(context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 30, color: appColors.primaryDark),
                const SizedBox(height: 6),
                Text('Camera', style: context.textTheme.bodyLarge),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return Messages.PASSWORD_REQ;
    }
    final passwordPattern = RegExp(
      r'^(?=.*[A-Z])(?=.*[\W_])(?=.*\d)[A-Za-z\d\W_]{8,}$',
    );
    if (!passwordPattern.hasMatch(value)) {
      return Messages.SPECIAL_CHARACTER;
    }
    return null;
  }

  static String? validateEmail(String? value) {
    final emailRegExp = RegExp(
      r'^([a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$',
      caseSensitive: false,
    );

    if (value == null || value.isEmpty) {
      return Messages.EMAIL_REQ;
    } else if (!emailRegExp.hasMatch(value)) {
      return Messages.EMAIL_VALID;
    }
    return null;
  }

  static String? validateMobileNumber(String? value) {
    final mobileRegExp = RegExp(r'^[7-9]\d{9}$');
    if (value == null || value.isEmpty) {
      return Messages.PHONE_REQ;
    } else if (!mobileRegExp.hasMatch(value)) {
      return Messages.PHONE_VALID;
    }
    return null;
  }
}
