import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hawi_hub_owner/src/core/apis/api.dart';
import 'package:hawi_hub_owner/src/core/apis/end_points.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constance_manager.dart';

class PaymentService {
  // Future<PaymentResponse> pay({
  //   required BuildContext context,
  //   required double totalPrice,
  // }) async {
  //   return await MyFatoorah.startPayment(
  //     context: context,
  //     request: MyfatoorahRequest.test(
  //       currencyIso: Country.SaudiArabia,
  //       successUrl: ConstantsManager.successUrl,
  //       errorUrl: ConstantsManager.errorUrl,
  //       invoiceAmount: totalPrice,
  //       language: LocalizationManager.getCurrentLocale().languageCode == "ar"
  //           ? ApiLanguage.Arabic
  //           : ApiLanguage.English,
  //       token:
  //           "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
  //     ),
  //   );
  // }

  Future<Either<String, double>> getAccountBalance(String supplierCode) async {
    try {
      final response = await http.get(
        Uri.parse(ApiManager.myFatoorahBaseUrl + EndPoints.getAccountBalance)
            .replace(
          queryParameters: {
            "SupplierCode": supplierCode,
          },
        ),
        headers: {
          'Authorization': ApiManager.myFatoorahToken,
          'Content-Type': 'application/json',
        },
      );
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      return Right(jsonResponse["TotalBalance"]);
    } on DioException catch (e) {
      return Left(e.response.toString());
    }
  }

  Future<Either<String, bool>> transferBalance({
    required double amount,
  }) async {
    try {
      final response = await http.post(
        body: {
          "SupplierCode": ConstantsManager.appUser?.id.toString(),
          "TransferAmount": amount.toString(),
          "TransferType": "push",
          "InternalNotes": ""
        },
        Uri.parse(ApiManager.myFatoorahBaseUrl + EndPoints.transferBalance),
        headers: {
          'Authorization': ApiManager.myFatoorahToken,
        },
      );
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse["IsSuccess"] == "true") {
        return const Right(true);
      }
      return const Right(false);
    } on HttpException catch (e) {
      return Left(e.toString());
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
