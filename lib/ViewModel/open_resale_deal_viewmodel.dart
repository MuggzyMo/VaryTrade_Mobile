import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_resale_deal.dart';
import 'package:varytrade_flutter/Model/open_resale_deals.dart';
//import 'package:varytrade_flutter/Service/braintree_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/resale_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/http_code.dart';

class OpenResaleDealViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final ResaleService _resaleService = _getIt.get<ResaleService>();
  //late final BraintreeService _braintreeService =
  //    _getIt.get<BraintreeService>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  OpenResaleDeals? _openResaleDeals;
  get openResaleDeals => _openResaleDeals;
  set openResaleDeals(openResaleDeals) => _openResaleDeals = openResaleDeals;

  OpenResaleDeal? _selectedOpenResaleDeal;
  get selectedOpenResaleDeal => _selectedOpenResaleDeal;
  set selectedOpenResaleDeal(value) => _selectedOpenResaleDeal = value;

  /*
  String? _braintreeToken;
  get braintreeToken => _braintreeToken;
  */

  int? _selectedIndex;
  get selectedIndex => _selectedIndex;
  set selectedIndex(value) => _selectedIndex = value;

  bool _listLoading = true;
  Function()? onListLoadingChanged;
  get listLoading => _listLoading;
  set listLoading(listLoading) => _listLoading = listLoading;

  Future<void> acceptOpenResaleDealWithCredit() async {
     _secureStorage.getJwtToken().then((value) {
      _resaleService
          .acceptResaleDealWithCredit(
              value!, _selectedOpenResaleDeal!.id, false)
          .then((value) {
        if (value.statusCode == HttpCode.success) {
          _listLoading = true;
          onListLoadingChanged?.call();
          _navigation.pop();
          _navigation.displayResaleCreditSuccessfulDialog();
          retrieveAcceptableOpenResaleDeals(_selectedOpenResaleDeal!.itemType);
        } else {
          _navigation.displayErrorDialog(
              "Credit Purchase Failed", value);
        }
      });
    });
  }

  Future<void> acceptOpenResaleDealWithPayment() async {
    _secureStorage.getJwtToken().then((value) {
      _resaleService
          .acceptResaleDealWithPayment(
              value!, _selectedOpenResaleDeal!.id, false)
          .then((value) {
        if (value.statusCode == HttpCode.success) {
          _listLoading = true;
          onListLoadingChanged?.call();
          _navigation.pop();
          _navigation.displayResalePaymentSuccessfulDialog();
          retrieveAcceptableOpenResaleDeals(_selectedOpenResaleDeal!.itemType);
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

  Future<void> retrieveAcceptableOpenResaleDeals(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openResaleDeals = await _resaleService.retrieveAcceptableOpenResaleDeals(
        token!, id, false);
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  Future<void> retrieveProfileOpenResaleDeals(String username, int id) async {
    String? token = await _secureStorage.getJwtToken();
    _openResaleDeals = await _resaleService.retrieveProfileOpenResaleDeals(
        token!, username, id, false);
    _selectedOpenResaleDeal = null;
    _listLoading = false;
    onListLoadingChanged?.call();
  }

  void displayOpenResaleDetails(int index) {
    _selectedOpenResaleDeal = _openResaleDeals!.openResaleDeals[index];
    _selectedIndex = index;
    _navigation.displayOpenResaleDetails();
  }

  void displayProfile(String username) async {
    String? currentCollectorUsername = await _secureStorage.getUserName();
    if (currentCollectorUsername != username) {
      _navigation.displayProfile(username);
    } else {
      _navigation.displayErrorDialog("Profile Lookup Error",
          GeneralResponse(HttpCode.forbidden, ["You cannot view your own profile."]));
    }
  }

  void displayPaymentFailed() {
    _navigation.displayErrorDialog("Payment Failed",
        GeneralResponse(HttpCode.unprocessableEntity, ["Your payment attempt has failed."]));
  }
}
