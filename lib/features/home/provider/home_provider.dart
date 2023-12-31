import 'package:carousel_slider/carousel_controller.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import 'package:gano/features/home/models/banner_model.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../models/ads_model.dart';
import '../repo/home_repo.dart';
import 'package:flutter/rendering.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepo homeRepo;
  HomeProvider({required this.homeRepo});

  bool get isLogin => homeRepo.isLoggedIn();

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

  CarouselController bannerController = CarouselController();
  late int _bannerIndex = 0;
  int get bannerIndex => _bannerIndex;
  void setBannerIndex(int index) {
    _bannerIndex = index;
    notifyListeners();
  }

  List<BannerModel>? banners;
  bool isGetBanners = false;
  getBanners() async {
    try {
      banners?.clear();
      isGetBanners = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeBanner();
      response.fold((fail) {
        isGetBanners = false;
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
        notifyListeners();
      }, (success) {
        if (success.data["data"] != null) {
          banners = List<BannerModel>.from(
              success.data["data"].map((x) => BannerModel.fromJson(x)));
        }
        isGetBanners = false;
        notifyListeners();
      });
    } catch (e) {
      isGetBanners = false;
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      notifyListeners();
    }
  }

  List<AdsModel>? ads;
  bool isGetAds = false;
  getAds() async {
    try {
      isGetAds = true;
      ads?.clear();
      notifyListeners();
      Either<ServerFailure, Response> response = await homeRepo.getHomeAds();
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
