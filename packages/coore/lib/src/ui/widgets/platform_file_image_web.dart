import 'package:flutter/material.dart';

Widget buildPlatformFileImage(
  String filePath, {
  Key? key,
  double scale = 1.0,
  double? width,
  double? height,
  Color? color,
  BoxFit? fit,
  AlignmentGeometry alignment = Alignment.center,
  BlendMode? colorBlendMode,
}) {
  return Image.network(
    filePath,
    key: key,
    scale: scale,
    width: width,
    height: height,
    color: color,
    fit: fit,
    alignment: alignment,
    colorBlendMode: colorBlendMode,
  );
}
