import 'package:flutter/material.dart';
import 'package:varytrade_flutter/Model/open_trade_item.dart';

class OpenTradeItemList extends StatelessWidget {
  const OpenTradeItemList(this._openTradeItems, {super.key});

  final List<OpenTradeItem> _openTradeItems;

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
            itemCount: _openTradeItems.length,
            itemBuilder: (context, index) {
              OpenTradeItem openTradeItem = _openTradeItems[index];

              return ListTile(
                  title: Text(
                    "${openTradeItem.name}",
                  ),
                  subtitle: Text(openTradeItem.getAttrs()));
            }));
  }
}
