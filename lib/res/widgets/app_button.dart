import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart' show appColors;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;

class AppButton extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final bool isLoading;
  final bool? isBorder;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? width;
  final double? fontSize;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.color,
    this.textColor,
    this.borderColor,
    this.isBorder,
    this.radius,
    this.height = 45,
    this.fontSize = 16,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? appColors.primary,
          borderRadius: BorderRadius.circular(radius ?? 8),
          boxShadow: [
            BoxShadow(
              color: appColors.appWhite,
              spreadRadius: 2,
              blurRadius: 15,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: isLoading == true ? null : onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(vertical: 2, horizontal: 8.0),
            ),
            elevation: WidgetStatePropertyAll(1),
            backgroundColor: WidgetStatePropertyAll(color ?? appColors.primary),
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 8),
                side: BorderSide(
                  color:
                      isBorder == true
                          ? borderColor ?? appColors.primary
                          : Colors.transparent,
                  width: 1.1,
                ),
              ),
            ),
          ),
          child: Center(
            child:
                isLoading == true
                    ? LoadingAnimationWidget.staggeredDotsWave(
                      color: appColors.appWhite,
                      size: 30,
                    )
                    : Text(
                      title,
                      style: context.textTheme.bodyLarge?.copyWith(
                        //  fontSize: fontSize,
                        color: textColor ?? appColors.appWhite,
                      ),
                    ),
          ),
        ),
      ),
    );
  }
}
