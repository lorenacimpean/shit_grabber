import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/screens/settings/option_card.dart';
import 'package:shit_grabber/themes/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  List<String> titles = ['Sync to cloud', 'Drop a message'];

//todo: add sync files with firestore
  //check how to save images from cache
//todo: add firebase login
//todo: drop a message to creator
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: AppColors.gradientWithOpacity,
      ),
      child: ListView.builder(
        itemBuilder: (ctx, i) {
          return SettingsOption(
            onTap: () => print('test'),
            title: titles[i],
          );
        },
        itemCount: titles.length,
      ),
    );
  }
}
