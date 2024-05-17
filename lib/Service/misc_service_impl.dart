
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/general_config.dart';
import 'package:varytrade_flutter/http_code.dart';
import '../Model/company.dart';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:http/http.dart' as http;

class MiscServiceImpl implements MiscService {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;

  MiscServiceImpl() {
    _config = _getIt.get<Config>();
  }

  @override
  Future<Company> retrieveCompanyInfo() async {
    String baseUrl = _config.baseUrlPort;
    var response = await http.get(Uri.parse('https://$baseUrl/api/company'));

    if (response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body));
    } else {
      developer.log(response.statusCode.toString());
      throw Exception('Failed to load company info.');
    }
  }

  @override
  Future<List<String>> retrieveStates() async {
    String baseUrl = _config.baseUrl;
    var response = await http.get(Uri.parse('https://$baseUrl:8443/api/states'));

    if (response.statusCode == HttpCode.success) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element);
      }
      return items;
    } else {
      developer.log(response.statusCode.toString());
      throw Exception("Failed to load states.");
    }
  }
}
