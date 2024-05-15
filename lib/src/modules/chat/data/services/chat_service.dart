import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:hawi_hub_owner/src/core/local/shared_prefrences.dart';
import 'package:hawi_hub_owner/src/core/utils/constance_manager.dart';
import 'package:hawi_hub_owner/src/modules/chat/data/models/connection.dart';

class ChatService {
  Future<Either<String, Connection>> connection() async {
    try {
      Response response = await DioHelper.postData(
        path: EndPoints.chat, data: {},
      );
      Connection connection = Connection.fromJson(response.data);
      ConstantsManager.connectionToken = connection.token;
      ConstantsManager.connectionId = connection.id;
      // await CacheHelper.saveData(key: 'connectionToken', value: connection.token);
      // await CacheHelper.saveData(key: 'connectionId', value: connection.id);
      return Right(connection);
    } catch (e) {
      // print(e);
      return Left(e.toString());
    }
  }
}
