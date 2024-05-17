import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/home_viewmodel.dart';
import 'package:varytrade_flutter/Widget/nav_drawer.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final GetIt _getIt = GetIt.instance;
  late final HomeViewModel _homeViewModel = _getIt.get<HomeViewModel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();
  late final Future<List<String>> _collectibleNames =
      _homeViewModel.collectibleNames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        drawer: NavDrawer(),
        body: SingleChildScrollView(
            child: Center(
                child: FutureBuilder<List<String>>(
                    future: _collectibleNames,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(children: [
                          _commonWidgetProvider.space(context, 50),
                          TextButton(
                            style:
                                _commonThemeProvider.buttonDesign(context, 90),
                            onPressed: () {
                              _homeViewModel.displayOpenTradeDealList(1);
                            },
                            child: Text(
                              "Open ${snapshot.data![0]} Trade Deals",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          _commonWidgetProvider.space(context, 50),
                          TextButton(
                            style:
                                _commonThemeProvider.buttonDesign(context, 90),
                            onPressed: () {
                              _homeViewModel.displayOpenResaleDealList(1);
                            },
                            child: Text(
                              "Open ${snapshot.data![0]} Resale Deals",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          if (snapshot.data!.length > 1)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 1)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _homeViewModel.displayOpenTradeDealList(2);
                              },
                              child: Text(
                                "Open ${snapshot.data![1]} Trade Deals",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          if (snapshot.data!.length > 1)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 1)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _homeViewModel.displayOpenResaleDealList(2);
                              },
                              child: Text(
                                "Open ${snapshot.data![1]} Resale Deals",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          if (snapshot.data!.length > 2)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 2)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _homeViewModel.displayOpenTradeDealList(3);
                              },
                              child: Text(
                                "Open ${snapshot.data![2]} Trade Deals",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          if (snapshot.data!.length > 2)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 2)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _homeViewModel.displayOpenResaleDealList(3);
                              },
                              child: Text(
                                "Open ${snapshot.data![1]} Resale Deals",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            )
                        ]);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }))));
  }
}
