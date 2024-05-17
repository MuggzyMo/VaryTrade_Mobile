class Company {
  String _name;
  String _email;
  String _zipCode;
  String _state;
  String _city;
  String _address;
  String _phoneNum;

  Company(this._name, this._email, this._zipCode, this._state, this._city,
      this._address, this._phoneNum);

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(json["name"], json["email"], json["zipCode"], json["state"],
        json["city"], json["address"], json["phoneNum"]);
  }

  set phoneNum(phoneNum) => _phoneNum = phoneNum;

  set name(name) => _name = name;

  set email(email) => _email = email;

  set zipCode(zipCode) => _zipCode = zipCode;

  set state(state) => _state = state;

  set city(city) => _city = city;

  set address(address) => _address = address;

  get name => _name;

  get email => _email;

  get zipCode => _zipCode;

  get state => _state;

  get city => _city;

  get address => _address;

  get phoneNum => _phoneNum;
}
