import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/account_viewmodel.dart';
import 'package:varytrade_flutter/ext_string.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final GetIt _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  late final CommonWidgetProvider _commonWidgetProvider;
  late final CommonThemeProvider _commonThemeProvider;
  late final AccountViewmodel _accountViewModel;
  final TextEditingController _newPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    _accountViewModel = _getIt.get<AccountViewmodel>();
    _commonWidgetProvider = _getIt.get<CommonWidgetProvider>();
    _commonThemeProvider = _getIt.get<CommonThemeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Change Password for Account"),
      content: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _passwordTextEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Current Password",
                      labelStyle: TextStyle(fontSize: 15)),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().isEmpty ||
                        !value.validateCurrentPassword()) {
                      return "Please enter your current password.";
                    } else {
                      return null;
                    }
                  },
                ),
                _commonWidgetProvider.space(context, 50),
                TextFormField(
                  controller: _newPasswordTextEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "New Password",
                      labelStyle: TextStyle(fontSize: 15)),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().isEmpty ||
                        !value.validatePassword(
                            _confirmPasswordTextEditingController.text
                                .toString())) {
                      return "Please enter a new password.";
                    } else {
                      return null;
                    }
                  },
                ),
                _commonWidgetProvider.space(context, 50),
                TextFormField(
                  controller: _confirmPasswordTextEditingController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Confirm Password",
                      labelStyle: TextStyle(fontSize: 15)),
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().isEmpty ||
                        !value.validatePassword(
                            _newPasswordTextEditingController.text
                                .toString())) {
                      return "Please confirm the new password.";
                    } else {
                      return null;
                    }
                  },
                ),
                _commonWidgetProvider.space(context, 50),
                TextButton(
                    style: _commonThemeProvider.buttonDesign(context, 90),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _accountViewModel.processChangePassword(
                            _passwordTextEditingController.text
                                .toString()
                                .trim(),
                            _newPasswordTextEditingController.text
                                .toString()
                                .trim(),
                            _confirmPasswordTextEditingController.text
                                .toString()
                                .trim());
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 17.0),
                    )),
              ],
            ),
          )),
    );
  }
}
