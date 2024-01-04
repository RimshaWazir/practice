import 'package:app/Data/AppData/user_data.dart';

class Data with UserData {
  Data._();

  static final Data app = Data._();

  factory Data() {
    return app;
  }

  static const String test = '';
}
