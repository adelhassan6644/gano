import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/app/localization/localization/language_constant.dart';
import 'package:gano/features/profile/provider/profile_provider.dart';
import 'package:gano/navigation/custom_navigation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/app_strings.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
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

  launchTwitter() {
    try {
      launchUrl(Uri.parse(
        'https://www.twitter.com/Software_Cloud2',
      ));
    } catch (e) {
      log("=====> Exception Twitter Launch $e");
    }
  }

  launch(type, context) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.share(
      "شارك هذا الكود مع عائلتك وأصدقائك  واربح نقاط من Gano  الكود ${sl.get<ProfileProvider>().profileModel!.code}\n Android download : ${AppStrings.androidDownloadLink}\n IOS download : ${AppStrings.iOSDownloadLink}\n",
      subject: "Gano",
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
    switch (type) {
      case LaunchType.facebook:
        {
          return;
        }
      case LaunchType.twitter:
        {
          return;
        }
      case LaunchType.instagram:
        {
          return;
        }
      case LaunchType.whatsapp:
        {
          return;
        }
    }
  }
}

enum LaunchType { facebook, twitter, instagram, whatsapp }
