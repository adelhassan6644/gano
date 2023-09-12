import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gano/components/custom_simple_dialog.dart';
import 'package:provider/provider.dart';
import '../../../app/core/utils/images.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../profile/provider/profile_provider.dart';
import '../repo/auth_repo.dart';
import '../../../../navigation/custom_navigation.dart';
import '../../../../navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/localization/localization/language_constant.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepo authRepo;
  AuthProvider({
    required this.authRepo,
  }) {
    _mailTEC = TextEditingController(
        text: kDebugMode ? "adel@gmail.com" : authRepo.getMail());
  }

  bool get isLogin => authRepo.isLoggedIn();

  late TextEditingController _mailTEC;
  TextEditingController get mailTEC => _mailTEC;

  final TextEditingController invitationCodeTEC = TextEditingController();
  final TextEditingController nameTEC = TextEditingController();
  final TextEditingController phoneTEC = TextEditingController();
  final TextEditingController currentPasswordTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController confirmPasswordTEC = TextEditingController();
  final TextEditingController codeTEC = TextEditingController();

  int userType = 0;
  List<String> usersTypes = ["male", "female"];
  void selectedUserType(v) {
    userType = v;
    notifyListeners();
  }

  clear() {
    invitationCodeTEC.clear();
    nameTEC.clear();
    _mailTEC.clear();
    phoneTEC.clear();
    passwordTEC.clear();
    currentPasswordTEC.clear();
    confirmPasswordTEC.clear();
    codeTEC.clear();
  }

  bool _isRememberMe = true;
  bool get isRememberMe => _isRememberMe;
  void onRememberMe(bool value) {
    _isRememberMe = value;
    notifyListeners();
  }

  bool _isAgree = true;
  bool get isAgree => _isAgree;
  void onAgree(bool value) {
    _isAgree = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  logIn() async {
    try {
      _isLoading = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.logIn(
          mail: mailTEC.text.trim(), password: passwordTEC.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: getTranslated("invalid_credentials",
                    CustomNavigator.navigatorState.currentContext!),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        authRepo.saveUserId(success.data['data']["id"]);
        if (success.data['data']["email_verified_at"] == null) {
          CustomNavigator.push(Routes.VERIFICATION, arguments: true);
        } else if (success.data['data']["hasCategories"] == null) {
          CustomNavigator.push(Routes.FAVOURITE, arguments: false);
        } else {
          authRepo.setLoggedIn();
          CustomNavigator.push(Routes.DASHBOARD, clean: true);
          clear();
        }
      });
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isLoading = false;
      notifyListeners();
    }
  }

  bool _isReset = false;
  bool get isReset => _isReset;

  resetPassword() async {
    try {
      _isReset = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.reset(
          password: passwordTEC.text.trim(), email: mailTEC.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(
                    canDismiss: false,
                    customListWidget: [
                      ConfirmationDialog(
                        image: Images.success,
                        title: getTranslated(
                            "your_password_changed_successfully",
                            CustomNavigator.navigatorState.currentContext!),
                        description: getTranslated(
                            "you_can_now_login_with_your_new_password",
                            CustomNavigator.navigatorState.currentContext!),
                        mainTextButton: getTranslated("dashboard",
                            CustomNavigator.navigatorState.currentContext!),
                        onTapMain: () =>
                            CustomNavigator.push(Routes.LOGIN, clean: true),
                      )
                    ]));
        clear();
      });
      _isReset = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isReset = false;
      notifyListeners();
    }
  }

  bool _isChange = false;
  bool get isChange => _isChange;
  changePassword() async {
    try {
      _isChange = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.change(
          oldPassword: currentPasswordTEC.text.trim(),
          password: passwordTEC.text.trim());
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(
                    canDismiss: false,
                    customListWidget: [
                      ConfirmationDialog(
                        image: Images.success,
                        title: getTranslated(
                            "your_password_changed_successfully",
                            CustomNavigator.navigatorState.currentContext!),
                        description: getTranslated(
                            "you_can_now_login_with_your_new_password",
                            CustomNavigator.navigatorState.currentContext!),
                        mainTextButton: getTranslated("dashboard",
                            CustomNavigator.navigatorState.currentContext!),
                        onTapMain: () => CustomNavigator.push(Routes.DASHBOARD,
                            arguments: 0, clean: true),
                      )
                    ]));
        clear();
      });
      _isChange = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isChange = false;
      notifyListeners();
    }
  }

  bool _isRegister = false;
  bool get isRegister => _isRegister;

  register() async {
    try {
      _isRegister = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.register(
        name: nameTEC.text.trim(),
        mail: mailTEC.text.trim(),
        password: passwordTEC.text.trim(),
        phone: phoneTEC.text.trim(),
        code: invitationCodeTEC.text.trim(),
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        authRepo.saveUserId(success.data['data']["id"]);
        CustomNavigator.push(Routes.VERIFICATION, arguments: true);
      });
      _isRegister = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isRegister = false;
      notifyListeners();
    }
  }

  resend(fromRegister) async {
    await authRepo.resendCode(
      mail: mailTEC.text.trim(),
      fromRegister: fromRegister,
    );
  }

  bool _isForget = false;
  bool get isForget => _isForget;

  forgetPassword() async {
    try {
      _isForget = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.forgetPassword(
        mail: mailTEC.text.trim(),
      );
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(
                    canDismiss: false,
                    customListWidget: [
                      ConfirmationDialog(
                        image: Images.checkMail,
                        title: getTranslated("check_the_mail",
                            CustomNavigator.navigatorState.currentContext!),
                        description: getTranslated("check_the_mail_description",
                            CustomNavigator.navigatorState.currentContext!),
                        mainTextButton: getTranslated("verify_the_mail",
                            CustomNavigator.navigatorState.currentContext!),
                        onTapMain: () => CustomNavigator.push(
                            Routes.VERIFICATION,
                            replace: true,
                            arguments: false),
                      )
                    ]));
      });
      _isForget = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isForget = false;
      notifyListeners();
    }
  }

  bool _isVerify = false;
  bool get isVerify => _isVerify;
  verify(fromRegister) async {
    try {
      _isVerify = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await authRepo.verifyMail(
          mail: mailTEC.text.trim(),
          code: codeTEC.text.trim(),
          fromRegister: fromRegister,
          updateHeader: fromRegister);
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: fail.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (fromRegister) {
          CustomNavigator.push(Routes.FAVOURITE, arguments: false, clean: true);
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: getTranslated("register_successfully",
                      CustomNavigator.navigatorState.currentContext!),
                  isFloating: true,
                  backgroundColor: Styles.ACTIVE,
                  borderColor: Colors.transparent));
          clear();
        } else {
          CustomNavigator.push(Routes.RESET_PASSWORD, replace: true);
        }
      });
      _isVerify = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(e),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      _isVerify = false;
      notifyListeners();
    }
  }

  logOut() async {
    CustomNavigator.push(Routes.SPLASH, clean: true);
    await authRepo.clearSharedData();
    clear();
    Provider.of<ProfileProvider>(CustomNavigator.navigatorState.currentContext!,
            listen: false)
        .clear();
    CustomSnackBar.showSnackBar(
        notification: AppNotification(
            message: getTranslated("your_logged_out_successfully",
                CustomNavigator.navigatorState.currentContext!),
            isFloating: true,
            backgroundColor: Styles.ACTIVE,
            borderColor: Colors.transparent));
    notifyListeners();
  }
}
