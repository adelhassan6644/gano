import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:gano/app/core/utils/app_storage_keys.dart';
import 'package:gano/data/dio/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../data/api/end_points.dart';
import '../../../data/error/api_error_handler.dart';
import '../../../data/error/failures.dart';

class InvitationRepo {
  DioClient dioClient;
  SharedPreferences sharedPreferences;
  InvitationRepo({required this.dioClient, required this.sharedPreferences});

  Future<Either<ServerFailure, Response>> inviteFriend(mail) async {
    try {
      Response response = await dioClient.post(
          uri: EndPoints.invitation(
              sharedPreferences.getString(AppStorageKey.userId)),
          data: {"mail": mail});
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
