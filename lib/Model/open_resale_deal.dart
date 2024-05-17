import 'package:decimal/decimal.dart';

class OpenResaleDeal {
  int _id;
  String _postDate;
  String? _acceptDate;
  Decimal _price;
  String _name;
  String _condition;
  String? _userResaleItemAttrOne;
  String? _userResaleItemAttrTwo;
  String? _userResaleItemAttrThree;
  int _itemType;

  OpenResaleDeal(
      this._id,
      this._postDate,
      this._acceptDate,
      this._price,
      this._name,
      this._condition,
      this._userResaleItemAttrOne,
      this._userResaleItemAttrTwo,
      this._userResaleItemAttrThree,
      this._itemType);

  factory OpenResaleDeal.fromJson(Map<String, dynamic> json) {
    return OpenResaleDeal(
        json["id"],
        json["postDate"],
        json["acceptDate"],
        Decimal.fromJson(json["price"].toString()),
        json["name"],
        json["condition"],
        json["userResaleItemAttrOne"],
        json["userResaleItemAttrTwo"],
        json["userResaleItemAttrThree"],
        json["itemType"]);
  }

  get id => _id;

  set id(value) => _id = value;

  get postDate => _postDate;

  set postDate(value) => _postDate = value;

  get acceptDate => _acceptDate;

  set acceptDate(value) => _acceptDate = value;

  get price => _price;

  set price(value) => _price = value;

  get name => _name;

  set name(value) => _name = value;

  get condition => _condition;

  set condition(value) => _condition = value;

  get userResaleItemAttrOne => _userResaleItemAttrOne;

  set userResaleItemAttrOne(value) => _userResaleItemAttrOne = value;

  get userResaleItemAttrTwo => _userResaleItemAttrTwo;

  set userResaleItemAttrTwo(value) => _userResaleItemAttrTwo = value;

  get userResaleItemAttrThree => _userResaleItemAttrThree;

  set userResaleItemAttrThree(value) => _userResaleItemAttrThree = value;

  get itemType => _itemType;

  set itemType(value) => _itemType = value;

  String getAttrs() {
    String attrs = "\n$condition\n\n";
    userResaleItemAttrOne != null ? attrs = "${attrs + userResaleItemAttrOne}\n\n" : null;
    userResaleItemAttrTwo != null ? attrs = "${attrs + userResaleItemAttrTwo}\n\n" : null;
    userResaleItemAttrThree != null ? attrs = "${attrs + userResaleItemAttrThree}\n\n" : null;
    attrs = "$attrs\$$price";
    return attrs;
  }
}
