import 'package:get/get.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class SignUpController extends SubscriptionState<SignUpController> {
  late RxList<FormFieldModel> fields;
  late RxBool isPasswordIdentical;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    isPasswordIdentical = RxBool(true);
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

    if (passwordText.isEmpty ||
        confirmPassWordText.isEmpty ||
        confirmPassWordText != passwordText) {
      isPasswordIdentical = false.obs;
      change(isPasswordIdentical.value, status: RxStatus.success());
      passwordField.textEditingController.clear();
      confirmPasswordField.textEditingController.clear();
    } else {
      isPasswordIdentical = true.obs;
      change(isPasswordIdentical.value, status: RxStatus.success());
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
  //fkdugshusdgjdfsjhf/

  // fdsfs
}
