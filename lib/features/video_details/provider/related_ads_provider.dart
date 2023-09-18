import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';

import '../../home/models/ads_model.dart';
import '../repo/related_ads_repo.dart';

class RelatedAdsProvider extends ChangeNotifier {
  RelatedAdsRepo repo;
  RelatedAdsProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  bool goingDown = false;
  scroll(controller) {
    controller.addListener(() {
      if (controller.position.userScrollDirection == ScrollDirection.forward) {
        goingDown = false;
        notifyListeners();
      } else {
        goingDown = true;
        notifyListeners();
      }
    });
  }

  List<AdsModel>? ads;
  bool isGetAds = false;
  getAds(id) async {
    try {
      isGetAds = true;
      ads?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getRelatedAds();
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["data"] != null) {
          ads = List<AdsModel>.from(
              success.data["data"].map((x) => AdsModel.fromJson(x)));
        }
      });
      isGetAds = false;
      notifyListeners();
    } catch (e) {
      isGetAds = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }
}
