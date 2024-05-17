import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';

class ContactViewModel {
  final GetIt _getIt = GetIt.instance;
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final NavigationService _navigationService =
      _getIt.get<NavigationService>();

  Future<Company> companyInfo() {
    return _miscService.retrieveCompanyInfo();
  }

  void displayHome() {
    _navigationService.displayHome();
  }
}
