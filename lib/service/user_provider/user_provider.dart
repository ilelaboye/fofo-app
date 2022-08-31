import 'package:flutter/foundation.dart';
import 'package:fofo_app/models/user_model/user_model.dart';

class UserProvider with ChangeNotifier {
  UserModel _user = new UserModel();

  UserModel get user => _user;

  void setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }
}
