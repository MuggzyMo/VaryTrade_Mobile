import 'package:varytrade_flutter/Model/company.dart';

abstract class MiscService {
  Future<Company> retrieveCompanyInfo();
   Future<List<String>> retrieveStates();
}