import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/ViewModel/contact_viewmodel.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Widget/nav_drawer.dart';

class Contact extends StatelessWidget {
  Contact({super.key});

  final GetIt _getIt = GetIt.instance;
  late final ContactViewModel _contactViewModel = _getIt.get<ContactViewModel>();
  late final Future<Company> _futureCompany =
      _contactViewModel.companyInfo();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Contact Us"),
            backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
          ),
          drawer: NavDrawer(),
          body: Center(
              child: Column(children: <Widget>[
            _getIt.get<CommonWidgetProvider>().space(context, 20),
            const Text("Need help?", style: TextStyle(fontSize: 20)),
            FutureBuilder<Company>(
                future: _futureCompany,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "Email us at ${snapshot.data!.email} call us at ${snapshot.data!.phoneNum}.",
                      style: const TextStyle(fontSize: 20),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return const CircularProgressIndicator();
                  }
                })
          ])),
        ),
        onWillPop: () async {
         _contactViewModel.displayHome();
          return false;
        });
  }
}
