import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/navigation/custom_navigation.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/routes.dart';
import '../repo/contact_with_us_repo.dart';

class ContactWithUsProvider extends ChangeNotifier {
  ContactWithUsRepo contactRepo;
  ContactWithUsProvider({required this.contactRepo});

  final TextEditingController messageTEC = TextEditingController();

  MessageType? type;
  List<MessageType> types = [
    MessageType.suggestion,
    MessageType.complain,
    MessageType.enquiry
  ];
  void onSelectType(v) {
    type = v;
    notifyListeners();
  }

  clear() {
    messageTEC.clear();
    type = null;
  }

  bool checkData() {
    if (type == null) {
      showToast(getTranslated("oops_select_message_type",
          CustomNavigator.navigatorState.currentContext!));
      return false;
    }
    if (messageTEC.text.trim().isEmpty) {
      showToast(getTranslated("oops_enter_your_message",
          CustomNavigator.navigatorState.currentContext!));

      return false;
    }
    return true;
  }

  bool isLoading = false;
  sendMessage() async {
    try {
      isLoading = true;
      notifyListeners();

      var body = {"type": type?.index, "message": messageTEC.text.trim()};

      Either<ServerFailure, Response> response =
          await contactRepo.sendMessage(body);
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
                  ConfirmationDialog(
                    title: getTranslated("your_message_sent_successfully",
                        CustomNavigator.navigatorState.currentContext!),
                    mainTextButton: getTranslated("dashboard",
                        CustomNavigator.navigatorState.currentContext!),
                    onTapMain: () => CustomNavigator.push(Routes.DASHBOARD,
                        arguments: 0, clean: true),
                  )
                ]));
        clear();
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isLoading = false;
      notifyListeners();
    }
  }
}

enum MessageType { suggestion, complain, enquiry }
