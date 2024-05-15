import 'package:dartz/dartz.dart';
import 'package:hawi_hub_owner/src/core/apis/dio_helper.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';

import '../models/sport.dart';

class MainServices {
  Future<Either<Exception, List<String>>> getBanners() async {
    List<String> banners1 = [
      "https://img.freepik.com/free-photo/sports-tools_53876-138077.jpg?w=1060",
      "https://img.freepik.com/free-photo/five-swimmers-racing-against-each-other-swiming-pool_171337-7818.jpg?w=1060",
      "https://img.freepik.com/free-photo/basketball-player-throwing-ball-into-net_23-2148393872.jpg?size=626&ext=jpg"
    ];
    try {
      List<String> banners = [];
      var response = await DioHelper.getData(path: EndPoints.getBanners);
      print(response.data);
      if (response.statusCode == 200 && response.data.isNotEmpty) {
        for (var item in response.data) {
          banners.add(item.toString());
        }
        return Right(banners);
      }

      return Right(banners1);
    } on Exception {
      return Right(banners1);
    }
  }

  Future<Either<Exception, List<Sport>>> getSports() async {
    try {
      List<Sport> sports = [];
      var response = await DioHelper.getData(path: EndPoints.getSports);
      if (response.statusCode == 200) {
        for (var item in response.data) {
          sports.add(Sport.fromJson(item));
        }
      }
      print(sports);
      return Right(sports);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
