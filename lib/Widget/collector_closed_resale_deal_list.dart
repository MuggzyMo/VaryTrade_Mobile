import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/closed_resale_deals.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';

class CollectorClosedResaleDealList extends StatelessWidget {
  CollectorClosedResaleDealList(this._id, {super.key});

  final int _id;
  final GetIt _getIt = GetIt.instance;
  late final CollectorResaleInfoViewmodel _collectorResaleInfoViewmodel =
      _getIt.get<CollectorResaleInfoViewmodel>();
  late final Future<ClosedResaleDeals> _closedResaleDeals =
      _collectorResaleInfoViewmodel.retrieveCollectorClosedResaleDeals(_id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<ClosedResaleDeals>(
            future: _closedResaleDeals,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                    "Your Closed ${snapshot.data!.collectibleType} Resales");
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else {
                return const CircularProgressIndicator();
              }
            }),
        backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: FutureBuilder<ClosedResaleDeals>(
                  future: _closedResaleDeals,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                          itemBuilder: (context, index) {
                            final String id = snapshot
                                .data!.closedResaleDeals[index].id
                                .toString();
                            final String datePosted = snapshot
                                .data!.closedResaleDeals[index].postDate;
                            final String dateAccepted = snapshot
                                    .data!.closedResaleDeals[index].acceptDate =
                                snapshot
                                    .data!.closedResaleDeals[index].acceptDate;
                            final String name =
                                snapshot.data!.closedResaleDeals[index].name;
                            final String authenticityStatus = snapshot.data!
                                .closedResaleDeals[index].authenticityStatus;
                            final String authenticatedDate = snapshot.data!
                                .closedResaleDeals[index].authenticatedDate;
                            final String poster =
                                snapshot.data!.posterUserNames[index];
                            final String accepter =
                                snapshot.data!.accepterUserNames[index];
                            return ListTile(
                                title: RichText(
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "ID: $id\nDate Posted: $datePosted\n",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                    TextSpan(
                                        text: "\nPoster: $poster",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15, decoration: TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _collectorResaleInfoViewmodel
                                                .displayProfile(poster);
                                          }),
                                      TextSpan(
                                        text: "\nAccepter: $accepter",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15, decoration: TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            _collectorResaleInfoViewmodel
                                                .displayProfile(accepter);
                                          }),
                                      TextSpan(
                                        text:
                                            "\nDate Accepted: $dateAccepted\nAuthenticated Date: $authenticatedDate\nAuthenticity Status: $authenticityStatus\n\n$name",
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 15)),
                                  ]),
                                ),
                                subtitle: Text(snapshot
                                    .data!.closedResaleDeals[index]
                                    .getAttrs()));
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                                color: Color.fromRGBO(52, 58, 64, 1));
                          },
                          itemCount: snapshot.data!.closedResaleDeals.length);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }))
        ],
      ),
    );
  }
}
