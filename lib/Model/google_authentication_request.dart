class GoogleAuthenticationRequest {
  String _email;
  String _token;

  GoogleAuthenticationRequest(this._email, this._token);

  set email(email) => _email = email;

  set token(token) => _token = token;

  get email => _email;

  get token => _token;
}
