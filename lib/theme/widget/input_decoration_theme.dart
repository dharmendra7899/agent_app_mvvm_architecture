part of "../theme.dart";

final _inputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(color: appColors.borderColor),
  labelStyle: TextStyle(color: appColors.borderColor),
  floatingLabelStyle: TextStyle(color: appColors.primaryContainer),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.primaryContainer),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.primaryContainer),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: appColors.primaryContainer),
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

