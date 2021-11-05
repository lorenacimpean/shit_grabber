import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rxdart/src/transformers/delay.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/repo/firebase_repo.dart';
import 'package:shit_grabber/themes/app_strings.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class SignUpController extends SubscriptionState<SignUpController> {
  AuthRepo authRepo = AuthRepo();
  late RxString title;
  late Rx<User?> firebaseUser;
  late RxList<FormFieldModel> fields;
  late RxBool isPasswordError;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    firebaseUser = Rx<User?>(null);
    firebaseUser.bindStream(authRepo.currentUser);
    isPasswordError = false.obs;
    _initFields();

    ever(firebaseUser, _setScreenTitle);
  }

  void _initFields() {
    List<FormFieldModel> list =
        FieldType.values.map((t) => FormFieldModel.fromType(t)).toList();
    fields = list.obs;
    change(fields, status: RxStatus.success());
  }

  void validateConfirmPassword() {
    String passwordText = _passwordField.textEditingController.value.text;
    String confirmPasswordText =
        _confirmPasswordField.textEditingController.value.text;

    if ((passwordText.isNotEmpty && confirmPasswordText.isNotEmpty) &&
        passwordText != confirmPasswordText) {
      showConfirmPasswordErrorMessage();
      _passwordField.textEditingController.clear();
      _confirmPasswordField.textEditingController.clear();
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

  void _setScreenTitle(User? user) {
    title = user != null ? AppStrings.login.obs : AppStrings.signUp.obs;
    change(title, status: RxStatus.success());
  }

  void login(String email, String password) {
    disposeLater(authRepo.login(email, password).listen((isSuccess) {
      if (isSuccess) {
        //TODO: add navigation to sync options
        // Get.offAll(page);
      }
    }));
  }

  void signUp(String email, String password) {
    disposeLater(authRepo.signup(email, password).listen((isSuccess) {
      //TODO: add navigation to sync options
      // Get.offAll(page);
    }));
  }

  void goToNext() {
    validateConfirmPassword();
    if (!isPasswordError.value) {
      firebaseUser.value != null
          ? login(_emailField.textEditingController.text,
              _passwordField.textEditingController.text)
          : signUp(_emailField.textEditingController.text,
              _passwordField.textEditingController.text);
    }
  }

  FormFieldModel get _emailField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.email);

  FormFieldModel get _passwordField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.password);

  FormFieldModel get _confirmPasswordField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.confirmPassword);
}
