import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/ViewModel/account_viewmodel.dart';

class HyperwalletRegistration extends StatefulWidget {
  const HyperwalletRegistration({super.key});

  @override
  State<StatefulWidget> createState() => _HyperwalletRegistrationState();
}

class _HyperwalletRegistrationState extends State<HyperwalletRegistration> {
  final GetIt _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  late final AccountViewmodel _accountViewModel =
      _getIt.get<AccountViewmodel>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text("Date of Birth"),
        content: Form(
            key: _formKey,
            child: SingleChildScrollView(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Date",
                    filled: true,
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                  onTap: () async {
                    DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now());

                    if (picked != null) {
                      _dateController.text = picked.toString().split(" ")[0];
                    }
                  },
                  controller: _dateController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your date of birth.";
                    } else {
                      return null;
                    }
                  },
                ),
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _accountViewModel.proccessHyperwalletRegistration(
                          _dateController.text.toString());
                    }
                  },
                  style: _getIt
                      .get<CommonThemeProvider>()
                      .buttonDesign(context, 90),
                  child: const Text(
                    "Register",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ))));
  }
}
