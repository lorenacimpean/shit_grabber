import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/widgets/gradient_widget.dart';

class SyncOptionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientMask(
        child: Container(
          width: double.infinity,
          height: double.infinity,
        ),
      ),
    );
  }
}
