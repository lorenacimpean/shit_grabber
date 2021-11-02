import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class SignUpController extends SubscriptionState<SignUpController> {
  late RxList<FormFieldModel> fields;
  late RxBool isPasswordError;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    isPasswordError = false.obs;
    _initFields();
  }

  void _initFields() {
    List<FormFieldModel> list =
        FieldType.values.map((t) => FormFieldModel.fromType(t)).toList();
    fields = list.obs;
    change(fields, status: RxStatus.success());
  }

  void validateConfirmPassword() {
    FormFieldModel passwordField =
        fields.value.firstWhere((f) => f.fieldType == FieldType.password);
    FormFieldModel confirmPasswordField = fields.value
        .firstWhere((f) => f.fieldType == FieldType.confirmPassword);

    String passwordText = passwordField.textEditingController.value.text;
    String confirmPassWordText =
        confirmPasswordField.textEditingController.value.text;

    if ((passwordText.isNotEmpty && confirmPassWordText.isNotEmpty) &&
        confirmPassWordText != passwordText) {
      showConfirmPasswordErrorMessage();
      passwordField.textEditingController.clear();
      confirmPasswordField.textEditingController.clear();
    }
  }

  void toggleObscureText(FormFieldModel currentField) {
    fields.value
      ..map((field) {
        if (field == currentField) {
          bool isObscured = field.isTextObscured ?? true;
          field.isTextObscured = !isObscured;
        }
      }).toList();
    change(fields.value, status: RxStatus.success());
  }

  void showConfirmPasswordErrorMessage() {
    Stream<bool> delayStream = Stream.value(false).delay(Duration(seconds: 3));
    isPasswordError = true.obs;
    change(isPasswordError.value, status: RxStatus.success());
    disposeLater(delayStream.listen((showError) {
      isPasswordError = showError.obs;
      change(isPasswordError.value, status: RxStatus.success());
    }));
  }
}
