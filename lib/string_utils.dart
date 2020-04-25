extension MyString on String {
  String capitalize2() => this[0].toUpperCase() + this.substring(1).toLowerCase();
}

extension MyString2 on String {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1).toLowerCase();
}