import 'package:flutter/material.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/themes/app_colors.dart';
import 'package:shit_grabber/themes/app_dimensions.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/themes/app_text_theme.dart';
import 'package:shit_grabber/widgets/app_text_input.dart';

class AuthWidget extends StatelessWidget {
  final List<FormFieldModel> fields;
  final Function(FormFieldModel model) onTextObscureToggle;
  final VoidCallback onSubmit;
  final bool isConfirmPasswordValid;
  final bool isEmailValid;

  const AuthWidget(
      {Key? key,
      required this.fields,
      required this.onTextObscureToggle,
      required this.onSubmit,
      required this.isConfirmPasswordValid,
      required this.isEmailValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: ListView(children: [
        _buildInfo(),
        _buildFields(),
        if (!isEmailValid)
          FormErrorWidget(
            errorMessage: AppStrings.emailError,
          ),
        isConfirmPasswordValid
            ? Container()
            : FormErrorWidget(
                errorMessage: AppStrings.confirmPasswordError,
              ),
        _buildSubmitButton(),
      ]),
    );
  }

  Widget _buildInfo() => Padding(
        padding: EdgeInsets.only(bottom: AppDimensions.defaultPadding),
        child: Text(
          AppStrings.signUpInfo,
          style: AppTextTheme.darkTextTheme.headline2?.copyWith(
            color: AppColors.appBlack,
          ),
          textAlign: TextAlign.justify,
        ),
      );

  Widget _buildFields() => ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: fields.length,
        itemBuilder: (ctx, i) => AnimatedContainer(
          duration: Duration(milliseconds: 300),
          child: AppTextInput(
            formField: fields[i],
            onTextObscureToggle: () => onTextObscureToggle(fields[i]),
          ),
        ),
      );

  Widget _buildSubmitButton() => Padding(
        padding: EdgeInsets.only(top: AppDimensions.smallPadding),
        child: Center(
          child: ElevatedButton(
            onPressed: onSubmit,
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.smallPadding),
              child: Text(
                AppStrings.submit,
                style: AppTextTheme.darkTextTheme.headline2?.copyWith(
                  color: AppColors.appBlack,
                ),
              ),
            ),
          ),
        ),
      );
}

class FormErrorWidget extends StatelessWidget {
  final String errorMessage;

  const FormErrorWidget({Key? key, required this.errorMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.opaqueBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.defaultRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppDimensions.smallPadding),
        child: Text(
          errorMessage,
          style: AppTextTheme.darkTextTheme.headline3
              ?.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}
