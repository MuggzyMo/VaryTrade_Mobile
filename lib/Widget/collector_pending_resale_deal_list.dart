import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';
import 'dart:developer' as developer;

class CollectorPendingResaleDealList extends StatefulWidget {
  const CollectorPendingResaleDealList(this._id, {super.key});

  final int _id;

  @override
  State<CollectorPendingResaleDealList> createState() =>
      _CollectorPendingResaleDeaListState();
}

class _CollectorPendingResaleDeaListState
    extends State<CollectorPendingResaleDealList> {
  final GetIt _getIt = GetIt.instance;
  late final CollectorResaleInfoViewmodel _collectorResaleInfoViewmodel =
      _getIt.get<CollectorResaleInfoViewmodel>();

  @override
  void initState() {
    super.initState();
    _collectorResaleInfoViewmodel
        .retrieveCollectorPendingResaleDeals(widget._id);
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
                  "Your Pending ${_collectorResaleInfoViewmodel.openResaleDeals.collectibleType} Resales"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: _collectorResaleInfoViewmodel.listLoading
            ? const CircularProgressIndicator()
            : Column(children: <Widget>[
                Expanded(
                    child: ListView.separated(
                  itemCount: _collectorResaleInfoViewmodel
                      .openResaleDeals.openResaleDeals.length,
                  itemBuilder: (context, index) {
                    final String id = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].id
                        .toString();
                    final String datePosted = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].postDate;
                    final String dateAccepted = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].acceptDate;
                    final String name = _collectorResaleInfoViewmodel
                        .openResaleDeals.openResaleDeals[index].name;
                    return InkWell(
                      onTap: () {
                        _collectorResaleInfoViewmodel.displayCollectorPendingResaleDetails(index);
                      },
                        child: ListTile(
                            title: Text(
                                "ID: $id\nDate Posted: $datePosted\nDate Accepted: $dateAccepted\n\n$name"),
                            subtitle: Text(_collectorResaleInfoViewmodel
                                .openResaleDeals.openResaleDeals[index]
                                .getAttrs())));
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(color: Color.fromRGBO(52, 58, 64, 1));
                  },
                ))
              ]));
  }
}
