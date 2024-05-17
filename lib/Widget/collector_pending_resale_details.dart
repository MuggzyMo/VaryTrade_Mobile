import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';

class CollectorPendingResaleDetails extends StatelessWidget {
  CollectorPendingResaleDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CollectorResaleInfoViewmodel _collectorResaleInfoViewmodel =
      _getIt.get<CollectorResaleInfoViewmodel>();
  late final Future<Company> _futureCompany =
      _collectorResaleInfoViewmodel.companyInfo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Pending ${_collectorResaleInfoViewmodel.openResaleDeals.collectibleType} Resale"),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(
        children: [
          Text("ID: ${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.id}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Posted: ${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.postDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Accepted: ${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.acceptDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Card(
              child: Column(
            children: [
              Text(
                  "${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.name}",
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
              Text(
                  _collectorResaleInfoViewmodel.selectedOpenResaleDeal
                      .getAttrs(),
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
            ],
          )),
          _commonWidgetProvider.space(context, 10),
          InkWell(
              child: Text(
                "Accepter: ${_collectorResaleInfoViewmodel.openResaleDeals.accepterUserNames[_collectorResaleInfoViewmodel.selectedIndex]}",
                style: const TextStyle(
                    decoration: TextDecoration.underline, fontSize: 15),
              ),
              onTap: () {
                _collectorResaleInfoViewmodel.displayProfile(
                    _collectorResaleInfoViewmodel
                            .openResaleDeals.accepterUserNames[
                        _collectorResaleInfoViewmodel.selectedIndex]);
              }),
          _commonWidgetProvider.space(context, 10),
          RichText(
              text: TextSpan(children: <TextSpan>[
            TextSpan(
                text:
                    "${_collectorResaleInfoViewmodel.openResaleDeals.posterUserNames[_collectorResaleInfoViewmodel.selectedIndex]}",
                style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                    fontSize: 15),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _collectorResaleInfoViewmodel.displayProfile(
                        _collectorResaleInfoViewmodel
                                .openResaleDeals.posterUserNames[
                            _collectorResaleInfoViewmodel.selectedIndex]);
                  }),
            const TextSpan(
              text:
                  ", the poster of this resale, must ship this item and include within the shipping box a paper with their username, the trade id, and the item they are reselling.",
              style: TextStyle(color: Colors.black, fontSize: 15),
            )
          ])),
          const Text("Ship item to:"),
          FutureBuilder(
              future: _futureCompany,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    "${snapshot.data!.address}, ${snapshot.data!.city}, ${snapshot.data!.state} ${snapshot.data!.zipCode}",
                    style: const TextStyle(fontSize: 15),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  return const CircularProgressIndicator();
                }
              })
        ],
      ),
    );
  }
}
