import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Model/open_trade_item.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/Widget/open_trade_item_list.dart';
import 'dart:developer' as developer;

class CollectorOpenTradeDealList extends StatefulWidget {
  const CollectorOpenTradeDealList(this._id, {super.key});

  final int _id;

  @override
  State<CollectorOpenTradeDealList> createState() =>
      _CollectorOpenTradeDealListState();
}

class _CollectorOpenTradeDealListState
    extends State<CollectorOpenTradeDealList> {
  final GetIt _getIt = GetIt.instance;
  late final CollectorTradeInfoViewmodel _collectorTradeInfoViewmodel =
      _getIt.get<CollectorTradeInfoViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();

  @override
  void initState() {
    super.initState();
    _collectorTradeInfoViewmodel.retrieveCollectorOpenTradeDeals(widget._id);
    _collectorTradeInfoViewmodel.onListLoadingChanged = () => setState(() {
          developer.log("retrieve");
        });
  }

  @override
  void dispose() {
    _collectorTradeInfoViewmodel.listLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _collectorTradeInfoViewmodel.listLoading
            ? const CircularProgressIndicator()
            : Text(
                "Your Open ${_collectorTradeInfoViewmodel.openTradeDeals.collectibleType} Trades"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(children: <Widget>[
        Expanded(
            child: _collectorTradeInfoViewmodel.listLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color.fromRGBO(52, 58, 64, 1),
                      );
                    },
                    itemCount: _collectorTradeInfoViewmodel
                        .openTradeDeals.openTradeDeals.length,
                    itemBuilder: (context, index) {
                      final String id = _collectorTradeInfoViewmodel
                          .openTradeDeals.openTradeDeals[index].id
                          .toString();
                      final String datePosted = _collectorTradeInfoViewmodel
                          .openTradeDeals.openTradeDeals[index].postDate;
                      final List<OpenTradeItem> posterTradeItems =
                          _collectorTradeInfoViewmodel
                              .openTradeDeals.posterTradeItems[index];
                      final List<OpenTradeItem> accepterTradeItems =
                          _collectorTradeInfoViewmodel
                              .openTradeDeals.accepterTradeItems[index];
                      return InkWell(
                          onTap: () {
                            _collectorTradeInfoViewmodel
                                .displayCollectorOpenTradeDetails(index);
                          },
                          child: ListTile(
                              title: Text("ID: $id\nDate Posted: $datePosted"),
                              subtitle: Row(children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: [
                                      _commonWidgetProvider.space(context, 10),
                                      const Text("Items you will trade:",
                                          style:
                                              TextStyle(color: Colors.black)),
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
                              ])));
                    }))
      ]),
    );
  }
}
