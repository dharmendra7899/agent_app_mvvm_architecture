import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

class DotIndicatorComponent extends StatelessWidget {
  const DotIndicatorComponent({super.key, this.isSelected = false});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8.0,
      height: 8.0,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: appColors.primaryContainer),
        color: isSelected ? appColors.primary : Colors.transparent,
      ),
    );
  }
}
