import 'package:clone_olx/models/user.dart';
import 'package:clone_olx/repository/parse_errors.dart';
import 'package:clone_olx/repository/table_key.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class UserRespository {
  Future<User> signup(User user) async {
    final parseUser = ParseUser(user.email, user.password, user.email);

    parseUser.set<String?>(keyUserName, user.name);
    parseUser.set<String?>(keyUserPhone, user.phone);
    parseUser.set(keyUserType, user.type.index);

    final response = await parseUser.signUp();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      String error = ParseErrors.getDescription(response.error!.code)!;
      return Future.error(error);
    }
  }

  User mapParseToUser(ParseUser parseUser) {
    return User(
      name: parseUser.get(keyUserName),
      email: parseUser.get(keyUserEmail),
      phone: parseUser.get(keyUserPhone),
      id: parseUser.objectId,
      type: UserType.values[parseUser.get(keyUserType)],
      createdAt: parseUser.get(keyUserCreatedAt),
    );
  }

  Future<User> loginWithEmail(String? email, String? password) async {
    final ParseUser parseUser = ParseUser(email, password, null);

    final response = await parseUser.login();

    if (response.success) {
      return mapParseToUser(response.result);
    } else {
      print(response.error!.code);
      String error = ParseErrors.getDescription(response.error!.code)!;
      return Future.error(error);
    }
  }

  currrentUser() async {
    final parseUser = await ParseUser.currentUser();
    if (parseUser != null) {
      final response = await ParseUser.getCurrentUserFromServer(
          parseUser.sessionToken.toString());
      if(response!.success){
        return mapParseToUser(response.result);
      } else{
        await parseUser.logout();
      }
    } else {
      return null;
    }
  }
}
