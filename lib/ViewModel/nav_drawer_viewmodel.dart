import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';

class NavDrawerViewModel {
  final GetIt _getIt = GetIt.instance;
  late final NavigationService _navigationService = _getIt.get<NavigationService>();

  void displayProfileSearch() {
    _navigationService.displayProfileSearch();
  }

  void displayFollowers() {
    _navigationService.displayFollowers();
  }

  void displayFollowing() {
    _navigationService.displayFollowing();
  }

  void displayHome() {
    _navigationService.displayHome();
  }

  void displayContact() {
    _navigationService.displayContact();
  }

  void displayAccount() {
    _navigationService.displayAccount();
  }

  void logout() {
    _navigationService.logout();
  }

  void displayCollectorResaleInfo() {
    _navigationService.displayCollectorResaleInfo();
  }

  void displayCollectorTradeInfo() {
    _navigationService.displayCollectorTradeInfo();
  }
  
}