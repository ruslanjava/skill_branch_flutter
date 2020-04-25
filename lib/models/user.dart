import '../string_util.dart';

enum LoginType { email, phone }

class User with UserUtils {

  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  List<User> friends = <User>[];

  User._({String firstName, String lastName, String phone, String email}) :
        _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone != null && email != null) {
      return User._(
          firstName: _getFirstName(name),
          lastName: _getLastName(name),
          phone: checkPhone(phone),
          email: checkEmail(email)
      );
    }
    if (email != null) {
      return User._(
          firstName: _getFirstName(name),
          lastName: _getLastName(name),
          phone: null,
          email: checkEmail(email)
      );
    }
    if (phone != null) {
      return User._(
          firstName: _getFirstName(name),
          lastName: _getLastName(name),
          phone: checkPhone(phone),
          email: null
      );
    }

    throw Exception("Phone and email are empty");
  }

  factory User.withPhone({String name, String phone}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone.isEmpty) throw Exception("Phone or email is empty");
    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: checkPhone(phone),
        email: null
    );
  }

  factory User.withEmail({String name, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (email.isEmpty) throw Exception("Email is empty");
    return User._(
        firstName: _getFirstName(name),
        lastName: _getLastName(name),
        phone: null,
        email: checkEmail(email)
    );
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => "${capitalize(_firstName)} ${capitalize(_lastName)}";

  static String _getLastName(String userName) => userName.split(" ").last;
  static String _getFirstName(String userName) => userName.split(" ").first;

  static String checkPhone(String phone) {
    String pattern = r"^(?:[+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");
    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    String pattern = "^([a-z0-9_-]+\\.)*[a-z0-9_-]+@[a-z0-9_-]+(\\.[a-z0-9_-]+)*\\.[a-z]{2,6}\$";

    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    } else if (!RegExp(pattern).hasMatch(email)) {
      throw Exception("Enter a valid email");
    }

    return email;
  }

  @override
  bool operator ==(Object object) {
    if (object == null) {
      return false;
    }
    if (object is User) {
      return _firstName == object._firstName &&
          _lastName == object._lastName &&
          (phone == object.phone || email == object.email);
    }
    return false;
  }

  void addFriend(Iterable<User> newFriends) {
    friends.addAll(newFriends);
  }
  
  void removeFriend(User user) {
    friends.remove(user);
  }

  String get userInfo => """
      name: $name
      email: $email
      firstName: $_firstName
      lastName: $_lastName
      friends: ${friends.toList()}  
  """;

  @override
  String toString() {
    return """
      name: $name
      email: $email
      friends: ${friends.toList()}
    """;
  }

}