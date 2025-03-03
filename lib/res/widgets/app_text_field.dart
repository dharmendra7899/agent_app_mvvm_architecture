import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart' show appColors;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget? iconData;
  final Widget? leadingIcon;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? style;
  final bool readOnly;
  final bool showTitle;
  final bool mandatory;
  final Color? borderColor;
  final TextEditingController? controller;
  final Function()? onTap;
  final String? hintText;
  final void Function(String value)? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool obscureText;
  final FocusNode? focusNode;
  final int? maxLength;
  final int? maxLines;
  final String? counterText;
  final double? fontSize;
  final Widget? prefixIcon;
  final TextInputType? keyBoardType;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final EdgeInsetsGeometry contentPadding;
  final String obscuringCharacter;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.labelText,
    this.width = 1,
    this.iconData,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.showTitle = true,
    this.mandatory = false,
    this.height,
    this.hintText,
    this.onChanged,
    this.prefixIcon,
    this.leadingIcon,
    this.initialValue,
    this.style = const TextStyle(),
    this.validator,
    this.fontSize = 14,
    this.obscureText = false,
    this.focusNode,
    this.keyBoardType,
    this.enabled = true,
    this.textAlign = TextAlign.start,
    this.onFieldSubmitted,
    this.maxLines = 1,
    this.borderColor,
    this.labelStyle,
    this.maxLength,
    this.counterText,
    this.obscuringCharacter = '•',
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 12,
      horizontal: 15,
    ),
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (showTitle)
          Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Row(
              children: [
                Text(labelText ?? "", style: context.textTheme.bodyMedium),
                if (mandatory)
                  Text(
                    " *",
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: appColors.error,
                    ),
                  ),
              ],
            ),
          ),
        SizedBox(
          height: height,
          width: w * width!,
          child: TextFormField(
            inputFormatters: inputFormatters,
            onFieldSubmitted: onFieldSubmitted,
            textCapitalization: textCapitalization,
            enabled: enabled,
            focusNode: focusNode,
            initialValue: initialValue,
            validator: validator,
            onChanged: onChanged,
            readOnly: readOnly,
            obscureText: obscureText,
            onTap: onTap,
            textAlign: textAlign,
            keyboardType: keyBoardType,
            controller: controller,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            maxLength: maxLength,
            maxLines: maxLines,
            enableSuggestions: true,
            style: context.textTheme.titleSmall,
            obscuringCharacter: obscuringCharacter,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              counterText: '',
              prefix: leadingIcon,
              // filled: readOnly,
              hintText: hintText,
              suffixIcon: iconData,
              contentPadding: contentPadding,
              alignLabelWithHint: true,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: appColors.appBlack),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: appColors.appBlack),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: appColors.appBlack),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimText,
        selection: TextSelection(
          baseOffset: trimText.length,
          extentOffset: trimText.length,
        ),
      );
    }

    return newValue;
  }
}
