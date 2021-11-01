import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';

class AppTextInput extends StatelessWidget {
  final FormFieldModel formField;
  final ValueChanged<bool>? onTextObscureToggle;

  AppTextInput({
    Key? key,
    required this.formField,
    this.onTextObscureToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.opaqueBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          AppDimensions.defaultRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.defaultPadding),
        child: Stack(
          children: [
            TextFormField(
              obscureText: formField.isTextObscured ?? false,
              controller: formField.textEditingController,
              decoration: InputDecoration(
                labelText: formField.label,
                errorMaxLines: 2,
              ),
              validator: formField.validatorByType,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            if (formField.isTextObscured ?? false)
              Positioned(
                right: 0,
                child: IconButton(
                  icon: Icon(CupertinoIcons.ant_circle_fill),
                  onPressed: () => onTextObscureToggle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
