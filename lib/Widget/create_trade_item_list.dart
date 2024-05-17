import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/create_trade_item.dart';
import 'package:varytrade_flutter/ViewModel/create_viewmodel.dart';

class CreateTradeItemList extends StatelessWidget {
  CreateTradeItemList(this._list, this._tradeItems, {super.key});

  final List<CreateTradeItem> _tradeItems;
  final String _list;
  final GetIt _getIt = GetIt.instance;
  late final CreateViewmodel _createViewmodel = _getIt.get<CreateViewmodel>();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider(
                color: Color.fromRGBO(52, 58, 64, 1),
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _tradeItems.length,
            itemBuilder: (context, index) {
              CreateTradeItem tradeItem = _tradeItems[index];

              return Column(children: [
                ListTile(
                    title: Text(
                      "${tradeItem.name}",
                    ),
                    subtitle: Text(tradeItem.getAttrs())),
                InkWell(
                  onTap: () {
                    if (_list == "poster") {
                      _createViewmodel
                          .removeTradeItemFromPosterTradeItems(tradeItem);
                    } else {
                      _createViewmodel
                          .removeTradeItemFromAccepterTradeItems(tradeItem);
                    }
                  },
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                        color: Colors.black,
                        decoration: TextDecoration.underline),
                  ),
                )
              ]);
            }));
  }
}
