import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/core/utils/app_snack_bar.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/features/profile/model/profile_model.dart';
import 'package:gano/navigation/custom_navigation.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/routes.dart';
import '../repo/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

  bool get isLogin => profileRepo.isLoggedIn();

  ProfileModel? profileModel;
  TextEditingController nameTEC = TextEditingController();
  TextEditingController emailTEC = TextEditingController();
  TextEditingController phoneTEC = TextEditingController();

  File? profileImage;
  onSelectImage(File? file) {
    profileImage = file;
    notifyListeners();
  }

  clear() {
    profileImage = null;
    nameTEC.clear();
    phoneTEC.clear();
    emailTEC.clear();
    profileModel = null;
  }

  hasImage() {
    if (profileImage != null) {
      return true;
    } else {
      return false;
    }
  }

  bool _boolCheckString(dynamic value, String key, Map<String, dynamic> body) {
    if (value != null && value != "" && value != body[key]) {
      return true;
    } else {
      return false;
    }
  }

  bool checkData(Map<String, dynamic> body) {
    return _boolCheckString(nameTEC.text.trim(), "name", body) ||
        _boolCheckString(phoneTEC.text.trim(), "phone", body);
  }

  bool isUpdate = false;
  updateProfile() async {
    Map<String, dynamic> body = {
      "name": profileModel?.name,
      "phone": profileModel?.phone,
    };

    if (checkData(body) || hasImage()) {
      if (profileImage != null) {
        body.addAll({
          "photo": MultipartFile.fromFileSync(profileImage!.path),
        });
      }
      if (_boolCheckString(phoneTEC.text.trim(), "phone", body)) {
        body["phone"] = phoneTEC.text.trim();
      }
      if (_boolCheckString(nameTEC.text.trim(), "name", body)) {
        body["name"] = nameTEC.text.trim();
      }

      try {
        isUpdate = true;
        notifyListeners();
        log(body.entries.toString());
        Either<ServerFailure, Response> response =
            await profileRepo.updateProfile(body: FormData.fromMap(body));
        response.fold((fail) {
          CustomSnackBar.showSnackBar(
              notification: AppNotification(
                  message: ApiErrorHandler.getMessage(fail),
                  isFloating: true,
                  backgroundColor: Styles.IN_ACTIVE,
                  borderColor: Colors.red));
        }, (response) {
          getProfile(withLoading: false);
          Future.delayed(
              Duration.zero,
              () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
                    ConfirmationDialog(
                      title: getTranslated("your_profile_successfully_updated",
                          CustomNavigator.navigatorState.currentContext!),
                      mainTextButton: getTranslated("dashboard",
                          CustomNavigator.navigatorState.currentContext!),
                      onTapMain: () => CustomNavigator.push(Routes.DASHBOARD,
                          arguments: 0, clean: true),
                    )
                  ]));
        });

        isUpdate = false;
        notifyListeners();
      } catch (e) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: e.toString(),
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Styles.RED_COLOR,
                isFloating: true));
        isUpdate = false;
        notifyListeners();
      }
    } else {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: getTranslated("you_must_change_something",
                  CustomNavigator.navigatorState.currentContext!),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
    }
  }

  bool isLoading = false;
  getProfile({bool withLoading = true}) async {
    try {
      if (withLoading) {
        isLoading = true;
      }
      notifyListeners();

      Either<ServerFailure, Response> response = await profileRepo.getProfile();

      response.fold((fail) {
        showToast(ApiErrorHandler.getMessage(fail));
      }, (response) {
        profileModel = ProfileModel.fromJson(response.data['data']);
        initProfileData();
      });
      if (withLoading) {
        isLoading = false;
      }
      notifyListeners();
    } catch (e) {
      if (withLoading) {
        isLoading = false;
      }
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Styles.RED_COLOR,
              isFloating: true));
      notifyListeners();
    }
  }

  initProfileData() {
    profileImage = null;
    nameTEC.text = profileModel?.name?.trim() ?? "";
    emailTEC.text = profileModel?.email?.trim() ?? "";
    phoneTEC.text = profileModel?.phone?.trim() ?? "";
  }

  // bool isGetting = false;
  // StatisticsModel? statisticsModel;
  // getStatistics() async {
  //   try {
  //     isGetting = true;
  //     notifyListeners();
  //
  //     Either<ServerFailure, Response> response =
  //         await profileRepo.getStatistics();
  //
  //     response.fold((fail) {
  //       CustomSnackBar.showSnackBar(
  //           notification: AppNotification(
  //               message: fail.error,
  //               backgroundColor: Styles.IN_ACTIVE,
  //               borderColor: Styles.RED_COLOR,
  //               isFloating: true));
  //     }, (response) {
  //       if (response.data['data'] != null) {
  //         statisticsModel = StatisticsModel.fromJson(response.data['data']);
  //       }
  //     });
  //     isGetting = false;
  //
  //     notifyListeners();
  //   } catch (e) {
  //     isGetting = false;
  //     CustomSnackBar.showSnackBar(
  //         notification: AppNotification(
  //             message: e.toString(),
  //             backgroundColor: Styles.IN_ACTIVE,
  //             borderColor: Styles.RED_COLOR,
  //             isFloating: true));
  //     notifyListeners();
  //   }
  // }
}
