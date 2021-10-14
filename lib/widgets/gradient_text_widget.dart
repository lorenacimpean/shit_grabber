import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';

//TODO: transform this into gradient mask that takes any child and use it for icons

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const GradientText(
    this.text, {
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
