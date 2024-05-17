import 'package:varytrade_flutter/Model/closed_resale_deals.dart';
import 'package:varytrade_flutter/Model/create_resale_item.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/open_resale_deals.dart';

abstract class ResaleService {
  Future<OpenResaleDeals> retrieveAcceptableOpenResaleDeals(String token, int id, bool refreshed);
  Future<OpenResaleDeals> retrieveCollectorOpenResaleDeals(String token, int id, bool refreshed);
  Future<OpenResaleDeals> retrieveCollectorPendingResaleDeals(String token, int id, bool refreshed);
  Future<ClosedResaleDeals> retrieveCollectorClosedResaleDeals(String token, int id, bool refreshed);
  Future<OpenResaleDeals> retrieveProfileOpenResaleDeals(String token, String username, int id, bool refreshed);
  Future<GeneralResponse> processCreateResale(String token, CreateResaleItem createResaleItem, int id, bool refreshed);
  Future<GeneralResponse> deleteOpenResaleDeal(String token, int id, bool refreshed);
  Future<GeneralResponse> acceptResaleDealWithPayment(String token, int id, bool refreshed);
  Future<GeneralResponse> acceptResaleDealWithCredit(String token, int id, bool refreshed);
}