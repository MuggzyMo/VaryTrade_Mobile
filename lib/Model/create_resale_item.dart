import 'package:decimal/decimal.dart';

class CreateResaleItem {
  Decimal _price;
  String _name;
  String _condition;
  String? _userResaleItemAttrOne;
  String? _userResaleItemAttrTwo;
  String? _userResaleItemAttrThree;

  CreateResaleItem(
      this._price,
      this._name,
      this._condition,
      this._userResaleItemAttrOne,
      this._userResaleItemAttrTwo,
      this._userResaleItemAttrThree,);

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
}
