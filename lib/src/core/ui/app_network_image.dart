import 'package:coore/lib.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.isAuthorized = false,
    this.fallback,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final bool isAuthorized;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return CoreImage.network(
      imageUrl ?? '',
      width: width,
      height: height,
      fit: fit,
      errorBuilder: fallback == null
          ? null
          : (context, url, error) => fallback!,
    );
  }
}
