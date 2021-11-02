import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shit_grabber/themes/app_strings.dart';

enum FieldType {
  email,
  password,
  confirmPassword,
}

class FormFieldModel {
  final FieldType fieldType;
  final String label;
  final TextEditingController textEditingController;
  bool? isTextObscured;

  FormFieldModel(
    this.fieldType,
    this.label,
    this.textEditingController, {
    this.isTextObscured,
  });

  factory FormFieldModel.fromType(FieldType fieldType) {
    return FormFieldModel(
      fieldType,
      _labelByFieldType(fieldType),
      TextEditingController(),
      isTextObscured: fieldType != FieldType.email,
    );
  }

  String? validatorByType(String? s) {
    if (s?.isEmpty ?? true) {
      return AppStrings.emptyField;
    } else {
      switch (fieldType) {
        case FieldType.email:
          return _validateEmail(s!);
        case FieldType.password:
          return _validatePassword(s!);

        case FieldType.confirmPassword:
          return _validatePassword(s!);
      }
    }
  }

  String? _validateEmail(String s) {
    return GetUtils.isEmail(s) ? null : AppStrings.emailFormatError;
  }

  String? _validatePassword(String s) {
    bool isLengthOK = s.length >= 8;
    bool hasNum = GetUtils.hasMatch(s, r'\d');
    bool hasSpecialCharacters = !GetUtils.hasMatch(s, r'[#?!@$%^&*-]');
    bool hasCapitalLetter = GetUtils.hasCapitalletter(s);
    bool isValid =
        isLengthOK && hasNum && hasSpecialCharacters && hasCapitalLetter;
    return isValid ? null : AppStrings.passwordError;
  }

  static String _labelByFieldType(FieldType fieldType) {
    switch (fieldType) {
      case FieldType.email:
        return AppStrings.email;
      case FieldType.password:
        return AppStrings.password;
      case FieldType.confirmPassword:
        return AppStrings.confirmPassword;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormFieldModel &&
          runtimeType == other.runtimeType &&
          fieldType == other.fieldType &&
          label == other.label &&
          textEditingController == other.textEditingController &&
          isTextObscured == other.isTextObscured;

  @override
  int get hashCode =>
      fieldType.hashCode ^
      label.hashCode ^
      textEditingController.hashCode ^
      isTextObscured.hashCode;
}
