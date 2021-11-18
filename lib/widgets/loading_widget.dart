import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: GradientMask(
          child: CupertinoActivityIndicator(),
        ),
      );
}
