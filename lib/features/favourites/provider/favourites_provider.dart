import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gano/navigation/routes.dart';
import '../../../app/core/utils/app_snack_bar.dart';
import '../../../app/core/utils/styles.dart';
import '../../../app/localization/localization/language_constant.dart';
import '../../../data/error/failures.dart';
import '../../../navigation/custom_navigation.dart';
import '../model/favourite_model.dart';
import '../repo/favourites_repo.dart';

class FavouritesProvider extends ChangeNotifier {
  final FavouriteRepo repo;
  FavouritesProvider({required this.repo});

  bool get isLogin => repo.isLoggedIn();

  List<int> favouritesId = [];
  bool isChanged = false;

  addItem({required int id, required bool isFav}) {
    if (isFav) {
      favouritesId.removeWhere((e) => e == id);
    } else {
      favouritesId.add(id);
    }
    isChanged = true;
    notifyListeners();
  }

  bool isLoading = false;
  FavouriteModel? favouriteModel;
  getFavourites() async {
    try {
      favouriteModel = null;
      favouritesId.clear();
      isLoading = true;
      notifyListeners();

      Either<ServerFailure, Response> response = await repo.getFavourites();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        favouriteModel = FavouriteModel.fromJson(response.data);
        favouritesId.clear();
        if (favouriteModel!.data != null && favouriteModel!.data!.isNotEmpty) {
          for (var e in favouriteModel!.data!) {
            if (e.id != null) {
              favouritesId.add(e.id!);
            }
          }
        }
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

  bool isGetting = false;
  FavouriteModel? items;
  getItems() async {
    try {
      items = null;
      isGetting = true;
      notifyListeners();
      Either<ServerFailure, Response> response = await repo.getCategories();
      response.fold((l) {
        CustomSnackBar.showSnackBar(
            notification: AppNotification(
                message: l.error,
                isFloating: true,
                backgroundColor: Styles.IN_ACTIVE,
                borderColor: Colors.transparent));
      }, (response) {
        items = FavouriteModel.fromJson(response.data);
      });

      isGetting = false;
      notifyListeners();
    } catch (e) {
      CustomSnackBar.showSnackBar(
          notification: AppNotification(
              message: e.toString(),
              isFloating: true,
              backgroundColor: Styles.IN_ACTIVE,
              borderColor: Colors.transparent));
      isGetting = false;
      notifyListeners();
    }
  }

  bool isSaving = false;
  updateFavourites(bool fromAuth) async {
    if (isChanged) {
      try {
        isSaving = true;
        notifyListeners();

        var body = {"categories": favouritesId};

        Either<ServerFailure, Response> response =
            await repo.updateFavourite(body);
        response.fold((l) {
          showToast(l.error);
        }, (response) {
          isChanged = false;
          showToast(getTranslated("your_favourites_has_been_updated",
              CustomNavigator.navigatorState.currentContext!));
          if (fromAuth) {
            repo.setLoggedIn();
            CustomNavigator.push(Routes.DASHBOARD, clean: true, arguments: 0);
          }
        });
        isSaving = false;
        notifyListeners();
      } catch (e) {
        showToast(e.toString());
        isSaving = false;
        notifyListeners();
      }
    } else {
      showToast(
        getTranslated("you_must_change_something",
            CustomNavigator.navigatorState.currentContext!),
      );
    }
  }
}
