class GoogleRegistrationResponse {
  String? _userName;
  List<String>? _errorMessage;
  int _statusCode;

  GoogleRegistrationResponse(this._userName, this._errorMessage, this._statusCode);

  factory GoogleRegistrationResponse.fromJson(Map<String, dynamic> json, int statusCode) {
    return GoogleRegistrationResponse(json["username"], json["errorMessage"], statusCode);
  }

  set userName(userName) => _userName = userName;

  set errorMessage(errorMessage) => _errorMessage = errorMessage;

  set statusCode(statusCode) => _statusCode = statusCode;

  get statusCode => _statusCode;

  get userName => _userName;

  get errorMessage => _errorMessage;
}