import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/Widget/open_trade_item_list.dart';

class CollectorOpenTradeDetails extends StatelessWidget {
  CollectorOpenTradeDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final CollectorTradeInfoViewmodel _collectorTradeInfoViewmodel =
      _getIt.get<CollectorTradeInfoViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Your Open ${_collectorTradeInfoViewmodel.openTradeDeals.collectibleType} Trade"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(
        children: [
          Text(
            "ID: ${_collectorTradeInfoViewmodel.selectedOpenTradeDeal.id}",
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
          _commonWidgetProvider.space(context, 10),
          Text(
            "Date Posted: ${_collectorTradeInfoViewmodel.selectedOpenTradeDeal.postDate}",
            style: const TextStyle(color: Colors.black, fontSize: 15),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  _commonWidgetProvider.space(context, 10),
                  const Text("Collectibles you are trading:",
                      style: TextStyle(color: Colors.black)),
                  OpenTradeItemList(_collectorTradeInfoViewmodel
                          .openTradeDeals.posterTradeItems[
                      _collectorTradeInfoViewmodel.selectedIndex])
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  _commonWidgetProvider.space(context, 10),
                  const Text(
                    "Collectibles you will receive",
                    style: TextStyle(color: Colors.black),
                  ),
                  OpenTradeItemList(_collectorTradeInfoViewmodel
                          .openTradeDeals.accepterTradeItems[
                      _collectorTradeInfoViewmodel.selectedIndex])
                ],
              ))
            ],
          ),
          _commonWidgetProvider.space(context, 10),
          TextButton(
            onPressed: () {
              _collectorTradeInfoViewmodel.deleteOpenTradeDeal();
            },
            style: _commonThemeProvider.buttonDesign(context, 90),
            child: const Text("Delete",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          )
        ],
      ),
    );
  }
}
