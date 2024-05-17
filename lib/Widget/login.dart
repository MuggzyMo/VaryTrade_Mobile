import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/login_viewmodel.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:varytrade_flutter/Model/company.dart';

import 'dart:async';

import 'package:varytrade_flutter/ext_string.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  /*
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ],
      serverClientId:
          "");
  */
  final _formKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;
  late final LoginViewModel _loginViewModel = _getIt.get<LoginViewModel>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  late final Future<Company>? _futureCompany;
  late final CommonWidgetProvider _commonWidgetProvider = _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();

  @override
  void initState() {
    super.initState();
    _futureCompany = _loginViewModel.companyInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder<Company>(
            future: _futureCompany,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!.name + " Login");
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
            child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _emailTextEditingController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Email",
                      labelStyle: TextStyle(fontSize: 20)),
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
                      labelStyle: TextStyle(fontSize: 20)),
                  validator: (value) {
                    if (value!.isEmpty || value.trim().isEmpty) {
                      return "Please enter your password.";
                    } else {
                      return null;
                    }
                  },
                ),
                _commonWidgetProvider.space(context, 50),
                TextButton(
                    style: _commonThemeProvider
                    .buttonDesign(context, 90),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _processLogin(
                            _emailTextEditingController.text.toString().trim(),
                            _passwordTextEditingController.text
                                .toString()
                                .trim(),
                            context);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(fontSize: 18.0),
                    )),
                _commonWidgetProvider.space(context, 50),
                TextButton(
                    style: _commonThemeProvider
                    .buttonDesign(context, 90),
                    onPressed: () async {
                      //_googleSignIn.signIn().then((value) {
                        //_processGoogleLogin(value, context);
                      //});
                      _loginViewModel.displayGoogleSignInIssue();
                    },
                    child: const Text(
                      "Login with Google",
                      style: TextStyle(fontSize: 18.0),
                    )),
                _commonWidgetProvider.space(context, 50),
                const Text(
                  "Don't have an account yet?",
                  style: TextStyle(fontSize: 18.0),
                ),
                _commonWidgetProvider.space(context, 10),
                TextButton(
                  style: _getIt
                    .get<CommonThemeProvider>()
                    .buttonDesign(context, 90),
                  onPressed: () {
                    _loginViewModel.displayRegistration();
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
                _commonWidgetProvider.space(context, 50),
                InkWell(
                  onTap: () {
                    _loginViewModel.displayForgotPassword();
                  },
                  child: const Text(
                    "Forgot your password? Click here.",
                    style: TextStyle(color: Colors.black, fontSize: 18.0),
                  ),
                )
              ],
            ),
          ),
        )));
  }

  void _processLogin(String email, String password, BuildContext context) {
    _loginViewModel.processLogin(email, password, context);
  }

  /* void _processGoogleLogin(
      GoogleSignInAccount? googleSignInAccount, BuildContext context) {
    _loginViewModel.processGoogleLogin(googleSignInAccount, context);
  } */
}
