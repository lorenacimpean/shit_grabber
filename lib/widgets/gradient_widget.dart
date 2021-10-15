import 'package:flutter/material.dart';
import 'package:shit_grabber/themes/app_colors.dart';

//TODO: transform this into gradient mask that takes any child and use it for icons

class GradientWidget extends StatelessWidget {
  final Widget child;

  const GradientWidget(this.child, {Key? key}) : super(key: key);

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
