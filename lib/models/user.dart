import '../string_utils.dart';

enum LoginType { email, phone }

class User {
  String email;
  String phone;

  String _lastName;
  String _firstName;
  LoginType _type;

  User._({String firstName, String lastName, String phone, String email}) :
        _firstName = firstName,
        _lastName = lastName,
        this.phone = phone,
        this.email = email {
    print("User is created");
    _type = email != null ? LoginType.email : LoginType.phone;
  }

  factory User({String name, String phone, String email}) {
    if (name.isEmpty) throw Exception("User name is empty");
    if (phone.isEmpty || email.isEmpty) throw Exception("Phone or email is empty");
    return User._(
      firstName: _getFirstName(name),
      lastName: _getLastName(name),
      phone: checkPhone(phone),
      email: checkEmail(email)
    );
  }

  String get login {
    if (_type == LoginType.phone) return phone;
    return email;
  }

  String get name => _firstName.capitalize() + " " + _lastName.capitalize();

  static String _getLastName(String userName) => userName.split(" ").last;
  static String _getFirstName(String userName) => userName.split(" ").first;

  static String checkPhone(String phone) {
    String pattern = r"^(?:+0])?[0-9]{11}";
    phone = phone.replaceAll(RegExp("[^+\\d]"), "");
    if (phone == null || phone.isEmpty) {
      throw Exception("Enter don't empty phone number");
    } else if (!RegExp(pattern).hasMatch(phone)) {
      throw Exception("Enter a valid phone number starting with a + and containing 11 digits");
    }
    return phone;
  }

  static String checkEmail(String email) {
    // String pattern = r"^(?:+0])?[0-9]{11}";
    // phone = phone.replaceAll(RegExp("[^+\\d]"), "");
    if (email == null || email.isEmpty) {
      throw Exception("Enter don't empty email");
    }
    return email;
  }

}