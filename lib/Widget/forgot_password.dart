import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/ViewModel/forgot_password_viewmodel.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ext_string.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final GetIt _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  late final ForgotPasswordViewModel _forgotPasswordViewModel =
      _getIt.get<ForgotPasswordViewModel>();
  late final Future<Company>? _futureCompany;
  late final CommonWidgetProvider _commonWidgetProvider;
  late final CommonThemeProvider _commonThemeProvider;

  @override
  void initState() {
    super.initState();
    _futureCompany = _forgotPasswordViewModel.companyInfo();
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
                return Text(snapshot.data!.name + " Forgot Password");
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
                child: Column(children: [
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
                  TextButton(
                      style: _commonThemeProvider.buttonDesign(context, 90),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _forgotPasswordViewModel.processForgotPasswordRequest(
                            _emailTextEditingController.text.toString().trim(),
                          );
                        }
                      },
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(fontSize: 18.0),
                      )),
                ]))));
  }
}
