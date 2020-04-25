
import 'models/user.dart';

class UserHolder {
  Map<String, User> users = {};

  void registerUser(String name, String phone, String email) {
    User user = User(name: name, phone: phone, email: email);

    if (users.containsKey(user.login)) {
      throw Exception('A user with this name already exists');
    }

    users[user.login] = user;
  }

  User getUserByLogin(String login) {
    return users[login];
  }

  User registerUserByPhone(String fullName, String phone) {
    User user = User.withPhone(name: fullName, phone: phone);

    if (users.containsKey(user.login)) {
      throw Exception('A user with this phone already exists');
    }

    users[user.login] = user;
    return user;
  }

  User registerUserByEmail(String fullName, String email) {
    User user = User.withEmail(name: fullName, email: email);

    if (users.containsKey(user.login)) {
      throw Exception('A user with this email already exists');
    }

    users[user.login] = user;
    return user;
  }

  void setFriends(String login, List<User> friends) {
    User user = users[login];
    user.friends = friends;
  }

  User findUserInFriends(String login, User friendToFind) {
    User user = users[login];
    for (var friend in user.friends) {
      if (friend == friendToFind) {
        return friend;
      }
    }
    throw Exception("${user.login} is not a friend of the login");
  }

  List<User> importUsers(List<String> listString) {
    return listString.map((s) {
      List<String> list = s.split(";");
      var name = list[0].trim();
      var email = list[1].trim();
      var phone = list[2].trim();
      return User(name: name, email: email, phone: phone);
    }).toList();
  }

}