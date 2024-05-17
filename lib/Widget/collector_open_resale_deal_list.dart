import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/open_resale_deal.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';
import 'dart:developer' as developer;

class CollectorOpenResaleDealList extends StatefulWidget {
  const CollectorOpenResaleDealList(this._id, {super.key});

  final int _id;

  @override
  State<StatefulWidget> createState() => _CollectorOpenResaleDealListState();
}

class _CollectorOpenResaleDealListState
    extends State<CollectorOpenResaleDealList> {
  final GetIt _getIt = GetIt.instance;
  late final CollectorResaleInfoViewmodel _collectorResaleInfoViewmodel =
      _getIt.get<CollectorResaleInfoViewmodel>();

  @override
  void initState() {
    super.initState();
    _collectorResaleInfoViewmodel.retrieveCollectorOpenResaleDeals(widget._id);
    _collectorResaleInfoViewmodel.onListLoadingChanged = () => setState(() {
          developer.log("retrieve");
        });
  }

  @override
  void dispose() {
    _collectorResaleInfoViewmodel.listLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _collectorResaleInfoViewmodel.listLoading
            ? const CircularProgressIndicator()
            : Text(
                "Your Open ${_collectorResaleInfoViewmodel.openResaleDeals.collectibleType.toString()} Resales"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: _collectorResaleInfoViewmodel.listLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color.fromRGBO(52, 58, 64, 1),
                    );
                  },
                  itemCount: _collectorResaleInfoViewmodel
                      .openResaleDeals.openResaleDeals.length,
                  itemBuilder: (context, index) {
                    final String id = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].id
                        .toString();
                    final String datePosted = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].postDate;
                    final OpenResaleDeal openResaleDeal =
                        _collectorResaleInfoViewmodel
                            .openResaleDeals.openResaleDeals[index];
                    return InkWell(
                        onTap: () {
                          _collectorResaleInfoViewmodel
                              .displayCollectorOpenResaleDetails(index);
                        },
                        child: ListTile(
                          title: Text(
                              "ID: $id\nDate Posted: $datePosted\n\n${openResaleDeal.name}"),
                          subtitle: Text(openResaleDeal.getAttrs()),
                        ));
                  },
                ),
        )
      ]),
    );
  }
}
