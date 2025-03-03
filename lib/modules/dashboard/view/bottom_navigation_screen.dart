import 'package:agent_app/res/contents/texts.dart';
import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors.primary,
        foregroundColor: appColors.appWhite,
        centerTitle: true,
        title: Text(
          texts.home,
          style: context.textTheme.bodyLarge?.copyWith(
            color: appColors.appWhite,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
