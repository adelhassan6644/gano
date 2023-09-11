import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/navigation/custom_navigation.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/error/failures.dart';
import '../repo/invitation_repo.dart';

class InvitationProvider extends ChangeNotifier {
  InvitationRepo repo;
  InvitationProvider({required this.repo});

  final TextEditingController mailTEC = TextEditingController();

  bool isLoading = false;
  sendInvitation() async {
    try {
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.inviteFriend(mailTEC.text.trim());
      response.fold((l) {
        showToast(l.error);
      }, (response) {
        CustomNavigator.pop();
        Future.delayed(
            Duration.zero,
            () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
                  ConfirmationDialog(
                    title: getTranslated("your_invitation_sent_successfully",
                        CustomNavigator.navigatorState.currentContext!),
                    mainTextButton: getTranslated(
                        "back", CustomNavigator.navigatorState.currentContext!),
                    onTapMain: () => CustomNavigator.pop(),
                  )
                ]));
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      showToast(e.toString());
      isLoading = false;
      notifyListeners();
    }
  }

  launch() {}
}
