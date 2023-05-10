import 'package:dio/dio.dart';
import 'package:movie_theater/initialize.dart';
import 'package:movie_theater/models/response_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:movie_theater/repositories/local_repository.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Authentication._();
  static final Authentication _shared = Authentication._();
  factory Authentication.instance() => _shared;

  String? accesToken;

  static const secretKey = "2jukqvNnhunHWMBRRVcZ9ZQ9";

  Future<bool> authorize() async {
    if (accesToken != null) {
      return true;
    } else {
      final sharedToken = sl<LocalRepository>().accessToken;
      if (sharedToken != null && sharedToken.isNotEmpty) {
        accesToken = sharedToken;
        return true;
      }
      final dio = Dio(BaseOptions(baseUrl: "https://fs-mt.qwerty123.tech"));
      final sessionTokenResponse = await dio.post("/api/auth/session");
      final sessionTokenData =
          ResponseModel.fromJson(sessionTokenResponse.data);
      if (sessionTokenData.success) {
        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        final String sessionToken =
            (sessionTokenData.data as Map<String, dynamic>)["sessionToken"] ??
                "";
        final bytes = utf8.encode(sessionToken + secretKey);
        final siganture = sha256.convert(bytes).toString();
        final accesTokenResponse = await dio.post(
          "/api/auth/token",
          data: {
            "sessionToken": sessionToken,
            "signature": siganture,
            "device_id": androidInfo.id,
          },
        );
        final accesTokenData = ResponseModel.fromJson(accesTokenResponse.data);
        if (accesTokenData.success) {
          accesToken =
              (accesTokenData.data as Map<String, dynamic>)["sessionToken"];
          sl<LocalRepository>().accessToken = accesToken;
          return true;
        }
      }
      return false;
    }
  }
}
