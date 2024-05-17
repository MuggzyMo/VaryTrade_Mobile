import 'package:decimal/decimal.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/create_resale_item.dart';
import 'package:varytrade_flutter/Model/create_trade_item.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/resale_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';

class CreateViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  late final ResaleService _resaleService = _getIt.get<ResaleService>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  List<CreateTradeItem> _posterTradeItems = List.empty(growable: true);
  get posterTradeItems => _posterTradeItems;
  set posterTradeItems(posterTradeItems) =>
      _posterTradeItems = posterTradeItems;

  List<CreateTradeItem> _accepterTradeItems = List.empty(growable: true);
  get accepterTradeItems => _accepterTradeItems;
  set accepterTradeItems(accepterTradeItems) =>
      _accepterTradeItems = accepterTradeItems;

  Function()? onTradeDealItemsChange;

  CreateTradeItem? _tradeItem;

  CreateResaleItem? _resaleItem;

  String _tradeOption = "Trade";

  List<String>? _tradeItems;
  List<String>? _conditions;
  List<String>? _attributeOneValues;
  List<String>? _attributeTwoValues;
  List<String>? _attributeThreeValues;
  List<String>? _attributeNames;

  CreateTradeItem? get tradeItem => _tradeItem;

  CreateResaleItem? get resaleItem => _resaleItem;

  get tradeOption => _tradeOption;

  set tradeOption(value) => _tradeOption = value;

  set openTradeItem(value) => _tradeItem = value;

  get tradeItems => _tradeItems;

  set tradeItems(value) => _tradeItems = value;

  get conditions => _conditions;

  set conditions(value) => _conditions = value;

  get attributeOneValues => _attributeOneValues;

  set attributeOneValues(value) => _attributeOneValues = value;

  get attributeTwoValues => _attributeTwoValues;

  set attributeTwoValues(value) => _attributeTwoValues = value;

  get attributeThreeValues => _attributeThreeValues;

  set attributeThreeValues(value) => _attributeThreeValues = value;

  get attributeNames => _attributeNames;

  set attributeNames(value) => _attributeNames = value;

  bool _formValuesLoading = true;

  get formValuesLoading => _formValuesLoading;

  set formValuesLoading(value) => _formValuesLoading = value;

  Function()? onFormValuesLoaded;

  Future<void> retrieveFormValues(int id) async {
    String? token = await _secureStorage.getJwtToken();
    _tradeItems = await _tradeService.retrieveTradeItems(token!, id, false);
    _conditions = await _tradeService.retrieveConditions(token, id, false);
    _attributeOneValues = await _tradeService
        .retrieveTradeItemAttributeOneValues(token, id, false);
    _attributeTwoValues = await _tradeService
        .retrieveTradeItemAttributeTwoValues(token, id, false);
    _attributeThreeValues = await _tradeService
        .retrieveTradeItemAttributeThreeValues(token, id, false);
    _attributeNames =
        await _tradeService.retrieveTradeItemAttributeNames(token, id, false);
    await _initializeTradeItem();
    await _initializeResaleItem();
    _formValuesLoading = false;
    onFormValuesLoaded?.call();
  }

  Future<void> addTradeItem() async {
    if (_tradeOption == "Trade") {
      _posterTradeItems.add(_tradeItem!);
    } else {
      _accepterTradeItems.add(_tradeItem!);
    }
    await _initializeTradeItem();
    onTradeDealItemsChange?.call();
  }

  Future<void> removeTradeItemFromAccepterTradeItems(
      CreateTradeItem tradeItem) async {
    _accepterTradeItems.remove(tradeItem);
    onTradeDealItemsChange?.call();
  }

  Future<void> removeTradeItemFromPosterTradeItems(
      CreateTradeItem tradeItem) async {
    _posterTradeItems.remove(tradeItem);
    onTradeDealItemsChange?.call();
  }

  Future<List<String>> collectibleNames() async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectibleNames(token!, false);
  }

  void processCreateResale(int id) async {
    if ((Decimal.parse("0.01").compareTo(resaleItem!.price) > 0 ||
            Decimal.parse("100000000.00").compareTo(resaleItem!.price) < 0) ||
        (resaleItem!.price.toString().contains('.') &&
            resaleItem!.price.toString().length -
                    resaleItem!.price.toString().indexOf('.') >
                3)) {
      _navigation.displayErrorDialog(
          "Create Resale Error",
          GeneralResponse(
              422,
              List<String>.of([
                "Must sell for value between \$0.01 and \$100,000,000.00."
              ])));
    } else {
      String? token = await _secureStorage.getJwtToken();
      _resaleService.processCreateResale(token!, _resaleItem!, id, false);
      _displayCollectorResaleInfoAfterCreation();
    }
  }

  void processCreateTrade(int id) async {
    if (_posterTradeItems.isEmpty || _accepterTradeItems.isEmpty) {
      _navigation.displayErrorDialog(
          "Create Trade Error",
          GeneralResponse(
              422,
              List<String>.of([
                "Must have items you wish to trade and items you wish to receive."
              ])));
    } else {
      String? token = await _secureStorage.getJwtToken();
      _tradeService.processCreateTrade(
          token!, posterTradeItems, accepterTradeItems, id, false);
      _posterTradeItems = List.empty(growable: true);
      _accepterTradeItems = List.empty(growable: true);
      _displayCollectorTradeInfoAfterCreation();
    }
  }

  void _displayCollectorTradeInfoAfterCreation() {
    _navigation.pop();
    _navigation.displayCreateOpenTradeSuccessDialog();
  }

  void _displayCollectorResaleInfoAfterCreation() {
    _navigation.pop();
    _navigation.displayCreateOpenResaleSuccessDialog();
  }

  Future<void> _initializeTradeItem() async {
    _tradeItem = CreateTradeItem(
        -1,
        _tradeItems![0],
        _conditions![0],
        _attributeOneValues!.isEmpty ? null : _attributeOneValues![0],
        _attributeTwoValues!.isEmpty ? null : _attributeTwoValues![0],
        _attributeThreeValues!.isEmpty ? null : _attributeThreeValues![0]);
  }

  Future<void> _initializeResaleItem() async {
    _resaleItem = CreateResaleItem(
        Decimal.fromInt(0),
        _tradeItems![0],
        _conditions![0],
        _attributeOneValues!.isEmpty ? null : _attributeOneValues![0],
        _attributeTwoValues!.isEmpty ? null : _attributeTwoValues![0],
        _attributeThreeValues!.isEmpty ? null : _attributeThreeValues![0]);
  }
}
