import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/Widget/nav_drawer.dart';

class CollectorTradeInfo extends StatelessWidget {
  CollectorTradeInfo({super.key});

  final GetIt _getIt = GetIt.instance;
  late final CollectorTradeInfoViewmodel _collectorTradeInfoViewmodel =
      _getIt.get<CollectorTradeInfoViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();
  late final Future<List<String>> _collectibleNames =
      _collectorTradeInfoViewmodel.retrieveCollectibleNames();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Trade Deals"),
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
                             _collectorTradeInfoViewmodel.displayCollectorOpenTradeDeals(1);
                            },
                            child: Text(
                              "Your Open ${snapshot.data![0]} Trade Deals",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          _commonWidgetProvider.space(context, 50),
                          TextButton(
                            style:
                                _commonThemeProvider.buttonDesign(context, 90),
                            onPressed: () {
                               _collectorTradeInfoViewmodel.displayCollectorPendingTradeDealList(1);
                            },
                            child: Text(
                              "Your Pending ${snapshot.data![0]} Trade Deals",
                              style: const TextStyle(fontSize: 18.0),
                            ),
                          ),
                          _commonWidgetProvider.space(context, 50),
                          TextButton(
                            style:
                                _commonThemeProvider.buttonDesign(context, 90),
                            onPressed: () {
                              _collectorTradeInfoViewmodel.displayCollectorClosedTradeDealList(1);
                            },
                            child: Text(
                              "Your Closed ${snapshot.data![0]} Trade Deals",
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
                                  _collectorTradeInfoViewmodel.displayCreateTrade(1);
                                },
                                child: Text(
                                  "Create New ${snapshot.data![0]} Trade",
                                  style: const TextStyle(fontSize: 18.0),
                                )),
                          if(snapshot.data!.length > 1)
                            const Divider(color: Color.fromRGBO(52, 58, 64, 1), thickness: 2,),
                          if (snapshot.data!.length > 1)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 1)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _collectorTradeInfoViewmodel.displayCollectorOpenTradeDeals(2);
                              },
                              child: Text(
                                "Your Open ${snapshot.data![1]} Trade Deals",
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
                                 _collectorTradeInfoViewmodel.displayCollectorPendingTradeDealList(2);
                              },
                              child: Text(
                                "Your Pending ${snapshot.data![1]} Trade Deals",
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
                                _collectorTradeInfoViewmodel.displayCollectorClosedTradeDealList(2);
                              },
                              child: Text(
                                "Your Closed ${snapshot.data![1]} Trade Deals",
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
                                  _collectorTradeInfoViewmodel.displayCreateTrade(2);
                                },
                                child: Text(
                                  "Create New ${snapshot.data![1]} Trade",
                                  style: const TextStyle(fontSize: 18.0),
                                )),
                          if(snapshot.data!.length > 2)
                            const Divider(color: Color.fromRGBO(52, 58, 64, 1), thickness: 2,),
                          if (snapshot.data!.length > 1)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 2)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _collectorTradeInfoViewmodel.displayCollectorOpenTradeDeals(3);
                              },
                              child: Text(
                                "Your Open ${snapshot.data![2]} Trade Deals",
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
                                 _collectorTradeInfoViewmodel.displayCollectorPendingTradeDealList(3);
                              },
                              child: Text(
                                "Your Pending ${snapshot.data![2]} Trade Deals",
                                style: const TextStyle(fontSize: 18.0),
                              ),
                            ),
                          if (snapshot.data!.length > 1)
                            _commonWidgetProvider.space(context, 50),
                          if (snapshot.data!.length > 2)
                            TextButton(
                              style: _commonThemeProvider.buttonDesign(
                                  context, 90),
                              onPressed: () {
                                _collectorTradeInfoViewmodel.displayCollectorClosedTradeDealList(3);
                              },
                              child: Text(
                                "Your Closed ${snapshot.data![2]} Trade Deals",
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
                                  _collectorTradeInfoViewmodel.displayCreateTrade(3);
                                },
                                child: Text(
                                  "Create New ${snapshot.data![2]} Trade",
                                  style: const TextStyle(fontSize: 18.0),
                                )),
                                if (snapshot.data!.length > 2)
                            _commonWidgetProvider.space(context, 50),
                        ]);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }))));
  }
}
