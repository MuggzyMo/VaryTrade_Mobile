import 'package:varytrade_flutter/Model/closed_trade_deal.dart';
import 'package:varytrade_flutter/Model/closed_trade_item.dart';

class ClosedTradeDeals {
  List<String>? _posterUserNames;
  List<String>? _accepterUserNames;
  List<ClosedTradeDeal> _closedTradeDeals;
  List<List<ClosedTradeItem>> _posterTradeItems;
  List<List<ClosedTradeItem>>? _accepterTradeItems;
  List<String> _userTradeItemAttrsOne;
  List<String> _userTradeItemAttrsTwo;
  List<String> _userTradeItemAttrsThree;
  List<String> _userTradeItemAttrs;
  String _collectibleType;

  ClosedTradeDeals(
      this._posterUserNames,
      this._accepterUserNames,
      this._closedTradeDeals,
      this._accepterTradeItems,
      this._posterTradeItems,
      this._userTradeItemAttrsOne,
      this._userTradeItemAttrsTwo,
      this._userTradeItemAttrsThree,
      this._userTradeItemAttrs,
      this._collectibleType);

  get posterUserNames => _posterUserNames;

  set posterUserNames(value) => _posterUserNames = value;

  get accepterUserNames => _accepterUserNames;

  set accepterUserNames(value) => _accepterUserNames = value;

  get collectibleType => _collectibleType;

  set collectibleType(value) => _collectibleType = value;

  get closedTradeDeals => _closedTradeDeals;

  set closedTradeDeals(value) => _closedTradeDeals = value;

  get accepterTradeItems => _accepterTradeItems;

  set accepterTradeItems(value) => _accepterTradeItems = value;

  get posterTradeItems => _posterTradeItems;

  set posterTradeItems(value) => _posterTradeItems = value;

  get userTradeItemAttrsOne => _userTradeItemAttrsOne;

  set userTradeItemAttrsOne(value) => _userTradeItemAttrsOne = value;

  get userTradeItemAttrsTwo => _userTradeItemAttrsTwo;

  set userTradeItemAttrsTwo(value) => _userTradeItemAttrsTwo = value;

  get userTradeItemAttrsThree => _userTradeItemAttrsThree;

  set userTradeItemAttrsThree(value) => _userTradeItemAttrsThree = value;

  get userTradeItemAttrs => _userTradeItemAttrs;

  set userTradeItemAttrs(value) => _userTradeItemAttrs = value;
}