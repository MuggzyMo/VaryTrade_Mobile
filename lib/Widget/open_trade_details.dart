import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/open_trade_deal_viewmodel.dart';
import 'package:varytrade_flutter/Widget/open_trade_item_list.dart';

class OpenTradeDetails extends StatelessWidget {
  OpenTradeDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final OpenTradeDealViewmodel _openTradeDealViewmodel =
      _getIt.get<OpenTradeDealViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Open ${_openTradeDealViewmodel.openTradeDeals.collectibleType} Trade"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              if(_openTradeDealViewmodel.openTradeDeals.posterUserNames != null)
              RichText(
                  text: TextSpan(
                      text:
                          "Poster: ${_openTradeDealViewmodel.openTradeDeals.posterUserNames[_openTradeDealViewmodel.selectedIndex]}",
                      style:
                          const TextStyle(decoration: TextDecoration.underline, color: Colors.black, fontSize: 15),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _openTradeDealViewmodel.displayProfile(
                              _openTradeDealViewmodel
                                      .openTradeDeals.posterUserNames[
                                  _openTradeDealViewmodel.selectedIndex]);
                        })),
              _commonWidgetProvider.space(context, 10),
              Text(
                  "Date Posted: ${_openTradeDealViewmodel.selectedOpenTradeDeal.postDate}",
                  style: const TextStyle(color: Colors.black, fontSize: 15)),
              _commonWidgetProvider.space(context, 10),
              Row(
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      _commonWidgetProvider.space(context, 10),
                      const Text(
                        "Items you will receive:",
                        style: TextStyle(color: Colors.black),
                      ),
                      OpenTradeItemList(_openTradeDealViewmodel
                              .openTradeDeals.posterTradeItems[
                          _openTradeDealViewmodel.selectedIndex])
                    ],
                  )),
                  Expanded(
                      child: Column(
                    children: [
                      _commonWidgetProvider.space(context, 10),
                      const Text(
                        "Items you will trade:",
                        style: TextStyle(color: Colors.black),
                      ),
                      OpenTradeItemList(_openTradeDealViewmodel
                              .openTradeDeals.accepterTradeItems[
                          _openTradeDealViewmodel.selectedIndex])
                    ],
                  ))
                ],
              ),
              _commonWidgetProvider.space(context, 20),
              TextButton(
                onPressed: () {
                  _openTradeDealViewmodel.acceptOpenTradeDealWithCredit();
                },
                style: _commonThemeProvider.buttonDesign(context, 90),
                child: const Text("Use Account Credits",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
              _commonWidgetProvider.space(context, 20),
              TextButton(
                onPressed: ()async {
                  BraintreeDropInRequest request = BraintreeDropInRequest(
                      tokenizationKey: "", // Will not work using client key
                      collectDeviceData: true,
                      vaultManagerEnabled: true,
                      cardEnabled: true,
                      venmoEnabled: false,
                      googlePaymentRequest: null,
                      applePayRequest: null,
                      paypalRequest: BraintreePayPalRequest(
                        amount: "15.00",
                      ));
                  BraintreeDropInResult? result =
                      await BraintreeDropIn.start(request);
                  if (result != null) {
                    _openTradeDealViewmodel.acceptOpenTradeDealWithPayment();
                  } else {
                    _openTradeDealViewmodel.displayPaymentFailed();
                  }
                },
                style: _commonThemeProvider.buttonDesign(context, 90),
                child: const Text("PayPal",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              )
            ],
          ),
        ));
  }
}
