import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/closed_resale_deal.dart';
import 'package:varytrade_flutter/Model/closed_resale_deals.dart';
import 'package:varytrade_flutter/Model/create_resale_item.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_resale_deal.dart';
import 'package:varytrade_flutter/Model/open_resale_deals.dart';
import 'package:varytrade_flutter/Service/resale_service.dart';
import 'package:varytrade_flutter/Service/refresh_jwt_service_util.dart';
import 'package:varytrade_flutter/general_config.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:varytrade_flutter/http_code.dart';

class ResaleServiceImpl implements ResaleService {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;
  late final RefreshJwtServiceUtil _serviceUtil;

  ResaleServiceImpl() {
    _config = _getIt.get<Config>();
    _serviceUtil = _getIt.get<RefreshJwtServiceUtil>();
  }

  @override
  Future<GeneralResponse> acceptResaleDealWithCredit(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse(
          "https://$baseUrlPort/api/resale-deal/open/credit/accept?id=$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return acceptResaleDealWithCredit(token, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> acceptResaleDealWithPayment(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse(
          "https://$baseUrlPort/api/resale-deal/open/payment/accept?id=$id"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return acceptResaleDealWithPayment(token, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> deleteOpenResaleDeal(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse('https://$baseUrlPort/api/your-resale-deals/delete?id=$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return deleteOpenResaleDeal(_serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processCreateResale(String token,
      CreateResaleItem createResaleItem, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/resale-deal/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          "price": createResaleItem.price,
          "name": createResaleItem.name,
          "condition": createResaleItem.condition,
          "userResaleItemAttrOne": createResaleItem.userResaleItemAttrOne,
          "userResaleItemAttrTwo": createResaleItem.userResaleItemAttrTwo,
          "userResaleItemAttrThree": createResaleItem.userResaleItemAttrThree,
          "type": id
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processCreateResale(
          _serviceUtil.refreshJwtToken()!, createResaleItem, id, true);
    } else {
      developer.log(response.body);
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<OpenResaleDeals> retrieveProfileOpenResaleDeals(
      String token, String username, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse(
            'https://$baseUrlPort/api/resale-deal/profile/open?username=$username&type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveProfileOpenResaleDeals(
          _serviceUtil.refreshJwtToken()!, username, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenResaleDeals(
          null,
          null,
          parseJsonIntoOpenResaleDealList(json["openResaleDeals"]),
          List<String>.from(json["userResaleItemAttrsOne"]),
          List<String>.from(json["userResaleItemAttrsTwo"]),
          List<String>.from(json["userResaleItemAttrsThree"]),
          List<String>.from(json["userResaleItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<ClosedResaleDeals> retrieveCollectorClosedResaleDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/your-resale-deals/closed?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorClosedResaleDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return ClosedResaleDeals(
          List<String>.from(json["posterUserNames"]),
          List<String>.from(json["accepterUserNames"]),
          parseJsonIntoClosedResaleDealList(json["closedResaleDeals"]),
          List<String>.from(json["userResaleItemAttrsOne"]),
          List<String>.from(json["userResaleItemAttrsTwo"]),
          List<String>.from(json["userResaleItemAttrsThree"]),
          List<String>.from(json["userResaleItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenResaleDeals> retrieveCollectorPendingResaleDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse(
            'https://$baseUrlPort/api/your-resale-deals/pending?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorPendingResaleDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenResaleDeals(
          List<String>.from(json["posterUserNames"]),
          List<String>.from(json["accepterUserNames"]),
          parseJsonIntoOpenResaleDealList(json["openResaleDeals"]),
          List<String>.from(json["userResaleItemAttrsOne"]),
          List<String>.from(json["userResaleItemAttrsTwo"]),
          List<String>.from(json["userResaleItemAttrsThree"]),
          List<String>.from(json["userResaleItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenResaleDeals> retrieveCollectorOpenResaleDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/your-resale-deals/open?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveCollectorOpenResaleDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenResaleDeals(
          null,
          null,
          parseJsonIntoOpenResaleDealList(json["openResaleDeals"]),
          List<String>.from(json["userResaleItemAttrsOne"]),
          List<String>.from(json["userResaleItemAttrsTwo"]),
          List<String>.from(json["userResaleItemAttrsThree"]),
          List<String>.from(json["userResaleItemAttrs"]),
          json["collectibleType"]);
    }
  }

  @override
  Future<OpenResaleDeals> retrieveAcceptableOpenResaleDeals(
      String token, int id, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/resale-deal/open?type=$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveAcceptableOpenResaleDeals(
          _serviceUtil.refreshJwtToken()!, id, true);
    } else {
      developer.log(response.body);
      Map<String, dynamic> json = jsonDecode(response.body);
      return OpenResaleDeals(
          List<String>.from(json["posterUserNames"]),
          null,
          parseJsonIntoOpenResaleDealList(json["openResaleDeals"]),
          List<String>.from(json["userResaleItemAttrsOne"]),
          List<String>.from(json["userResaleItemAttrsTwo"]),
          List<String>.from(json["userResaleItemAttrsThree"]),
          List<String>.from(json["userResaleItemAttrs"]),
          json["collectibleType"]);
    }
  }

  List<ClosedResaleDeal> parseJsonIntoClosedResaleDealList(var json) {
    List<ClosedResaleDeal> closedResaleDeals = [];
    for (var closedResale in json) {
      closedResaleDeals.add(ClosedResaleDeal.fromJson(closedResale));
    }
    return closedResaleDeals;
  }

  List<OpenResaleDeal> parseJsonIntoOpenResaleDealList(var json) {
    List<OpenResaleDeal> openResaleDeals = [];
    for (var openResale in json) {
      openResaleDeals.add(OpenResaleDeal.fromJson(openResale));
    }
    return openResaleDeals;
  }
}
