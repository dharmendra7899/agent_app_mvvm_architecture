import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

typedef CardPressed = void Function();

class ListComponent extends StatelessWidget {
  const ListComponent({
    super.key,
    required this.onPressed,
    this.text = 'Some text',
  });

  final String text;
  final CardPressed onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: appColors.borderColor),
        ),
        child: Row(
          children: [
            Text(text, style: Theme.of(context).textTheme.bodyMedium),
            const Spacer(),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
