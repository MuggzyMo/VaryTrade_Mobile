import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/closed_resale_deals.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_resale_deal.dart';
import 'package:varytrade_flutter/Model/open_resale_deals.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/resale_service.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class CollectorResaleInfoViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final ResaleService _resaleService = _getIt.get<ResaleService>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final NavigationService _navigationService =
      _getIt.get<NavigationService>();

  OpenResaleDeals? _openResaleDeals;
  get openResaleDeals => _openResaleDeals;
  set openResaleDeals(openResaleDeals) => _openResaleDeals = openResaleDeals;

  OpenResaleDeal? _selectedOpenResaleDeal;
  get selectedOpenResaleDeal => _selectedOpenResaleDeal;
  set selectedOpenResaleDeal(value) => _selectedOpenResaleDeal = value;

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

  Future<void> deleteOpenResaleDeal() async {
    String? token = await _secureStorage.getJwtToken();
    _resaleService
        .deleteOpenResaleDeal(token!, selectedOpenResaleDeal.id, false)
        .then((value) {
      if (value.statusCode == HttpCode.success) {
        _listLoading = true;
        onListLoadingChanged?.call();
        _navigationService.pop();
        retrieveCollectorOpenResaleDeals(_selectedOpenResaleDeal!.itemType);
      } else {
        _navigationService.displayErrorDialog(
            "Issue Deleting Open Resale", value);
      }
    });
  }

  void displayCreateResale(int id) {
    _navigationService.displayCreateResale(id);
  }

  void displayCollectorOpenResaleDetails(int index) {
    _selectedOpenResaleDeal = _openResaleDeals!.openResaleDeals[index];
    _selectedIndex = index;
    _navigationService.displayCollectorOpenResaleDetails();
  }

  void displayCollectorPendingResaleDetails(int index) {
    _selectedOpenResaleDeal = _openResaleDeals!.openResaleDeals[index];
    _selectedIndex = index;
    _navigationService.displayCollectorPendingResaleDetails();
  }

  void displayCollectorClosedResaleDealList(int id) async {
    _navigationService.displayCollectorClosedResaleDealList(id);
  }

  Future<ClosedResaleDeals> retrieveCollectorClosedResaleDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    return _resaleService.retrieveCollectorClosedResaleDeals(token!, id, false);
  }

  Future<void> retrieveCollectorPendingResaleDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openResaleDeals = await _resaleService.retrieveCollectorPendingResaleDeals(
        token!, id, false);
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  void displayCollectorPendingResaleDealList(int id) {
    _navigationService.displayCollectorPendingResaleDealList(id);
  }

  void displayCollectorOpenResaleDealList(int id) {
    _navigationService.displayCollectorOpenResaleDealList(id);
  }

  Future<void> retrieveCollectorOpenResaleDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openResaleDeals = await _resaleService.retrieveCollectorOpenResaleDeals(
        token!, id, false);
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  Future<List<String>> retrieveCollectibleNames() async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectibleNames(token!, false);
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
