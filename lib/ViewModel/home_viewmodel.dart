import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';

class HomeViewModel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  late final NavigationService _navigationService =
      _getIt.get<NavigationService>();

  void displayOpenTradeDealList(int id) {
    _navigationService.displayOpenTradeDealList(id);
  }

  void displayOpenResaleDealList(int id) {
    _navigationService.displayOpenResaleDealList(id);
  }

  Future<List<String>> collectibleNames() async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectibleNames(token!, false);
  }
}
