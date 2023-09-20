import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';

import '../../../main_models/video_model.dart';
import '../repo/video_details_repo.dart';

class RelatedVideosProvider extends ChangeNotifier {
  VideoDetailsRepo repo;
  RelatedVideosProvider({required this.repo});

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

  List<VideoModel> videos = [];
  bool isLoading = false;
  getVideos(id) async {
    isLoading = true;
    videos.clear();
    notifyListeners();
    Either<ServerFailure, Response> response = await repo.getRelatedVideos(id);
    response.fold((fail) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: ApiErrorHandler.getMessage(fail),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
    }, (success) {
      if (success.data["data"] != null) {
        videos = List<VideoModel>.from(
            success.data["data"].map((x) => VideoModel.fromJson(x)));
      }
    });
    isLoading = false;
    notifyListeners();
  }

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
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: success.data["message"],
              isFloating: true,
              backgroundColor: Styles.ACTIVE,
              borderColor: Colors.transparent));
    });
    isViewed = false;
    notifyListeners();
  }
}
