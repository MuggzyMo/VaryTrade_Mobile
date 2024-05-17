extension ExtString on String {
  bool validatePassword(String confirm) {
    return _validatePasswordSize() &&
        _validatePasswordFormat() &&
        _validatePasswordAndConfirmPasswordMatch(this, confirm);
  }

  bool validateCurrentPassword() {
    return _validatePasswordSize() &&
    _validateAddressFormat();
  }

  bool validateUserName() {
    return _validateUserNameSize() && _validateUserNameFormat();
  }

  bool validatePhoneNum() {
    final phoneNumRegex = RegExp(r"[0-9]{3}[0-9]{3}[0-9]{4}");
    return phoneNumRegex.hasMatch(this);
  }

  bool validateEmail() {
    return length <= 100 && length >= 1;
  }

  bool validateAddress() {
    return _validateAddressSize() && _validateAddressFormat();
  }

  bool validateZipCode() {
    final zipCodeRegex = RegExp(r"^\d{5}$");
    return zipCodeRegex.hasMatch(this);
  }

  bool validateCity() {
    return _validateCitySize() && _validateCityFormat();
  }

  bool validateFirstName() {
    return _validateFirstNameSize() && _validateFirstNameFormat();
  }

  bool validateLastName() {
    return _validateLastNameSize() && _validateLastNameFormat();
  }

  bool _validateFirstNameSize() {
    return length <= 100 && length >= 1;
  }

  bool _validateFirstNameFormat() {
    final firstNameRegex = RegExp(r"^[a-zA-Z ]+$");
    return firstNameRegex.hasMatch(this);
  }

  bool _validateLastNameSize() {
    return length <= 100 && length >= 1;
  }

  bool _validateLastNameFormat() {
    final lastNameRegex = RegExp(r"^[a-zA-Z ]+$");
    return lastNameRegex.hasMatch(this);
  }

  bool _validateCitySize() {
    return length <= 100 && length >= 1;
  }

  bool _validateCityFormat() {
    final cityRegex = RegExp(r"^[a-zA-Z ]+$");
    return cityRegex.hasMatch(this);
  }

  bool _validateAddressFormat() {
    final addressRegex = RegExp(r"^[0-9a-zA-Z ]+$");
    return addressRegex.hasMatch(this);
  }

  bool _validateAddressSize() {
    return length <= 100 && length >= 1;
  }

  bool _validatePasswordFormat() {
    final passwordRegex = RegExp(r"^[0-9a-zA-Z+!_]+$");
    return passwordRegex.hasMatch(this);
  }

  bool _validatePasswordSize() {
    return length <= 100 && length >= 10;
  }

  bool _validateUserNameSize() {
    return length <= 100 && length >= 5;
  }

  bool _validateUserNameFormat() {
    final userNameRegex = RegExp(r"^[0-9a-zA-Z+!_]+$");
    return userNameRegex.hasMatch(this);
  }

  bool _validatePasswordAndConfirmPasswordMatch(
      String password, String confirmPassword) {
    return password == confirmPassword;
  }
}
