import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/Widget/open_trade_item_list.dart';

import '../Model/company.dart';

class CollectorPendingTradeDetails extends StatelessWidget {
  CollectorPendingTradeDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CollectorTradeInfoViewmodel _collectorTradeInfoViewmodel =
      _getIt.get<CollectorTradeInfoViewmodel>();
  late final Future<Company> _futureCompany =
      _collectorTradeInfoViewmodel.companyInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Pending ${_collectorTradeInfoViewmodel.openTradeDeals.collectibleType} Trade"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(
        children: [
          Text("ID: ${_collectorTradeInfoViewmodel.selectedOpenTradeDeal.id}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Posted: ${_collectorTradeInfoViewmodel.selectedOpenTradeDeal.postDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Accepted: ${_collectorTradeInfoViewmodel.selectedOpenTradeDeal.acceptDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          Row(
            children: [
              Expanded(
                  child: Column(
                children: [
                  _commonWidgetProvider.space(context, 10),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Collectibles traded by ",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    TextSpan(
                        text:
                            "${_collectorTradeInfoViewmodel.openTradeDeals.posterUserNames[_collectorTradeInfoViewmodel.selectedIndex]}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _collectorTradeInfoViewmodel.displayProfile(
                                _collectorTradeInfoViewmodel
                                        .openTradeDeals.posterUserNames[
                                    _collectorTradeInfoViewmodel
                                        .selectedIndex]);
                          })
                  ])),
                  OpenTradeItemList(_collectorTradeInfoViewmodel
                          .openTradeDeals.posterTradeItems[
                      _collectorTradeInfoViewmodel.selectedIndex])
                ],
              )),
              Expanded(
                  child: Column(
                children: [
                  _commonWidgetProvider.space(context, 10),
                  RichText(
                      text: TextSpan(children: <TextSpan>[
                    const TextSpan(
                        text: "Collectibles traded by ",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    TextSpan(
                        text:
                            "${_collectorTradeInfoViewmodel.openTradeDeals.accepterUserNames[_collectorTradeInfoViewmodel.selectedIndex]}",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            _collectorTradeInfoViewmodel.displayProfile(
                                _collectorTradeInfoViewmodel
                                        .openTradeDeals.accepterUserNames[
                                    _collectorTradeInfoViewmodel
                                        .selectedIndex]);
                          })
                  ])),
                  OpenTradeItemList(_collectorTradeInfoViewmodel
                          .openTradeDeals.accepterTradeItems[
                      _collectorTradeInfoViewmodel.selectedIndex])
                ],
              ))
            ],
          ),
          _commonWidgetProvider.space(context, 10),
          FutureBuilder(
              future: _futureCompany,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      "Include in the shipping box a paper with your username, the trade ID, and the items you are trading. Ship items to: ${snapshot.data!.address}, ${snapshot.data!.city}, ${snapshot.data!.state} ${snapshot.data!.zipCode}");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
