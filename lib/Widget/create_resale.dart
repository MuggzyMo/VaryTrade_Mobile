import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/create_viewmodel.dart';
import 'dart:developer' as developer;

class CreateResale extends StatefulWidget {
  const CreateResale(this._id, {super.key});

  final int _id;

  @override
  State<CreateResale> createState() => _CreateResaleState();
}

class _CreateResaleState extends State<CreateResale> {
  final _formKey = GlobalKey<FormState>();
  final GetIt _getIt = GetIt.instance;
  final TextEditingController _price = TextEditingController(text: "0.00");
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
                        "Create a ${snapshot.data![widget._id - 1]} Resale");
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
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text(
                          "Name",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        DropdownButtonFormField(
                            value: _createViewmodel.resaleItem!.name,
                            isExpanded: true,
                            items: _createViewmodel.tradeItems
                                .map<DropdownMenuItem<String>>((String string) {
                              return DropdownMenuItem<String>(
                                value: string,
                                child: Text(string),
                              );
                            }).toList(),
                            onChanged: ((value) {
                              _createViewmodel.resaleItem!.name = value;
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
                              _createViewmodel.resaleItem!.condition = value;
                            })),
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
                                    .resaleItem!.userResaleItemAttrOne = value;
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
                                    .resaleItem!.userResaleItemAttrTwo = value;
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
                                    .resaleItem!.userResaleItemAttrThree = value;
                              })),
                        if (_createViewmodel.attributeNames!.length > 2)
                          _commonWidgetProvider.space(context, 10),
                        const Text(
                          "Price: \$",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        TextFormField(
                          controller: _price,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          validator: (value) {
                            if (value!.isEmpty || value.trim().isEmpty) {
                              return "Enter an amount between \$0.01 and \$100,000,000.00";
                            } else {
                              return null;
                            }
                          },
                        ),
                        _commonWidgetProvider.space(context, 20),
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              developer.log(_price.text);
                              _createViewmodel.resaleItem!.price = Decimal.fromJson(_price.text.toString());
                              _createViewmodel.processCreateResale(widget._id);
                            }
                          },
                          style: _commonThemeProvider.buttonDesign(context, 60),
                          child: const Text(
                            "Create Resale",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ],
                    ))));
  }
}
