class PasswordCreation {
  String _password;
  String _confirmPassword;

  PasswordCreation(this._password, this._confirmPassword);

  set password(password) => _password = password;

  set confirmPassword(confirmPassword) => _confirmPassword = confirmPassword;

  get password => _password;

  get confirmPassword => _confirmPassword;
}