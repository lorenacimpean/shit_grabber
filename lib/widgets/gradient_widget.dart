import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class GradientMask extends StatelessWidget {
  final Widget child;

  const GradientMask({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => AppColors.gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: child,
    );
  }
}
