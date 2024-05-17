import 'package:flutter/material.dart';
import 'package:varytrade_flutter/Model/closed_trade_item.dart';

class ClosedTradeItemList extends StatelessWidget {
  const ClosedTradeItemList(this._closedTradeItems, {super.key});

  final List<ClosedTradeItem> _closedTradeItems;

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
            itemCount: _closedTradeItems.length,
            itemBuilder: (context, index) {
              ClosedTradeItem closedTradeItem = _closedTradeItems[index];

              return ListTile(
                  title: Text(
                    "${closedTradeItem.name}",
                  ),
                  subtitle: Text(closedTradeItem.getAttrs()));
            }));
  }
}