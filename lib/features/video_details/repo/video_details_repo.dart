import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app/core/utils/app_storage_keys.dart';
import '../../../data/api/end_points.dart';
import '../../../data/dio/dio_client.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class VideoDetailsRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  VideoDetailsRepo({required this.dioClient, required this.sharedPreferences});

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppStorageKey.isLogin);
  }

  Future<Either<ServerFailure, Response>> getRelatedVideos(id) async {
    try {
      Response response = await dioClient.get(uri: EndPoints.relatedVideos(id));
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }

  Future<Either<ServerFailure, Response>> viewVideo({id, time}) async {
    try {
      Response response = await dioClient.post(uri: EndPoints.viewVideo, data: {
        "client_id": sharedPreferences.getString(AppStorageKey.userId),
        "video_id": id,
        "time": time
      });
      if (response.statusCode == 200) {
        return Right(response);
      } else {
        return left(ServerFailure(response.data['message']));
      }
    } catch (error) {
      return left(ServerFailure(ApiErrorHandler.getMessage(error)));
    }
  }
}