import 'dart:developer';

import 'package:app/ApiServices/api_services.dart';

class DummyRepo {
  static Future dummyData(
      {Map<String, dynamic>? body, List<String?>? images}) async {
    return await ApiService.postMultipart(
            'http://192.168.1.11:9000/dummy_api', body!, images!,
            imagePathName: 'images')
        .then((value) {
      log(value.toString());

      return value;
    });
  }
}
