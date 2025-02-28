import 'package:agent_app/res/widgets/context_extension.dart';
import 'package:agent_app/res/widgets/image_cache_component.dart';
import 'package:agent_app/theme/colors.dart';
import 'package:flutter/material.dart';

class CarouselCardComponent extends ImageCacheComponent {
  const CarouselCardComponent({
    super.key,
    required super.imageUrl,
    super.height,
    super.width = 300,
    this.titleText,
  });

  final String? titleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: appColors.borderColor),
        color: appColors.borderColor,
      ),
      padding: const EdgeInsets.fromLTRB(22, 24, 0, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleText ?? "", style: context.textTheme.bodyMedium),
          const SizedBox(height: 20),
          ImageCacheComponent(imageUrl: imageUrl, height: height, width: width),
        ],
      ),
    );
  }
}
