import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/payout.dart';
import 'package:varytrade_flutter/ViewModel/payout_list_viewmodel.dart';

class PayoutList extends StatelessWidget {
  PayoutList({super.key});

  final GetIt _getIt = GetIt.instance;
  late final PayoutListViewModel _payoutListViewModel =
      _getIt.get<PayoutListViewModel>();
  late final Future<List<Payout>> _payouts =
      _payoutListViewModel.retrievePayouts();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Payout History"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: Column(children: <Widget> [Expanded(
            child: FutureBuilder(
                future: _payouts,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider(color: Color.fromRGBO(52, 58, 64, 1),);
                      },
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final Payout payout = snapshot.data![index];
                        return ListTile(
                          title: Text("ID: ${payout.id}"),
                          subtitle: Text(
                              "Amount: ${payout.amount}\nDate: ${payout.date}"),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }))]));
  }
}
