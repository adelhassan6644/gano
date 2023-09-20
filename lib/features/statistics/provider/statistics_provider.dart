import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/data/error/api_error_handler.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../data/error/failures.dart';
import 'package:flutter/rendering.dart';

import '../model/statistics_model.dart';
import '../repo/statistics_repo.dart';

class StatisticsProvider extends ChangeNotifier {
  StatisticsRepo repo;
  StatisticsProvider({required this.repo});

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

  bool get isLogin => repo.isLoggedIn();
  bool isMe(id) => repo.isMe(id);

  List<StatisticsModel> statistics = [];
  bool isLoading = false;
  getMonthlyStatistics() async {
    try {
      isLoading = true;
      statistics.clear();
      notifyListeners();

      Either<ServerFailure, Response> response =
          await repo.getMonthlyStatistics();
      response.fold((fail) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: ApiErrorHandler.getMessage(fail),
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (success) {
        if (success.data["data"] != null) {
          statistics = List<StatisticsModel>.from(
              success.data["data"].map((x) => StatisticsModel.fromJson(x)));
        }
      });

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
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
