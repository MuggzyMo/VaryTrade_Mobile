import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/user_service.dart';

class ForgotPasswordViewModel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  Future<Company> companyInfo() {
    return _miscService.retrieveCompanyInfo();
  }

  void processForgotPasswordRequest(
    String email,
  ) {
    _userService.processForgotPasswordRequest(email);
    _navigation.displayLogin();
  }
}
