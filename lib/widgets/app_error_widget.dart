import 'package:flutter/cupertino.dart';
import 'package:shit_grabber/themes/app_strings.dart';

class AppErrorWidget extends StatelessWidget {
  final String? errorMessage;

  const AppErrorWidget({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage ?? AppStrings.genericError,
      ),
    );
  }
}
