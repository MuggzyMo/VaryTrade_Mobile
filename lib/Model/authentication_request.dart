class AuthenticationRequest {
  String _email;
  String _password;

  AuthenticationRequest(this._email, this._password);

  set email(email) => _email = email;

  set password(password) => _password = password;

  get email => _email;

  get password => _password;

}
