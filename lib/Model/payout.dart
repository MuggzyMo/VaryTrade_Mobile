class Payout {
  String _id;
  String _email;
  String _amount;
  String _date;

  Payout(this._id, this._email, this._amount, this._date);

  factory Payout.fromJson(Map<String, dynamic> json) {
    return Payout(json["id"], json["email"], json["amount"].toString(), json["createdDate"]);
  }

  set email(email) => _email = email;
  set id(id) => _id = id;
  set amount(amount) => _amount = amount;
  set date(date) => _date = date;

  get email => _email;
  get id => _id;
  get amount => _amount;
  get date => _date;

}