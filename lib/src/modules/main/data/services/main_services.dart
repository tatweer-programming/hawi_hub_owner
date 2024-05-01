import 'package:dartz/dartz.dart';

import '../models/sport.dart';

class MainServices {
  Future<Either<Exception, List<String>>> getBanners() async {
    List<String> banners1 = [
      "https://img.freepik.com/free-photo/sports-tools_53876-138077.jpg?w=1060",
      "https://img.freepik.com/free-photo/five-swimmers-racing-against-each-other-swiming-pool_171337-7818.jpg?w=1060",
      "https://img.freepik.com/free-photo/basketball-player-throwing-ball-into-net_23-2148393872.jpg?size=626&ext=jpg"
    ];
    try {
      // List<String> banners = [];
      // var response = await DioHelper.getData(path: EndPoints.getBanners);
      // if (response.statusCode == 200) {
      //   print(response.data[1]["img"].toString());
      //   for (var item in response.data) {
      //     if (item.containsKey('img')) {
      //       banners.add(item['img']);
      //     }
      //   }
      // }
      // await startTimer(.9);
      return Right(banners1);
    } on Exception {
      return Right(banners1);
    }
  }

  Future<Either<Exception, List<Sport>>> getSports() async {
    List<Sport> sports1 = [
      Sport(
          name: "Basketball",
          image:
              "https://img.freepik.com/free-photo/football-players_53876-66433.jpg?size=626&ext=jpg",
          id: 1),
      Sport(
          name: "Football",
          image:
              "https://img.freepik.com/free-photo/football-players_53876-66433.jpg?size=626&ext=jpg",
          id: 2),
      Sport(
          name: "Tennis",
          image:
              "https://img.freepik.com/free-photo/tennis-player_53876-66430.jpg?size=626&ext=jpg",
          id: 3),
      Sport(
          name: "Volleyball",
          image:
              "https://img.freepik.com/free-photo/tennis-player_53876-66430.jpg?size=626&ext=jpg",
          id: 4),
      Sport(
          name: "Handball",
          image:
              "https://img.freepik.com/free-photo/tennis-player_53876-66430.jpg?size=626&ext=jpg",
          id: 5),
      Sport(
          name: "Soccer",
          image:
              "https://img.freepik.com/free-photo/tennis-player_53876-66430.jpg?size=626&ext=jpg",
          id: 6),
    ];
    try {
      // await startTimer(2.1);
      return Right(sports1);
    } on Exception catch (e) {
      return Left(e);
    }
  }
}
