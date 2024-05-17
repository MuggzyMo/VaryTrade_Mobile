import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/profile_viewmodel.dart';
import 'package:varytrade_flutter/ext_string.dart';

class ProfileSearch extends StatefulWidget {
  const ProfileSearch({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileSearchState();
}

class _ProfileSearchState extends State<ProfileSearch> {
  final GetIt _getIt = GetIt.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _searchController = TextEditingController();
  late final CommonThemeProvider _commonThemeProvider = _getIt.get<CommonThemeProvider>();
  late final CommonWidgetProvider _commonWidgetProvider = _getIt.get<CommonWidgetProvider>();
  late final ProfileViewmodel _profileViewmodel = _getIt.get<ProfileViewmodel>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Search for a Collector"),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: "Username",
                      labelStyle: TextStyle(fontSize: 15)),
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty ||
                        value.trim().isEmpty ||
                        !value.validateUserName()) {
                      return "Please a valid username.";
                    } else {
                      return null;
                    }
                  }),
              _commonWidgetProvider.space(context, 10),
              TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _profileViewmodel.processProfileSearch(_searchController.text.toString());
                    }
                  },
                  style: _commonThemeProvider.buttonDesign(context, 40),
                  child: const Text("Search"),)
            ],
          ),
        ),
      ),
    );
  }
}
