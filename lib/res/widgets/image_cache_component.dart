import 'package:agent_app/theme/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'package:flutter/material.dart';

class ImageCacheComponent extends StatelessWidget {
  const ImageCacheComponent({
    super.key,
    required this.imageUrl,
    this.width = double.maxFinite,
    this.fit = BoxFit.fitWidth,
    this.height = 300,
  });

  final String imageUrl;
  final double height;
  final double width;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: fit,
            ),
          ),
        ),
        imageUrl: imageUrl,
        errorWidget: (context, _, __) => const _Placeholder(),
        placeholder: (context, _) => const _Placeholder(),
        fit: fit,
        width: width,
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [appColors.secondary, appColors.borderColor],
        ),
      ),
    );
  }
}
