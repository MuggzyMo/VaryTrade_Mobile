import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/closed_trade_deal.dart';
import 'package:varytrade_flutter/Model/closed_trade_deals.dart';
import 'package:varytrade_flutter/Model/closed_trade_item.dart';
import 'package:varytrade_flutter/Model/create_trade_item.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_trade_deal.dart';
import 'package:varytrade_flutter/Model/open_trade_item.dart';
import 'package:varytrade_flutter/Model/open_trade_deals.dart';
import 'dart:convert';
import 'package:varytrade_flutter/Service/refresh_jwt_service_util.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:http/http.dart' as http;
import 'package:varytrade_flutter/general_config.dart';
import 'dart:developer' as developer;

import 'package:varytrade_flutter/http_code.dart';

class TradeServiceImpl implements TradeService {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;
  late final RefreshJwtServiceUtil _serviceUtil;

  TradeServiceImpl() {
    _config = _getIt.get<Config>();
    _serviceUtil = _getIt.get<RefreshJwtServiceUtil>();
  }

  @override
  Future<GeneralResponse> acceptTradeDealWithPayment(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse(
          "https://$baseUrlPort/api/trade-deal/open/payment/accept?id=$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return acceptTradeDealWithPayment(token, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> acceptTradeDealWithCredit(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse(
          "https://$baseUrlPort/api/trade-deal/open/credit/accept?id=$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return acceptTradeDealWithCredit(token, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> deleteOpenTradeDeal(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse('https://$baseUrlPort/api/your-trade-deals/delete?id=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return deleteOpenTradeDeal(_serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processCreateTrade(
      String token,
      List<CreateTradeItem> posterTradeItems,
      List<CreateTradeItem> accepterTradeItems,
      int id,
      bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/trade-deal/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          "posterTradeItems": _convertCreateTradeItemListToJsonList(
              _assignIdToTradeItems(posterTradeItems)),
          "accepterTradeItems": _convertCreateTradeItemListToJsonList(
              _assignIdToTradeItems(accepterTradeItems)),
          "type": id
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processCreateTrade(_serviceUtil.refreshJwtToken()!,
          posterTradeItems, accepterTradeItems, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<List<String>> retrieveTradeItemAttributeNames(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/attributes/names?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveTradeItemAttributeNames(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveTradeItemAttributeOneValues(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/attributes-one?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveTradeItemAttributeOneValues(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveTradeItemAttributeThreeValues(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/attributes-three?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveTradeItemAttributeThreeValues(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveTradeItemAttributeTwoValues(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/attributes-two?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveTradeItemAttributeTwoValues(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveConditions(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/collectible/conditions?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveConditions(_serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveTradeItems(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/trade-deal/collectibles?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveTradeItems(_serviceUtil.refreshJwtToken()!, id, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<OpenTradeDeals> retrieveProfileOpenTradeDeals(
      String token, String username, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse(
            'https://$baseUrlPort/api/trade-deal/profile/open?username=$username&type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveProfileOpenTradeDeals(
          _serviceUtil.refreshJwtToken()!, username, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenTradeDeals(
          null,
          null,
          _parseJsonIntoOpenTradeDealList(json["openTradeDeals"]),
          _parseJsonIntoOpenTradeItems(json["accepterTradeItems"]),
          _parseJsonIntoOpenTradeItems(json["posterTradeItems"]),
          List<String>.from(json["userTradeItemAttrsOne"]),
          List<String>.from(json["userTradeItemAttrsTwo"]),
          List<String>.from(json["userTradeItemAttrsThree"]),
          List<String>.from(json["userTradeItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<ClosedTradeDeals> retrieveCollectorClosedTradeDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/your-trade-deals/closed?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorClosedTradeDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return ClosedTradeDeals(
          List<String>.from(json["posterUserNames"]),
          List<String>.from(json["accepterUserNames"]),
          _parseJsonIntoClosedTradeDealList(json["closedTradeDeals"]),
          _parseJsonIntoClosedTradeItems(json["accepterTradeItems"]),
          _parseJsonIntoClosedTradeItems(json["posterTradeItems"]),
          List<String>.from(json["userTradeItemAttrsOne"]),
          List<String>.from(json["userTradeItemAttrsTwo"]),
          List<String>.from(json["userTradeItemAttrsThree"]),
          List<String>.from(json["userTradeItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenTradeDeals> retrieveCollectorOpenTradeDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/your-trade-deals/open?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorOpenTradeDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenTradeDeals(
          null,
          null,
          _parseJsonIntoOpenTradeDealList(json["openTradeDeals"]),
          _parseJsonIntoOpenTradeItems(json["accepterTradeItems"]),
          _parseJsonIntoOpenTradeItems(json["posterTradeItems"]),
          List<String>.from(json["userTradeItemAttrsOne"]),
          List<String>.from(json["userTradeItemAttrsTwo"]),
          List<String>.from(json["userTradeItemAttrsThree"]),
          List<String>.from(json["userTradeItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenTradeDeals> retrieveCollectorPendingTradeDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/your-trade-deals/pending?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorPendingTradeDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenTradeDeals(
          List<String>.from(json["posterUserNames"]),
          List<String>.from(json["accepterUserNames"]),
          _parseJsonIntoOpenTradeDealList(json["openTradeDeals"]),
          _parseJsonIntoOpenTradeItems(json["accepterTradeItems"]),
          _parseJsonIntoOpenTradeItems(json["posterTradeItems"]),
          List<String>.from(json["userTradeItemAttrsOne"]),
          List<String>.from(json["userTradeItemAttrsTwo"]),
          List<String>.from(json["userTradeItemAttrsThree"]),
          List<String>.from(json["userTradeItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenTradeDeals> retrieveAcceptableOpenTradeDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/trade-deal/open?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveAcceptableOpenTradeDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenTradeDeals(
          List<String>.from(json["posterUserNames"]),
          null,
          _parseJsonIntoOpenTradeDealList(json["openTradeDeals"]),
          _parseJsonIntoOpenTradeItems(json["accepterTradeItems"]),
          _parseJsonIntoOpenTradeItems(json["posterTradeItems"]), 
          List<String>.from(json["userTradeItemAttrsOne"]),
          List<String>.from(json["userTradeItemAttrsTwo"]),
          List<String>.from(json["userTradeItemAttrsThree"]),
          List<String>.from(json["userTradeItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<List<String>> retrieveCollectibleNames(
      String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http
        .get(Uri.parse('https://$baseUrlPort/api/collectible/types'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectibleNames(_serviceUtil.refreshJwtToken()!, true);
    } else {
      return List<String>.from(jsonDecode(response.body));
    }
  }

  List<List<OpenTradeItem>> _parseJsonIntoOpenTradeItems(var json) {
    List<List<OpenTradeItem>> tradeItems = [];
    for (var openTrade in json) {
      List<OpenTradeItem> currentItems = [];
      for (var item in openTrade) {
        OpenTradeItem openTradeItem = OpenTradeItem.fromJson(item);
        currentItems.add(openTradeItem);
      }
      tradeItems.add(currentItems);
    }
    return tradeItems;
  }

  List<List<ClosedTradeItem>> _parseJsonIntoClosedTradeItems(var json) {
    List<List<ClosedTradeItem>> tradeItems = [];
    for (var closedTrade in json) {
      List<ClosedTradeItem> currentItems = [];
      for (var item in closedTrade) {
        ClosedTradeItem closedTradeItem = ClosedTradeItem.fromJson(item);
        currentItems.add(closedTradeItem);
      }
      tradeItems.add(currentItems);
    }
    return tradeItems;
  }

  List<ClosedTradeDeal> _parseJsonIntoClosedTradeDealList(var json) {
    List<ClosedTradeDeal> closedTradeDeals = [];
    for (var closedTrade in json) {
      closedTradeDeals.add(ClosedTradeDeal.fromJson(closedTrade));
    }
    return closedTradeDeals;
  }

  List<OpenTradeDeal> _parseJsonIntoOpenTradeDealList(var json) {
    List<OpenTradeDeal> openTradeDeals = [];
    for (var openTrade in json) {
      openTradeDeals.add(OpenTradeDeal.fromJson(openTrade));
    }
    return openTradeDeals;
  }

  List<CreateTradeItem> _assignIdToTradeItems(
      List<CreateTradeItem> tradeItems) {
    for (int i = 0; i < tradeItems.length; i++) {
      tradeItems[i].id = i + 1;
    }
    return tradeItems;
  }

  List<Map<String, dynamic>> _convertCreateTradeItemListToJsonList(
      List<CreateTradeItem> tradeItems) {
    List<Map<String, dynamic>> json =
        List<Map<String, dynamic>>.empty(growable: true);
    for (int i = 0; i < tradeItems.length; i++) {
      json.add(tradeItems[i].toJson());
    }
    return json;
  }
}
