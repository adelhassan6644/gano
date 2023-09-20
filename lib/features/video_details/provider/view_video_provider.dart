import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import '../repo/video_details_repo.dart';

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
