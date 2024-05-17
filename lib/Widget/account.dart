import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/ViewModel/account_viewmodel.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Widget/nav_drawer.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();
  final GetIt _getIt = GetIt.instance;
  late final AccountViewmodel _accountViewModel =
      _getIt.get<AccountViewmodel>();

  @override
  void initState() {
    super.initState();
    _accountViewModel.retrieveAccount();
    _accountViewModel.onLoadingChanged = () => setState(() {});
  }

  @override
  void dispose() {
    _accountViewModel.loading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      drawer: NavDrawer(),
      body: SingleChildScrollView(
        child: _accountViewModel.loading
            ? const Center(child: CircularProgressIndicator())
            : Center(
                child: Column(children: <Widget>[
                  _commonWidgetProvider.space(context, 10),
                  Text(
                    "Email: ${_accountViewModel.userInfo.email.toString()}",
                    style: const TextStyle(fontSize: 20),
                  ),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Username: ${_accountViewModel.userInfo.userName.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "First Name: ${_accountViewModel.userInfo.firstName.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Middle Name: ${_accountViewModel.userInfo.middleName.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Last Name: ${_accountViewModel.userInfo.lastName.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Phone Number: ${_accountViewModel.userInfo.phoneNum.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Address: ${_accountViewModel.userInfo.address.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text("City: ${_accountViewModel.userInfo.city.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text(
                      "Zip Code: ${_accountViewModel.userInfo.zipCode.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text("State: ${_accountViewModel.userInfo.state.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 10),
                  Text("Credit: \$ ${_accountViewModel.credit.toString()}",
                      style: const TextStyle(fontSize: 20)),
                  _commonWidgetProvider.space(context, 30),
                  if (!_accountViewModel.hyperwallet)
                    TextButton(
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        onPressed: () {
                          _accountViewModel.proccessPayout();
                        },
                        child: const Text("Payout",
                            style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                  if (!_accountViewModel.hyperwallet)
                    TextButton(
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        onPressed: () {
                          _accountViewModel.displayPayoutList();
                        },
                        child: const Text("Payout History",
                            style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                  if (_accountViewModel.hyperwallet)
                    TextButton(
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        onPressed: () {
                          _accountViewModel
                              .displayHyperwalletRegistrationDialog();
                        },
                        child: const Text("Register for Hyperwallet Payouts",
                            style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                  TextButton(
                      style: _commonThemeProvider.buttonDesign(context, 90),
                      onPressed: () {
                        _accountViewModel.displayEditAccount();
                      },
                      child: const Text("Edit Account Information",
                          style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                  if (!_accountViewModel.passwordSetup)
                    TextButton(
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        onPressed: () {
                          _accountViewModel.displayChangePassword();
                        },
                        child: const Text("Change Password",
                            style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                  if (_accountViewModel.passwordSetup)
                    TextButton(
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        onPressed: () {
                          _accountViewModel.displayCreatePassword();
                        },
                        child: const Text("Create Password for Account",
                            style: TextStyle(fontSize: 18))),
                  _commonWidgetProvider.space(context, 20),
                ]),
              ),
      ),
    );
  }
}
