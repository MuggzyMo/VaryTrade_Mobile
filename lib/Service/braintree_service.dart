import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Service/refresh_jwt_service_util.dart';
import 'package:varytrade_flutter/general_config.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

import 'package:varytrade_flutter/http_code.dart';

class BraintreeService {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;
  late final RefreshJwtServiceUtil _serviceUtil;

  BraintreeService() {
    _config = _getIt.get<Config>();
    _serviceUtil = _getIt.get<RefreshJwtServiceUtil>();
  }

  Future<String> retrieveBraintreeToken(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/braintree/token'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveBraintreeToken(_serviceUtil.refreshJwtToken()!, true);
    } else {
      developer.log(response.body);
      return response.body;
    }
  }
}