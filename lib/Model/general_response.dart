class GeneralResponse {
  int _statusCode;
  List<String>? _messages;

  GeneralResponse(this._statusCode, this._messages);

  factory GeneralResponse.fromJson(List<String> errors, int statusCode) {
    return GeneralResponse(statusCode, errors);
  }

  get statusCode => _statusCode;

  get errorMessage => _messages;

  set statusCode(statusCode) => _statusCode = statusCode;

  set errorMessage(errorMessage) => _messages = errorMessage;
}
