class AuthenticationResponse {
  String _token;
  String? _userName;
  int _statusCode;

  AuthenticationResponse(this._token, this._userName, this._statusCode);

  factory AuthenticationResponse.fromJson(
      Map<String, dynamic> json, int statusCode) {
    return AuthenticationResponse(json["token"], json["username"], statusCode);
  }

  set token(token) => _token = token;

  set userName(userName) => _userName = userName;

  set statusCode(statusCode) => _statusCode = statusCode;

  get statusCode => _statusCode;

  get token => _token;

  get userName => _userName;
}
