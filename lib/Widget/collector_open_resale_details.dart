import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';

class CollectorOpenResaleDetails extends StatelessWidget {
  CollectorOpenResaleDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final CollectorResaleInfoViewmodel _collectorResaleInfoViewmodel =
      _getIt.get<CollectorResaleInfoViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Your Open ${_collectorResaleInfoViewmodel.openResaleDeals.collectibleType} Resale"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: Center(
            child: Column(children: [
          Text("ID: ${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.id}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Posted: ${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.postDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Card(
              child: Column(children: [
            Text("${_collectorResaleInfoViewmodel.selectedOpenResaleDeal.name}",
                style: const TextStyle(color: Colors.black, fontSize: 15)),
            Text(
                _collectorResaleInfoViewmodel.selectedOpenResaleDeal.getAttrs(),
                style: const TextStyle(color: Colors.black, fontSize: 15)),
          ])),
          _commonWidgetProvider.space(context, 10),
          TextButton(
            onPressed: () {
              _collectorResaleInfoViewmodel.deleteOpenResaleDeal();
            },
            style: _commonThemeProvider.buttonDesign(context, 90),
            child: const Text("Delete",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          )
        ])));
  }
}
