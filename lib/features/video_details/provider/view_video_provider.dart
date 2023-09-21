import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../components/confirmation_dialog.dart';
import '../../../components/custom_simple_dialog.dart';
import '../../../data/config/di.dart';
import '../../../data/error/failures.dart';
import '../../../main_page/provider/ad_mob_provider.dart';
import '../../../navigation/custom_navigation.dart';
import '../repo/video_details_repo.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io';

class ViewVideoProvider extends ChangeNotifier {
  VideoDetailsRepo repo;
  ViewVideoProvider({required this.repo});

  bool isViewed = false;
  viewVideo({id, time}) async {
    isViewed = true;
    notifyListeners();
    Either<ServerFailure, Response> response =
        await repo.viewVideo(id: id, time: time);
    response.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(fail),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      Future.delayed(
          Duration.zero,
          () => CustomSimpleDialog.parentSimpleDialog(customListWidget: [
                ConfirmationDialog(
                  title: "حاب تكسب نقاط اكثر شاهد اعلانات اكثر",
                  mainTextButton: " مشاهدة الاعلان التالي",
                  onTapMain: ()
                  {
                    CustomNavigator.pop();
                    sl<AdMobProvider>().showRewardedAd();
                  },
                )
              ]));
    });
    isViewed = false;
    notifyListeners();
  }


}
