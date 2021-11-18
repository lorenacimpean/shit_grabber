import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/src/transformers/delay.dart';
import 'package:shit_grabber/models/form_field.dart';
import 'package:shit_grabber/models/response_model.dart';
import 'package:shit_grabber/repo/firebase_repo.dart';
import 'package:shit_grabber/repo/firestore_repo.dart';
import 'package:shit_grabber/utils/subscription_state.dart';

class SettingsController extends SubscriptionState<SettingsController> {
  AuthRepo authRepo = AuthRepo();
  FireStoreRepo _fireStoreRepo = FireStoreRepo();
  late Rx<User?> firebaseUser;
  late RxList<FormFieldModel> fields;
  late RxBool isPasswordError;
  late RxBool isEmailError;
  RxBool? accountExists;

  @override
  void onInit() {
    super.onInit();
    change(null, status: RxStatus.loading());
    firebaseUser = Rx<User?>(null);
    isPasswordError = false.obs;
    isEmailError = false.obs;
    _checkUser();
    _initFields();
  }

  void _initFields() {
    List<FormFieldModel> list = [];
    list.add(FormFieldModel.fromType(FieldType.email));
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

  void _checkUser() {
    change(null, status: RxStatus.loading());
    disposeLater(authRepo.currentUser.listen((user) {
      firebaseUser.value = user;
      change(firebaseUser.value, status: RxStatus.success());
      uploadAllToCloud();
    }));
  }

  void login(String email, String password) {
    disposeLater(authRepo.login(email, password).listen((response) {
      switch (response.state) {
        case ResponseState.success:
          // Get.toNamed(Routes.syncOptions);
          break;
        case ResponseState.loading:
          change(null, status: RxStatus.loading());
          break;
        case ResponseState.error:
          change(response.error.toString(),
              status: RxStatus.error(response.error.toString()));
          break;
      }
    }));
    _checkUser();
  }

  void signUp(String email, String password) {
    disposeLater(authRepo.signup(email, password).listen((response) {
      switch (response.state) {
        case ResponseState.success:
          // Get.toNamed(Routes.syncOptions);
          break;
        case ResponseState.loading:
          change(null, status: RxStatus.loading());
          break;
        case ResponseState.error:
          change(response.error.toString(),
              status: RxStatus.error(response.error.toString()));
          break;
      }
    }));
    _checkUser();
  }

  void goToNext() {
    if (_emailField.textEditingController.text.isNotEmpty) {
      isEmailError = false.obs;
      change(isEmailError.value, status: RxStatus.success());
      disposeLater(authRepo
          .checkAccountExists(_emailField.textEditingController.text)
          .listen((exists) {
        accountExists = exists.obs;
        fields.value.addIf(
            !_hasPasswordField, FormFieldModel.fromType(FieldType.password));
        change(fields.value, status: RxStatus.success());

        if (exists &&
            !isPasswordError.value &&
            _passwordField.textEditingController.text.isNotEmpty) {
          login(_emailField.textEditingController.text,
              _passwordField.textEditingController.text);
        } else if (!exists &&
            _passwordField.textEditingController.text.isNotEmpty) {
          fields.value.addIf(!_hasConfirmPasswordField,
              FormFieldModel.fromType(FieldType.confirmPassword));
          validateConfirmPassword();
          signUp(_emailField.textEditingController.text,
              _passwordField.textEditingController.text);
        }
        _checkUser();
      }));
    } else {
      isEmailError = true.obs;
      change(isEmailError.value, status: RxStatus.success());
    }
  }

  void logout() {
    disposeLater(
      authRepo.signOut().listen((_) {
        onInit();
      }),
    );
  }

  void uploadAllToCloud() {
    if (firebaseUser.value != null) {
      disposeLater(_fireStoreRepo
          .saveAllToFirestore(firebaseUser.value!.email!)
          .listen((_) {
        debugPrint('SettingsController: Saved all to Firestore...');
      }));
    }
  }

  FormFieldModel get _emailField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.email);

  FormFieldModel get _passwordField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.password);

  FormFieldModel get _confirmPasswordField =>
      fields.value.firstWhere((f) => f.fieldType == FieldType.confirmPassword);

  bool get _hasPasswordField =>
      fields.value.any((element) => element.fieldType == FieldType.password);

  bool get _hasConfirmPasswordField => fields.value
      .any((element) => element.fieldType == FieldType.confirmPassword);
}
