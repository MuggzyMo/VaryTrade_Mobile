import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_trade_deal.dart';
import 'package:varytrade_flutter/Model/open_trade_deals.dart';
//import 'package:varytrade_flutter/Service/braintree_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class OpenTradeDealViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  //late final BraintreeService _braintreeService =
  //    _getIt.get<BraintreeService>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  OpenTradeDeals? _openTradeDeals;
  get openTradeDeals => _openTradeDeals;
  set openTradeDeals(openTradeDeals) => _openTradeDeals = openTradeDeals;

  bool _listLoading = true;
  Function()? onListLoadingChanged;
  get listLoading => _listLoading;
  set listLoading(listLoading) => _listLoading = listLoading;

  int? _selectedIndex;
  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => _selectedIndex = value;

  OpenTradeDeal? _selectedOpenTradeDeal;
  get selectedOpenTradeDeal => _selectedOpenTradeDeal;
  set selectedOpenTradeDeal(selectedOpenTradeDeal) =>
      _selectedOpenTradeDeal = selectedOpenTradeDeal;

  bool _selectedLoading = true;
  Function()? onSelectedLoadingChanged;
  get selectedLoading => _selectedLoading;
  set selectedLoading(selectedLoading) => _selectedLoading = selectedLoading;

  void displayOpenTradeDetails(int index) {
    _selectedOpenTradeDeal = _openTradeDeals!.openTradeDeals[index];
    _selectedIndex = index;
    _navigation.displayOpenTradeDetails();
  }

  Future<void> acceptOpenTradeDealWithCredit() async {
    _secureStorage.getJwtToken().then((value) {
      _tradeService
          .acceptTradeDealWithCredit(value!, _selectedOpenTradeDeal!.id, false)
          .then((value) {
        if (value.statusCode == HttpCode.success) {
          _listLoading = true;
          onListLoadingChanged?.call();
          _navigation.pop();
          _navigation.displayTradeCreditSuccessfulDialog();
          retrieveAcceptableOpenTradeDeals(_selectedOpenTradeDeal!.itemType);
        } else {
          _navigation.displayErrorDialog("Credit Purchase Failed", value);
        }
      });
    });
  }

  Future<void> acceptOpenTradeDealWithPayment() async {
    _secureStorage.getJwtToken().then((value) {
      _tradeService
          .acceptTradeDealWithPayment(value!, _selectedOpenTradeDeal!.id, false)
          .then((value) {
        if (value.statusCode == HttpCode.success) {
          _listLoading = true;
          onListLoadingChanged?.call();
          _navigation.pop();
          _navigation.displayTradePaymentSuccessfulDialog();
          retrieveAcceptableOpenTradeDeals(_selectedOpenTradeDeal!.itemType);
        } else {
          _navigation.displayErrorDialog(
              "Transaction Verification Failed", value);
        }
      });
    });
  }

  /*
  Future<String>? retrieveBraintreeToken() async {
    String? token = await _secureStorage.getJwtToken();
    return await _braintreeService.retrieveBraintreeToken(token!, false);
  }
  */

  Future<void> retrieveProfileOpenTradeDeals(String username, int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openTradeDeals = await _tradeService.retrieveProfileOpenTradeDeals(
        token!, username, id, false);
    _selectedOpenTradeDeal = null;
    _selectedLoading = true;
    _listLoading = false;
    onListLoadingChanged?.call();
    onSelectedLoadingChanged?.call();
  }

  Future<void> retrieveAcceptableOpenTradeDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openTradeDeals =
        await _tradeService.retrieveAcceptableOpenTradeDeals(token!, id, false);
    _selectedOpenTradeDeal = null;
    _selectedLoading = true;
    _listLoading = false;
    onListLoadingChanged?.call();
    onSelectedLoadingChanged?.call();
  }

  void displayProfile(String username) async {
    String? currentCollectorUsername = await _secureStorage.getUserName();
    if (currentCollectorUsername != username) {
      _navigation.displayProfile(username);
    } else {
      _navigation.displayErrorDialog(
          "Profile Lookup Error",
          GeneralResponse(
              HttpCode.forbidden, ["You cannot view your own profile."]));
    }
  }

  void displayPaymentFailed() {
    _navigation.displayErrorDialog(
        "Payment Failed",
        GeneralResponse(HttpCode.unprocessableEntity,
            ["Your payment attempt has failed."]));
  }
}
