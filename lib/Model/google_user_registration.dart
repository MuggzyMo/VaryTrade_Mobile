class GoogleUserRegistration {
  String _email;
  String _zipCode;
  String _state;
  String _city;
  String _address;
  String _phoneNum;
  String _firstName;
  String? _middleName;
  String _lastName;
  String _userName;
  String _token;

  GoogleUserRegistration(
    this._email,
    this._zipCode,
    this._state,
    this._city,
    this._address,
    this._phoneNum,
    this._firstName,
    this._middleName,
    this._lastName,
    this._userName,
    this._token
  );
  
  set token(token) => _token = token;

  set email(email) => _email = email;

  set zipCode(zipCode) => _zipCode = zipCode;

  set state(state) => _state = state;

  set city(city) => _city = city;

  set address(address) => _address = address;

  set phoneNum(phoneNum) => _phoneNum = phoneNum;

  set firstName(firstName) => _firstName = firstName;

  set middleName(middleName) => _middleName = middleName;

  set lastName(lastName) => _lastName = lastName;

  set userName(userName) => _userName = userName;

  get token => _token;

  get userName => _userName;

  get email => _email;

  get zipCode => _zipCode;

  get state => _state;

  get address => _address;

  get city => _city;

  get phoneNum => _phoneNum;

  get firstName => _firstName;

  get lastName => _lastName;

  get middleName => _middleName;
}
