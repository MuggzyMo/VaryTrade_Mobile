import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/closed_trade_deals.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_trade_deal.dart';
import 'package:varytrade_flutter/Model/open_trade_deals.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class CollectorTradeInfoViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final NavigationService _navigationService =
      _getIt.get<NavigationService>();

  OpenTradeDeals? _openTradeDeals;
  get openTradeDeals => _openTradeDeals;
  set openTradeDeals(openTradeDeals) => _openTradeDeals = openTradeDeals;

  OpenTradeDeal? _selectedOpenTradeDeal;
  get selectedOpenTradeDeal => _selectedOpenTradeDeal;
  set selectedOpenTradeDeal(value) => _selectedOpenTradeDeal = value;

  int? _selectedIndex;
  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => _selectedIndex = value;

  bool _listLoading = true;
  Function()? onListLoadingChanged;
  get listLoading => _listLoading;
  set listLoading(listLoading) => _listLoading = listLoading;

  Future<Company> companyInfo() {
    return _miscService.retrieveCompanyInfo();
  }

  Future<void> deleteOpenTradeDeal() async {
    String? token = await _secureStorage.getJwtToken();
    _tradeService
        .deleteOpenTradeDeal(token!, selectedOpenTradeDeal.id, false)
        .then((value) {
      if (value.statusCode == HttpCode.success) {
        _listLoading = true;
        onListLoadingChanged?.call();
        _navigationService.pop();
        retrieveCollectorOpenTradeDeals(_selectedOpenTradeDeal!.itemType);
      } else {
        _navigationService.displayErrorDialog(
            "Issue Deleting Open Trade", value);
      }
    });
  }

  void displayCollectorOpenTradeDetails(int index) {
    _selectedOpenTradeDeal = _openTradeDeals!.openTradeDeals[index];
    _selectedIndex = index;
    _navigationService.displayCollectorOpenTradeDetails();
  }

  void displayCollectorPendingTradeDetails(int index) {
    _selectedOpenTradeDeal = _openTradeDeals!.openTradeDeals[index];
    _selectedIndex = index;
    _navigationService.displayCollectorPendingTradeDetails();
  }

  void displayCreateTrade(int id) {
    _navigationService.displayCreateTrade(id);
  }

  void displayCollectorClosedTradeDealList(int id) {
    _navigationService.displayCollectorClosedTradeDealList(id);
  }

  void displayCollectorOpenTradeDeals(int id) {
    _navigationService.displayCollectorOpenTradeDealList(id);
  }

  Future<ClosedTradeDeals> retrieveCollectorClosedTradeDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectorClosedTradeDeals(token!, id, false);
  }

  Future<void> retrieveCollectorOpenTradeDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openTradeDeals =
        await _tradeService.retrieveCollectorOpenTradeDeals(token!, id, false);
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  void displayCollectorPendingTradeDealList(int id) {
    _navigationService.displayCollectorPendingTradeDealList(id);
  }

  Future<List<String>> retrieveCollectibleNames() async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectibleNames(token!, false);
  }

  Future<void> retrieveCollectorPendingTradeDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openTradeDeals = await _tradeService.retrieveCollectorPendingTradeDeals(
        token!, id, false);
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  void displayProfile(String username) async {
    String? currentCollectorUsername = await _secureStorage.getUserName();
    if (currentCollectorUsername != username) {
      _navigationService.displayProfile(username);
    } else {
      _navigationService.displayErrorDialog("Profile Lookup Error",
          GeneralResponse(403, ["You cannot view your own profile."]));
    }
  }
}
