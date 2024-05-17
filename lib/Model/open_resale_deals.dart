import 'package:varytrade_flutter/Model/open_resale_deal.dart';

class OpenResaleDeals {
  List<String>? _posterUserNames;
  List<String>? _accepterUserNames;
  List<OpenResaleDeal> _openResaleDeals;
  List<String> _userResaleItemAttrsOne;
  List<String> _userResaleItemAttrsTwo;
  List<String> _userResaleItemAttrsThree;
  List<String> _userResaleItemAttrs;
  String _collectibleType;

  OpenResaleDeals(
      this._posterUserNames,
      this._accepterUserNames,
      this._openResaleDeals,
      this._userResaleItemAttrsOne,
      this._userResaleItemAttrsTwo,
      this._userResaleItemAttrsThree,
      this._userResaleItemAttrs,
      this._collectibleType);

  get posterUserNames => _posterUserNames;

  set posterUserNames(value) => _posterUserNames = value;

  get accepterUserNames => _accepterUserNames;

  set accepterUserNames(value) => _accepterUserNames = value;

  get openResaleDeals => _openResaleDeals;

  set openResaleDeals(value) => _openResaleDeals = value;

  get userResaleItemAttrsOne => _userResaleItemAttrsOne;

  set userResaleItemAttrsOne(value) => _userResaleItemAttrsOne = value;

  get userResaleItemAttrsTwo => _userResaleItemAttrsTwo;

  set userResaleItemAttrsTwo(value) => _userResaleItemAttrsTwo = value;

  get userResaleItemAttrsThree => _userResaleItemAttrsThree;

  set userResaleItemAttrsThree(value) => _userResaleItemAttrsThree = value;

  get userResaleItemAttrs => _userResaleItemAttrs;

  set userResaleItemAttrs(value) => _userResaleItemAttrs = value;

  get collectibleType => _collectibleType;

  set collectibleType(value) => _collectibleType = value;
}
