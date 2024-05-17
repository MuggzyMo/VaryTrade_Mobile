import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/payout.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/user_service.dart';

class PayoutListViewModel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();

  Future<List<Payout>> retrievePayouts() async {
    String? token = await _secureStorage.getJwtToken();
    return _userService.retrievePayouts(token!, false);
  }
}