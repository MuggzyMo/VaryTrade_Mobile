import 'package:varytrade_flutter/Model/open_trade_deal.dart';
import 'package:varytrade_flutter/Model/open_trade_item.dart';

class OpenTradeDeals {
  List<String>? _posterUserNames;
  List<String>? _accepterUserNames;
  List<OpenTradeDeal> _openTradeDeals;
  List<List<OpenTradeItem>> _posterTradeItems;
  List<List<OpenTradeItem>>? _accepterTradeItems;
  List<String> _userTradeItemAttrsOne;
  List<String> _userTradeItemAttrsTwo;
  List<String> _userTradeItemAttrsThree;
  List<String> _userTradeItemAttrs;
  String _collectibleType;

  OpenTradeDeals(
      this._posterUserNames,
      this._accepterUserNames,
      this._openTradeDeals,
      this._accepterTradeItems,
      this._posterTradeItems,
      this._userTradeItemAttrsOne,
      this._userTradeItemAttrsTwo,
      this._userTradeItemAttrsThree,
      this._userTradeItemAttrs,
      this._collectibleType);

  get collectibleType => _collectibleType;

  set collectibleType(value) => _collectibleType = value;

  get posterUserNames => _posterUserNames;

  set posterUserNames(value) => _posterUserNames = value;

  get accepterUserNames => _accepterUserNames;

  set accepterUserNames(value) => _accepterUserNames = value;

  get openTradeDeals => _openTradeDeals;

  set openTradeDeals(value) => _openTradeDeals = value;

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
