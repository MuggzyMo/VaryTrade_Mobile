import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/create_viewmodel.dart';
import 'package:varytrade_flutter/Widget/create_trade_item_list.dart';
import 'dart:developer' as developer;

class CreateTrade extends StatefulWidget {
  const CreateTrade(this._id, {super.key});

  final int _id;

  @override
  State<CreateTrade> createState() => _CreateTradeState();
}

class _CreateTradeState extends State<CreateTrade> {
  final _formKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;
  late final CreateViewmodel _createViewmodel = _getIt.get<CreateViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();
  late final Future<List<String>> _collectibleNames =
      _createViewmodel.collectibleNames();

  @override
  void initState() {
    super.initState();
    _createViewmodel.retrieveFormValues(widget._id);
    _createViewmodel.onFormValuesLoaded = () => setState(() {
          developer.log("retrieve");
        });
    _createViewmodel.onTradeDealItemsChange = () => setState(() {});
  }

  @override
  void dispose() {
    _createViewmodel.formValuesLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: FutureBuilder(
              future: _collectibleNames,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                      "Create a ${snapshot.data![widget._id - 1]} Trade");
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              }),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1)),
      body: _createViewmodel.formValuesLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(children: [
                Row(
                  children: [
                    if (!_createViewmodel.posterTradeItems.isEmpty)
                      Expanded(
                          child: Column(
                        children: [
                          const Text(
                            "Items you wish to trade:",
                            style: TextStyle(color: Colors.black),
                          ),
                          CreateTradeItemList(
                              "poster", _createViewmodel.posterTradeItems)
                        ],
                      )),
                    if (!_createViewmodel.accepterTradeItems.isEmpty)
                      Expanded(
                          child: Column(
                        children: [
                          const Text(
                            "Items you wish to receive:",
                            style: TextStyle(color: Colors.black),
                          ),
                          CreateTradeItemList(
                              "accepter", _createViewmodel.accepterTradeItems)
                        ],
                      ))
                  ],
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        DropdownButtonFormField(
                            value: _createViewmodel.tradeItem!.name,
                            isExpanded: true,
                            items: _createViewmodel.tradeItems
                                .map<DropdownMenuItem<String>>((String string) {
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string),
                              );
                            }).toList(),
                            onChanged: ((value) {
                              _createViewmodel.tradeItem!.name = value;
                            })),
                        _commonWidgetProvider.space(context, 10),
                        const Text(
                          "Condition",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        DropdownButtonFormField(
                            value: _createViewmodel.conditions[0],
                            isExpanded: true,
                            items: _createViewmodel.conditions
                                .map<DropdownMenuItem<String>>((String string) {
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string),
                              );
                            }).toList(),
                            onChanged: ((value) {
                              _createViewmodel.tradeItem!.condition = value;
                            })),
                        _commonWidgetProvider.space(context, 10),
                        const Text(
                          "Do you want to trade this item or receive this item in the trade?",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        RadioListTile<String>(
                            title: const Text(
                              "Trade",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: "Trade",
                            groupValue: _createViewmodel.tradeOption,
                            onChanged: (value) {
                              setState(() {
                                _createViewmodel.tradeOption = value;
                              });
                            }),
                        RadioListTile<String>(
                            title: const Text(
                              "Receive",
                              style: TextStyle(color: Colors.black),
                            ),
                            value: "Receive",
                            groupValue: _createViewmodel.tradeOption,
                            onChanged: (value) {
                              setState(() {
                                _createViewmodel.tradeOption = value;
                              });
                            }),
                        if (!_createViewmodel.attributeNames!.isEmpty)
                          _commonWidgetProvider.space(context, 10),
                        if (!_createViewmodel.attributeNames!.isEmpty)
                          Text("${_createViewmodel.attributeNames[0]}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        if (!_createViewmodel.attributeNames!.isEmpty)
                          _commonWidgetProvider.space(context, 10),
                        if (!_createViewmodel.attributeNames!.isEmpty)
                          DropdownButtonFormField(
                              value: _createViewmodel.attributeOneValues![0],
                              isExpanded: true,
                              items: _createViewmodel.attributeOneValues!
                                  .map<DropdownMenuItem<String>>(
                                      (String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(string),
                                );
                              }).toList(),
                              onChanged: ((value) {
                                _createViewmodel
                                    .tradeItem!.userTradeItemAttrOne = value;
                              })),
                        if (_createViewmodel.attributeNames!.length > 1)
                          _commonWidgetProvider.space(context, 10),
                        if (_createViewmodel.attributeNames!.length > 1)
                          Text("${_createViewmodel.attributeNames[1]}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        if (_createViewmodel.attributeNames!.length > 1)
                          _commonWidgetProvider.space(context, 10),
                        if (_createViewmodel.attributeNames!.length > 1)
                          DropdownButtonFormField(
                              value: _createViewmodel.attributeTwoValues![0],
                              isExpanded: true,
                              items: _createViewmodel.attributeTwoValues!
                                  .map<DropdownMenuItem<String>>(
                                      (String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(string),
                                );
                              }).toList(),
                              onChanged: ((value) {
                                _createViewmodel
                                    .tradeItem!.userTradeItemAttrTwo = value;
                              })),
                        if (_createViewmodel.attributeNames!.length > 2)
                          _commonWidgetProvider.space(context, 10),
                        if (_createViewmodel.attributeNames!.length > 2)
                          Text("${_createViewmodel.attributeNames[2]}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 18)),
                        if (_createViewmodel.attributeNames!.length > 2)
                          _commonWidgetProvider.space(context, 10),
                        if (_createViewmodel.attributeNames!.length > 2)
                          DropdownButtonFormField(
                              value: _createViewmodel.attributeThreeValues![0],
                              isExpanded: true,
                              items: _createViewmodel.attributeThreeValues!
                                  .map<DropdownMenuItem<String>>(
                                      (String string) {
                                return DropdownMenuItem<String>(
                                  value: string,
                                  child: Text(string),
                                );
                              }).toList(),
                              onChanged: ((value) {
                                _createViewmodel
                                    .tradeItem!.userTradeItemAttrThree = value;
                              })),
                        _commonWidgetProvider.space(context, 20),
                        TextButton(
                          onPressed: () {
                            _createViewmodel.addTradeItem();
                            _formKey.currentState!.reset();
                          },
                          style: _commonThemeProvider.buttonDesign(context, 60),
                          child: const Text(
                            "Add to Trade",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        _commonWidgetProvider.space(context, 10),
                        TextButton(
                          onPressed: () {
                            _createViewmodel.processCreateTrade(widget._id);
                          },
                          style: _commonThemeProvider.buttonDesign(context, 60),
                          child: const Text(
                            "Create Trade",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ))
              ]),
            ),
    );
  }
}
