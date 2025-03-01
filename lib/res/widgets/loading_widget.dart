import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const CustomLoading({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.6),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      appColors.appWhite,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Loading...", style: context.textTheme.titleMedium),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
