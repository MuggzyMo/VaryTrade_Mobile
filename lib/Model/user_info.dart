class UserInfo {
  String _email;
  String _zipCode;
  String _state;
  String _city;
  String _address;
  String _phoneNum;
  String _firstName;
  String _middleName;
  String _lastName;
  String _userName;

  UserInfo(this._email, this._zipCode, this._state, this._city, this._address,
      this._phoneNum, this._firstName, this._middleName, this._lastName, this._userName);

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
        json["email"],
        json["zipCode"],
        json["state"],
        json["city"],
        json["address"],
        json["phoneNum"],
        json["firstName"],
        json["middleName"],
        json["lastName"],
        json["userName"]);
  }

  set userName(userName) => _userName = userName;

  set email(email) => _email = email;

  set zipCode(zipCode) => _zipCode = zipCode;

  set state(state) => _state = state;

  set city(city) => _city = city;

  set address(address) => _address = address;

  set phoneNum(phoneNum) => _phoneNum = phoneNum;

  set firstName(firstName) => _firstName = firstName;

  set middleName(middleName) => _middleName = middleName;

  set lastName(lastName) => _lastName = lastName;

  get userName => _userName;

  get email => _email;

  get zipCode => _zipCode;

  get state => _state;

  get city => _city;

  get address => _address;

  get phoneNum => _phoneNum;

  get firstName => _firstName;

  get middleName => _middleName;

  get lastName => _lastName;
}
