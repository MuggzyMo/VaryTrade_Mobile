import 'package:varytrade_flutter/Model/closed_trade_deals.dart';
import 'package:varytrade_flutter/Model/create_trade_item.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_trade_deals.dart';

abstract class TradeService {
  Future<List<String>> retrieveCollectibleNames(String token, bool refreshed);
  Future<OpenTradeDeals> retrieveAcceptableOpenTradeDeals(
      String token, int id, bool refreshed);
  Future<OpenTradeDeals> retrieveCollectorPendingTradeDeals(
      String token, int id, bool refreshed);
  Future<OpenTradeDeals> retrieveCollectorOpenTradeDeals(
      String token, int id, bool refreshed);
  Future<ClosedTradeDeals> retrieveCollectorClosedTradeDeals(
      String token, int id, bool refreshed);
  Future<OpenTradeDeals> retrieveProfileOpenTradeDeals(
      String token, String username, int id, bool refreshed);
  Future<List<String>> retrieveTradeItems(String token, int id, bool refreshed);
  Future<List<String>> retrieveConditions(String token, int id, bool refreshed);
  Future<List<String>> retrieveTradeItemAttributeOneValues(
      String token, int id, bool refreshed);
  Future<List<String>> retrieveTradeItemAttributeTwoValues(
      String token, int id, bool refreshed);
  Future<List<String>> retrieveTradeItemAttributeThreeValues(
      String token, int id, bool refreshed);
  Future<List<String>> retrieveTradeItemAttributeNames(
      String token, int id, bool refreshed);
  Future<GeneralResponse> processCreateTrade(
      String token,
      List<CreateTradeItem> posterTradeItems,
      List<CreateTradeItem> accepterTradeItems,
      int id,
      bool refreshed);
  Future<GeneralResponse> deleteOpenTradeDeal(String token, int id, bool refreshed);
  Future<GeneralResponse> acceptTradeDealWithPayment(String token, int id, bool refreshed);
  Future<GeneralResponse> acceptTradeDealWithCredit(String token, int id, bool refreshed);
}
