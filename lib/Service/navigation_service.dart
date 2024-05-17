import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/google_registration_response.dart';
import 'package:varytrade_flutter/Widget/account.dart';
import 'package:varytrade_flutter/Widget/change_password.dart';
import 'package:varytrade_flutter/Widget/collector_closed_resale_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_closed_trade_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_open_resale_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_open_resale_details.dart';
import 'package:varytrade_flutter/Widget/collector_open_trade_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_open_trade_details.dart';
import 'package:varytrade_flutter/Widget/collector_pending_resale_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_pending_resale_details.dart';
import 'package:varytrade_flutter/Widget/collector_pending_trade_deal_list.dart';
import 'package:varytrade_flutter/Widget/collector_pending_trade_details.dart';
import 'package:varytrade_flutter/Widget/collector_resale_info.dart';
import 'package:varytrade_flutter/Widget/create_resale.dart';
import 'package:varytrade_flutter/Widget/create_trade.dart';
import 'package:varytrade_flutter/Widget/open_resale_details.dart';
import 'package:varytrade_flutter/Widget/open_trade_details.dart';
import 'package:varytrade_flutter/Widget/profile_open_resale_deal_list.dart';
import 'package:varytrade_flutter/Widget/profile_open_trade_deal_list.dart';
import 'package:varytrade_flutter/Widget/profile_search.dart';
import 'package:varytrade_flutter/Widget/collector_trade_info.dart';
import 'package:varytrade_flutter/Widget/contact.dart';
import 'package:varytrade_flutter/Widget/create_password.dart';
import 'package:varytrade_flutter/Widget/edit_account.dart';
import 'package:varytrade_flutter/Widget/followers.dart';
import 'package:varytrade_flutter/Widget/following.dart';
import 'package:varytrade_flutter/Widget/forgot_password.dart';
import 'package:varytrade_flutter/Widget/google_registration.dart';
import 'package:varytrade_flutter/Widget/home.dart';
import 'package:varytrade_flutter/Widget/hyperwallet_registration.dart';
import 'package:varytrade_flutter/Widget/login.dart';
import 'package:varytrade_flutter/Widget/open_resale_deal_list.dart';
import 'package:varytrade_flutter/Widget/open_trade_deal_list.dart';
import 'package:varytrade_flutter/Widget/payout_list.dart';
import 'package:varytrade_flutter/Widget/profile.dart';
import 'package:varytrade_flutter/Widget/registration.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  final GetIt _getIt = GetIt.instance;

  void displayOpenTradeDetails() {
     Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => OpenTradeDetails()));
  }

  void displayOpenResaleDetails() {
    Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => OpenResaleDetails()));
  }

  void displayCollectorOpenResaleDetails() {
    Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => CollectorOpenResaleDetails()));
  }

  void displayCollectorOpenTradeDetails() {
    Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => CollectorOpenTradeDetails()));
  }

  void displayCollectorPendingResaleDetails() {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorPendingResaleDetails()));
  }

  void displayCollectorPendingTradeDetails() {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorPendingTradeDetails()));
  }

  void displayCreateResale(int id) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => CreateResale(id)));
  }

  void displayCreateTrade(int id) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => CreateTrade(id)));
  }

  void displayProfileOpenResales(String username, int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => ProfileOpenResaleDealList(username, id)));
  }

  void displayProfileOpenTrades(String username, int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => ProfileOpenTradeDealList(username, id)));
  }

  void displayProfile(String username) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => Profile(username)));
  }

  void displayFollowers() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => const Followers()));
  }

  void displayFollowing() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => const Following()));
  }

  void displayProfileSearch() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const ProfileSearch());
  }

  void displayCollectorClosedResaleDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorClosedResaleDealList(id)));
  }

  void displayCollectorPendingResaleDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorPendingResaleDealList(id)));
  }

  void displayCollectorOpenResaleDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorOpenResaleDealList(id)));
  }

  void displayCollectorClosedTradeDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorClosedTradeDealList(id)));
  }

  void displayCollectorOpenTradeDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(MaterialPageRoute(
        builder: (context) => CollectorOpenTradeDealList(id)));
  }

  void displayCollectorPendingTradeDealList(int id) {
    Navigator.of(navigatorKey.currentContext!).push(
        MaterialPageRoute(builder: (context) => PendingTradeDealList(id)));
  }

  void displayCollectorTradeInfo() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => CollectorTradeInfo()));
  }

  void displayCollectorResaleInfo() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => CollectorResaleInfo()));
  }

  void displayOpenResaleDealList(int id) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => OpenResaleDealList(id)));
  }

  void displayOpenTradeDealList(int id) {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => OpenTradeDealList(id)));
  }

  void displayChangePassword() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const ChangePassword());
  }

  void displayCreatePassword() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const CreatePassword());
  }

  void displayEditAccount() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const EditAccount());
  }

  void displayPayoutList() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => PayoutList()));
  }

    void displayTradeCreditSuccessfulDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Trade Credit Payment",
            "Your credit payment was successfully processed! Check your pending trades to see the details.",
            Colors.black));
  }

  void displayTradePaymentSuccessfulDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Trade Payment",
            "Your payment was successfully processed! Check your pending trades to see the details.",
            Colors.black));
  }

  void displayResaleCreditSuccessfulDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Resale Credit Payment",
            "Your credit payment was successfully processed! Check your pending resales to see the details.",
            Colors.black));
  }

  void displayResalePaymentSuccessfulDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Resale Payment",
            "Your payment was successfully processed! Check your pending resales to see the details.",
            Colors.black));
  }

  void displayCreateOpenTradeSuccessDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Create Open Trade",
            "Your trade was successfully created!!",
            Colors.black));
  }

  void displayCreateOpenResaleSuccessDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Create Open Resale",
            "Your resale was successfully created!!",
            Colors.black));
  }

  void displayPayoutSuccessfulDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt
            .get<CommonWidgetProvider>()
            .alert("Payout", "Payout was successful!!", Colors.black));
  }

  void displayErrorDialog(String title, GeneralResponse generalResponse) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            title,
            "${generalResponse.statusCode} ${generalResponse.errorMessage.toString()}",
            Colors.red));
  }

  void displayPayoutUnsuccessfulDialog(GeneralResponse payoutResponse) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Payout Error",
            "${payoutResponse.statusCode} ${payoutResponse.errorMessage.toString()}",
            Colors.red));
  }

  void pop() {
    Navigator.of(navigatorKey.currentContext!).pop();
  }

  void displayAccount() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => const Account()));
  }

  void displayHyperwalletRegistration() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => const HyperwalletRegistration());
  }

  void displayContact() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => Contact()));
  }

  void displayLogin() {
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }

  void logout() {
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
        (route) => false);
  }

  void displayForgotPassword() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => const ForgotPassword()));
  }

  void displayRegistration() {
    Navigator.of(navigatorKey.currentContext!)
        .push(MaterialPageRoute(builder: (context) => const Registration()));
  }

  void displayHomeFromLogin() {
    Navigator.of(navigatorKey.currentContext!)
        .pushReplacement(MaterialPageRoute(builder: (context) => Home()));
  }

  void displayLoginErrorDialog() {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Authentication Error",
            "Your entered an invalid email and password.",
            Colors.red));
  }

  void displayGoogleRegistrationErrorDialog(
      GoogleRegistrationResponse googleRegistrationResponse) {
    showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) => _getIt.get<CommonWidgetProvider>().alert(
            "Google Registration Error",
            "${googleRegistrationResponse.statusCode} ${googleRegistrationResponse.errorMessage.toString()}",
            Colors.red));
  }

  void displayGoogleRegistration(String email) {
    Navigator.of(navigatorKey.currentContext!).pushReplacement(
        MaterialPageRoute(builder: (context) => const GoogleRegistration()));
  }

  void displayHome() {
    Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil<bool>(
        MaterialPageRoute(builder: (context) => Home()), (route) => false);
  }
}
