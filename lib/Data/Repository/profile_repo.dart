import 'dart:developer';

import 'package:app/ApiServices/api_services.dart';

class ProfileRepository {
  static Future<Map<String, dynamic>> updateProfile(
      Map<String, dynamic> body, String? imagePath) async {
    try {
      if (imagePath != null) {
        log(body.entries.toString());

        return await ApiService.putMultiPart(
          'http://192.168.1.8:9000/api/business/update/658ab97cc15c4eb001a0478f',
          body,
          [imagePath],
          imagePathName: 'profileImage',
        );
      } else {
        return await ApiService.put(
          'http://192.168.1.8:9000/api/business/update/658ab97cc15c4eb001a0478f',
          body,
        );
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
