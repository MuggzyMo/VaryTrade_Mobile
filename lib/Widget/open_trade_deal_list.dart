import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Model/open_trade_item.dart';
import 'package:varytrade_flutter/ViewModel/open_trade_deal_viewmodel.dart';
import 'package:varytrade_flutter/Widget/open_trade_item_list.dart';
import 'dart:developer' as developer;

class OpenTradeDealList extends StatefulWidget {
  const OpenTradeDealList(this._id, {super.key});
  final int _id;

  @override
  State<OpenTradeDealList> createState() => _OpenTradeDealListState();
}

class _OpenTradeDealListState extends State<OpenTradeDealList> {
  final GetIt _getIt = GetIt.instance;
  late final OpenTradeDealViewmodel _openTradeDealListViewmodel =
      _getIt.get<OpenTradeDealViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();

  @override
  void initState() {
    super.initState();
    _openTradeDealListViewmodel.retrieveAcceptableOpenTradeDeals(widget._id);
    _openTradeDealListViewmodel.onListLoadingChanged = () => setState(() {
          developer.log("retrieve");
        });
  }

  @override
  void dispose() {
    _openTradeDealListViewmodel.listLoading = true;
    _openTradeDealListViewmodel.selectedLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _openTradeDealListViewmodel.listLoading
            ? const CircularProgressIndicator()
            : Text(
                "Open ${_openTradeDealListViewmodel.openTradeDeals.collectibleType.toString()} Trades"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: _openTradeDealListViewmodel.listLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color.fromRGBO(52, 58, 64, 1),
                      );
                    },
                    itemCount: _openTradeDealListViewmodel
                        .openTradeDeals.openTradeDeals.length,
                    itemBuilder: (context, index) {
                      final String poster = _openTradeDealListViewmodel
                          .openTradeDeals.posterUserNames[index];
                      final String datePosted = _openTradeDealListViewmodel
                          .openTradeDeals.openTradeDeals[index].postDate;
                      final List<OpenTradeItem> posterTradeItems =
                          _openTradeDealListViewmodel
                              .openTradeDeals.posterTradeItems[index];
                      final List<OpenTradeItem> accepterTradeItems =
                          _openTradeDealListViewmodel
                              .openTradeDeals.accepterTradeItems[index];
                      return ListTile(
                          title: RichText(
                              text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "Poster: $poster\n",
                                style: const TextStyle(decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    _openTradeDealListViewmodel.displayProfile(poster);
                                  }),
                            TextSpan(text: "Date Posted: $datePosted")
                          ],
                          style: const TextStyle(color: Colors.black))),
                          subtitle: InkWell(
                              child: Row(children: <Widget>[
                            Expanded(
                              child: Column(
                                children: [
                                  _commonWidgetProvider.space(context, 10),
                                  const Text("Items you will trade:",
                                      style: TextStyle(color: Colors.black)),
                                  OpenTradeItemList(posterTradeItems)
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              children: [
                                _commonWidgetProvider.space(context, 10),
                                const Text(
                                  "Items you will receive:",
                                  style: TextStyle(color: Colors.black),
                                ),
                                OpenTradeItemList(accepterTradeItems)
                              ],
                            ))
                          ])),
                          onTap: () {
                            _openTradeDealListViewmodel.displayOpenTradeDetails(index);
                          },);
                    }))
      ]),
    );
  }
}
