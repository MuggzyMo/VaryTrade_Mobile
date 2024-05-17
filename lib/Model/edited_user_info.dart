class EditedUserInfo {
  String? _email;
  String _zipCode;
  String _state;
  String _city;
  String _address;
  String _phoneNum;
  String _firstName;
  String _middleName;
  String _lastName;

  EditedUserInfo(this._email, this._zipCode, this._state, this._city, this._address,
      this._phoneNum, this._firstName, this._middleName, this._lastName);

  set email(email) => _email = email;

  set zipCode(zipCode) => _zipCode = zipCode;

  set state(state) => _state = state;

  set city(city) => _city = city;

  set address(address) => _address = address;

  set phoneNum(phoneNum) => _phoneNum = phoneNum;

  set firstName(firstName) => _firstName = firstName;

  set middleName(middleName) => _middleName = middleName;

  set lastName(lastName) => _lastName = lastName;

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