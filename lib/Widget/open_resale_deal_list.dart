import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/open_resale_deal.dart';
import 'package:varytrade_flutter/ViewModel/open_resale_deal_viewmodel.dart';
import 'dart:developer' as developer;

class OpenResaleDealList extends StatefulWidget {
  const OpenResaleDealList(this._id, {super.key});
  final int _id;

  @override
  State<OpenResaleDealList> createState() => _OpenResaleDealListState();
}

class _OpenResaleDealListState extends State<OpenResaleDealList> {
  final GetIt _getIt = GetIt.instance;
  late final OpenResaleDealViewmodel _openResaleDealListViewmodel =
      _getIt.get<OpenResaleDealViewmodel>();

  @override
  void initState() {
    super.initState();
    _openResaleDealListViewmodel.retrieveAcceptableOpenResaleDeals(widget._id);
    _openResaleDealListViewmodel.onListLoadingChanged = () => setState(() {
          developer.log("retrieve");
        });
  }

  @override
  void dispose() {
    _openResaleDealListViewmodel.listLoading = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _openResaleDealListViewmodel.listLoading
              ? const CircularProgressIndicator()
              : Text(
                  "Open ${_openResaleDealListViewmodel.openResaleDeals.collectibleType.toString()} Resales"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: Column(children: [
          Expanded(
            child: _openResaleDealListViewmodel.listLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Color.fromRGBO(52, 58, 64, 1),
                      );
                    },
                    itemCount: _openResaleDealListViewmodel
                        .openResaleDeals.openResaleDeals.length,
                    itemBuilder: (context, index) {
                      final String poster = _openResaleDealListViewmodel
                          .openResaleDeals.posterUserNames[index];
                      final String datePosted = _openResaleDealListViewmodel
                          .openResaleDeals.openResaleDeals[index].postDate;
                      final OpenResaleDeal openResaleDeal =
                          _openResaleDealListViewmodel
                              .openResaleDeals.openResaleDeals[index];
                      return ListTile(
                          title: RichText(
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "Poster: $poster\n",
                                  style: const TextStyle(decoration: TextDecoration.underline),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _openResaleDealListViewmodel.displayProfile(poster);
                                    }),
                              TextSpan(
                                  text:
                                      "Date Posted: $datePosted\n\n${openResaleDeal.name}")
                            ], style: const TextStyle(color: Colors.black)),
                          ),
                          subtitle: InkWell(
                            child: Text(openResaleDeal.getAttrs()),
                            onTap: () {
                              _openResaleDealListViewmodel.displayOpenResaleDetails(index);
                            },
                          ));
                    },
                  ),
          )
        ]));
  }
}
