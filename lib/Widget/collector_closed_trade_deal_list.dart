import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Model/closed_trade_deals.dart';
import 'package:varytrade_flutter/Model/closed_trade_item.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/Widget/closed_trade_item_list.dart';

class CollectorClosedTradeDealList extends StatelessWidget {
  CollectorClosedTradeDealList(this._id, {super.key});

  final int _id;
  final GetIt _getIt = GetIt.instance;
  late final CollectorTradeInfoViewmodel _collectorTradeInfoViewmodel =
      _getIt.get<CollectorTradeInfoViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final Future<ClosedTradeDeals> _closedTradeDeals =
      _collectorTradeInfoViewmodel.retrieveCollectorClosedTradeDeals(_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FutureBuilder<ClosedTradeDeals>(
              future: _closedTradeDeals,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      "Your Closed ${snapshot.data!.collectibleType} Trades");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: Column(children: <Widget>[
          Expanded(
              child: FutureBuilder(
            future: _closedTradeDeals,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color.fromRGBO(52, 58, 64, 1),
                    );
                  },
                  itemCount: snapshot.data!.closedTradeDeals.length,
                  itemBuilder: (context, index) {
                    final String poster = snapshot.data!.posterUserNames[index];
                    final String accepter =
                        snapshot.data!.accepterUserNames[index];
                    final String id =
                        snapshot.data!.closedTradeDeals[index].id.toString();
                    final String datePosted =
                        snapshot.data!.closedTradeDeals[index].postDate;
                    final String dateAccepted =
                        snapshot.data!.closedTradeDeals[index].acceptDate;
                    final List<ClosedTradeItem> posterTradeItems =
                        snapshot.data!.posterTradeItems[index];
                    final List<ClosedTradeItem> accepterTradeItems =
                        snapshot.data!.accepterTradeItems[index];
                    final String authenticatedDate = snapshot
                        .data!.closedTradeDeals[index].authenticatedDate;
                    final String authenticityStatus = snapshot
                        .data!.closedTradeDeals[index].authenticityStatus;
                    return ListTile(
                        title: Text(
                            "ID: $id\nDate Posted: $datePosted\nDate Accepted: $dateAccepted\nAuthenticated Date: $authenticatedDate\nAuthenticity Status: $authenticityStatus"),
                        subtitle: Row(children: <Widget>[
                          Expanded(
                            child: Column(
                              children: [
                                _commonWidgetProvider.space(context, 10),
                                RichText(
                                    text: TextSpan(children: <TextSpan>[
                                  const TextSpan(
                                      text: "Collectibles traded by ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15)),
                                  TextSpan(
                                      text: poster,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          decoration: TextDecoration.underline),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          _collectorTradeInfoViewmodel
                                              .displayProfile(poster);
                                        })
                                ])),
                                ClosedTradeItemList(posterTradeItems)
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            children: [
                              _commonWidgetProvider.space(context, 10),
                              RichText(
                                  text: TextSpan(children: <TextSpan>[
                                const TextSpan(
                                    text: "Collectibles traded by ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 15)),
                                TextSpan(
                                    text: accepter,
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _collectorTradeInfoViewmodel
                                            .displayProfile(accepter);
                                      })
                              ])),
                              ClosedTradeItemList(accepterTradeItems)
                            ],
                          ))
                        ]));
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ))
        ]));
  }
}
