import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/open_resale_deal_viewmodel.dart';

class OpenResaleDetails extends StatelessWidget {
  OpenResaleDetails({super.key});

  final GetIt _getIt = GetIt.instance;
  late final OpenResaleDealViewmodel _openResaleDealViewmodel =
      _getIt.get<OpenResaleDealViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
              "Open ${_openResaleDealViewmodel.openResaleDeals.collectibleType} Resale"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          if (_openResaleDealViewmodel.openResaleDeals.posterUserNames != null)
            RichText(
                text: TextSpan(
                    text:
                        "Poster: ${_openResaleDealViewmodel.openResaleDeals.posterUserNames[_openResaleDealViewmodel.selectedIndex]}",
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.black,
                        fontSize: 15),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        _openResaleDealViewmodel.displayProfile(
                            _openResaleDealViewmodel
                                    .openResaleDeals.posterUserNames[
                                _openResaleDealViewmodel.selectedIndex]);
                      })),
          _commonWidgetProvider.space(context, 10),
          Text(
              "Date Posted: ${_openResaleDealViewmodel.selectedOpenResaleDeal.postDate}",
              style: const TextStyle(color: Colors.black, fontSize: 15)),
          _commonWidgetProvider.space(context, 10),
          Card(
              child: Column(children: [
            Text("${_openResaleDealViewmodel.selectedOpenResaleDeal.name}",
                style: const TextStyle(color: Colors.black, fontSize: 15)),
            Text(_openResaleDealViewmodel.selectedOpenResaleDeal.getAttrs(),
                style: const TextStyle(color: Colors.black, fontSize: 15)),
          ])),
          _commonWidgetProvider.space(context, 20),
          TextButton(
            onPressed: () {
              _openResaleDealViewmodel.acceptOpenResaleDealWithCredit();
            },
            style: _commonThemeProvider.buttonDesign(context, 90),
            child: const Text("Use Account Credits",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
          _commonWidgetProvider.space(context, 20),
          TextButton(
            onPressed: () async {
              BraintreeDropInRequest request = BraintreeDropInRequest(
                  tokenizationKey: "", // Will not work using client key
                  collectDeviceData: true,
                  vaultManagerEnabled: true,
                  cardEnabled: true,
                  venmoEnabled: false,
                  googlePaymentRequest: null,
                  applePayRequest: null,
                  paypalRequest: BraintreePayPalRequest(
                    amount: _openResaleDealViewmodel
                        .selectedOpenResaleDeal.price
                        .toString(),
                  ));
              BraintreeDropInResult? result =
                  await BraintreeDropIn.start(request);
              if (result != null) {
                _openResaleDealViewmodel.acceptOpenResaleDealWithPayment();
              } else {
                _openResaleDealViewmodel.displayPaymentFailed();
              }
            } /* async {
                  _openResaleDealViewmodel
                      .retrieveBraintreeToken()!
                      .then((value) {
                    BraintreeDropInRequest request = BraintreeDropInRequest(
                        clientToken: value,
                        collectDeviceData: true,
                        vaultManagerEnabled: true,
                        cardEnabled: true,
                        venmoEnabled: false,
                        googlePaymentRequest: null,
                        applePayRequest: null,
                        paypalRequest: BraintreePayPalRequest(
                          amount: "15.00",
                        ));
                    BraintreeDropIn.start(request).then((value) {
                      if (value != null) {
                        _openResaleDealViewmodel
                            .acceptOpenResaleDealWithPayment();
                      } else {
                        _openResaleDealViewmodel.displayPaymentFailed();
                      }
                    });
                  }); 
            } */
            ,
            style: _commonThemeProvider.buttonDesign(context, 90),
            child: const Text("PayPal",
                style: TextStyle(color: Colors.white, fontSize: 20)),
          )
        ]))));
  }
}
