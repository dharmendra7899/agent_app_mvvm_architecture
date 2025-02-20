part of "../theme.dart";

final _inputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(color: appColors.borderColor),
  labelStyle: TextStyle(color: appColors.borderColor),
  floatingLabelStyle: TextStyle(color: appColors.appBlack),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.borderColor),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.appBlack),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.appBlack),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.error),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.error),
  ),
);

