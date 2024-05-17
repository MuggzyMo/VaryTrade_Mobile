import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/account_viewmodel.dart';
import 'package:varytrade_flutter/ext_string.dart';
import 'dart:developer' as developer;

import '../Common/common_theme_provider.dart';

class EditAccount extends StatefulWidget {
  const EditAccount({super.key});

  @override
  State<StatefulWidget> createState() => _EditAccountState();
}

class _EditAccountState extends State<EditAccount> {
  late final TextEditingController _emailTextEditingController;
  late final TextEditingController _phoneNumTextEditingController;
  late final TextEditingController _firstNameTextEditingController;
  late final TextEditingController _lastNameTextEditingController;
  late final TextEditingController _middleNameTextEditingController;
  late final TextEditingController _addressTextEditingController;
  late final TextEditingController _cityTextEditingController;
  late final TextEditingController _zipCodeTextEditingController;
  late String _state;
  final GetIt _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  late final Future<List<String>>? _futureStates;
  late final CommonWidgetProvider _commonWidgetProvider;
  late final CommonThemeProvider _commonThemeProvider;
  late final AccountViewmodel _accountViewModel;

  @override
  void initState() {
    super.initState();
    _accountViewModel = _getIt.get<AccountViewmodel>();
    _setupTextEditingControllers();
    _state = _accountViewModel.userInfo.state;
    _futureStates = _accountViewModel.states();
    _commonWidgetProvider = _getIt.get<CommonWidgetProvider>();
    _commonThemeProvider = _getIt.get<CommonThemeProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Edit Account Information"),
        content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!_accountViewModel.passwordSetup)
                    TextFormField(
                      controller: _emailTextEditingController,
                      decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 15)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty ||
                            value.trim().isEmpty ||
                            !EmailValidator.validate(value, true) ||
                            !value.validateEmail()) {
                          return "Please enter your email.";
                        } else {
                          return null;
                        }
                      },
                    ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _phoneNumTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Phone Number",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validatePhoneNum()) {
                        return "Please enter your phone number.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _firstNameTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "First Name",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validateFirstName()) {
                        return "Please enter your first name.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _middleNameTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Middle Name (Optional)",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.name,
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _lastNameTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Last Name",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validateLastName()) {
                        return "Please enter your last name.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _addressTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Address",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.streetAddress,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validateAddress()) {
                        return "Please enter your correctly formatted address.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _cityTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "City",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validateCity()) {
                        return "Please enter your correctly formatted city.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  TextFormField(
                    controller: _zipCodeTextEditingController,
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Zip Code",
                        labelStyle: TextStyle(fontSize: 15)),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty ||
                          value.trim().isEmpty ||
                          !value.validateZipCode()) {
                        return "Please enter your correctly formatted zip code.";
                      } else {
                        return null;
                      }
                    },
                  ),
                  _commonWidgetProvider.space(context, 50),
                  FutureBuilder(
                      future: _futureStates,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownButtonFormField(
                            value: _state,
                            items: snapshot.data!
                                .map<DropdownMenuItem<String>>((String string) {
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string),
                              );
                            }).toList(),
                            onChanged: (value) {
                              _state = value.toString();
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                  _commonWidgetProvider.space(context, 50),
                  TextButton(
                      style: _commonThemeProvider.buttonDesign(context, 90),
                      onPressed: () async {
                        developer.log("reached");
                        if (_formKey.currentState!.validate()) {
                          developer.log("reached");
                          _accountViewModel.processEditAccount(
                              !_accountViewModel.passwordSetup
                                  ? _emailTextEditingController.text
                                      .toString()
                                      .trim()
                                  : null,
                              _addressTextEditingController.text
                                  .toString()
                                  .trim(),
                              _zipCodeTextEditingController.text
                                  .toString()
                                  .trim(),
                              _cityTextEditingController.text.toString().trim(),
                              _state.trim(),
                              _firstNameTextEditingController.text
                                  .toString()
                                  .trim(),
                              _lastNameTextEditingController.text
                                  .toString()
                                  .trim(),
                              _middleNameTextEditingController.text
                                  .toString()
                                  .trim(),
                              _phoneNumTextEditingController.text
                                  .toString()
                                  .trim());
                        }
                      },
                      child: const Text("Save"))
                ],
              ),
            )));
  }

  void _setupTextEditingControllers() {
    if(!_accountViewModel.passwordSetup) {
      _emailTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.email);
    }
    _phoneNumTextEditingController =
        TextEditingController(text: _formatPhoneNumField());
    _firstNameTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.firstName);
    _middleNameTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.middleName);
    _lastNameTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.lastName);
    _addressTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.address);
    _cityTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.city);
    _zipCodeTextEditingController =
        TextEditingController(text: _accountViewModel.userInfo.zipCode);
  }

  String _formatPhoneNumField() {
    String phoneNum = "";
    for (int i = 0; i < _accountViewModel.userInfo.phoneNum.length; i++) {
      if (_accountViewModel.userInfo.phoneNum.toString()[i] != '-') {
        phoneNum = phoneNum + _accountViewModel.userInfo.phoneNum.toString()[i];
      }
    }
    return phoneNum;
  }
}
