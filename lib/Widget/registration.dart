import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/ViewModel/registration_viewmodel.dart';
import 'package:email_validator/email_validator.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ext_string.dart';

import '../Model/company.dart';
import 'dart:async';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
      TextEditingController();
  final TextEditingController _phoneNumTextEditingController =
      TextEditingController();
  final TextEditingController _userNameTextEditingController =
      TextEditingController();
  final TextEditingController _firstNameTextEditingController =
      TextEditingController();
  final TextEditingController _lastNameTextEditingController =
      TextEditingController();
  final TextEditingController _middleNameTextEditingController =
      TextEditingController();
  final TextEditingController _addressTextEditingController =
      TextEditingController();
  final TextEditingController _cityTextEditingController =
      TextEditingController();
  final TextEditingController _zipCodeTextEditingController =
      TextEditingController();
  String state = "Alabama";
  late final Future<Company>? _futureCompany;
  late final Future<List<String>>? _futureStates;
  late final CommonWidgetProvider _commonWidgetProvider;
  late final CommonThemeProvider _commonThemeProvider;
  final GetIt _getIt = GetIt.instance;
  late final RegistrationViewModel _registrationViewModel;

  @override
  void initState() {
    super.initState();
    _registrationViewModel = _getIt.get<RegistrationViewModel>();
    _futureCompany = _registrationViewModel.companyInfo();
    _futureStates = _registrationViewModel.states();
    _commonWidgetProvider = _getIt.get<CommonWidgetProvider>();
    _commonThemeProvider = _getIt.get<CommonThemeProvider>();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Company>(
          future: _futureCompany,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.name + " Registration");
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                controller: _passwordTextEditingController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 15)),
                validator: (value) {
                  if (value!.isEmpty ||
                      value.trim().isEmpty ||
                      !value.validatePassword(
                          _confirmPasswordTextEditingController.text
                              .toString())) {
                    return "Please enter a password.";
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
                          _passwordTextEditingController.text.toString())) {
                    return "Please confirm password.";
                  } else {
                    return null;
                  }
                },
              ),
              _commonWidgetProvider.space(context, 50),
              TextFormField(
                controller: _userNameTextEditingController,
                decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Username",
                    labelStyle: TextStyle(fontSize: 15)),
                validator: (value) {
                  if (value!.isEmpty ||
                      value.trim().isEmpty ||
                      !value.validateUserName()) {
                    return "Please enter a username.";
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
                  }
                  else {
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
                        value: state,
                        items: snapshot.data!
                            .map<DropdownMenuItem<String>>((String string) {
                          return DropdownMenuItem<String>(
                            value: string,
                            child: Text(string),
                          );
                        }).toList(),
                        onChanged: (value) {
                          state = value.toString();
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              _commonWidgetProvider.space(context, 50),
              TextButton(
                  style: _commonThemeProvider.buttonDesign(context, 90),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _processRegistration(
                          _userNameTextEditingController.text.toString().trim(),
                          _emailTextEditingController.text.toString().trim(),
                          _passwordTextEditingController.text.toString().trim(),
                          _confirmPasswordTextEditingController.text
                              .toString()
                              .trim(),
                          _addressTextEditingController.text.toString().trim(),
                          _zipCodeTextEditingController.text.toString().trim(),
                          _cityTextEditingController.text.toString().trim(),
                          state.trim(),
                          _firstNameTextEditingController.text
                              .toString()
                              .trim(),
                          _lastNameTextEditingController.text.toString().trim(),
                          _middleNameTextEditingController.text
                              .toString()
                              .trim(),
                          _phoneNumTextEditingController.text.toString().trim());
                    }
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 17.0),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _processRegistration(
      String userName,
      String email,
      String password,
      String confirmPassword,
      String address,
      String zipCode,
      String city,
      String state,
      String firstName,
      String lastName,
      String middleName,
      String phoneNum) {
    _registrationViewModel.processRegistration(
      userName,
      email,
      password,
      confirmPassword,
      address,
      zipCode,
      city,
      state,
      firstName,
      lastName,
      middleName,
      phoneNum,
    );
  }
}
