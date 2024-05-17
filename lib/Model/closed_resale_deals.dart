import 'package:varytrade_flutter/Model/closed_resale_deal.dart';

class ClosedResaleDeals {
  List<String>? _posterUserNames;
  List<String>? _accepterUserNames;
  List<ClosedResaleDeal> _closedResaleDeals;
  List<String> _userTradeItemAttrsOne;
  List<String> _userTradeItemAttrsTwo;
  List<String> _userTradeItemAttrsThree;
  List<String> _userTradeItemAttrs;
  String _collectibleType;

  ClosedResaleDeals(
      this._posterUserNames,
      this._accepterUserNames,
      this._closedResaleDeals,
      this._userTradeItemAttrsOne,
      this._userTradeItemAttrsTwo,
      this._userTradeItemAttrsThree,
      this._userTradeItemAttrs,
      this._collectibleType);

  get posterUserNames => _posterUserNames;

  set posterUserNames(value) => _posterUserNames = value;

  get accepterUserNames => _accepterUserNames;

  set accepterUserNames(value) => _accepterUserNames = value;

  get closedResaleDeals => _closedResaleDeals;

  set closedResaleDeals(value) => _closedResaleDeals = closedResaleDeals;

  get collectibleType => _collectibleType;

  set collectibleType(value) => _collectibleType = value;

  get userTradeItemAttrsOne => _userTradeItemAttrsOne;

  set userTradeItemAttrsOne(value) => _userTradeItemAttrsOne = value;

  get userTradeItemAttrsTwo => _userTradeItemAttrsTwo;

  set userTradeItemAttrsTwo(value) => _userTradeItemAttrsTwo = value;

  get userTradeItemAttrsThree => _userTradeItemAttrsThree;

  set userTradeItemAttrsThree(value) => _userTradeItemAttrsThree = value;

  get userTradeItemAttrs => _userTradeItemAttrs;

  set userTradeItemAttrs(value) => _userTradeItemAttrs = value;
}