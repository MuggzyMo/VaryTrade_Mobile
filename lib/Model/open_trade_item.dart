class OpenTradeItem {
  int? _id;
  int? _openTradeDealId;
  String _name;
  String _condition;
  String? _userTradeItemAttrOne;
  String? _userTradeItemAttrTwo;
  String? _userTradeItemAttrThree;

  OpenTradeItem(
      this._id,
      this._openTradeDealId,
      this._name,
      this._condition,
      this._userTradeItemAttrOne,
      this._userTradeItemAttrTwo,
      this._userTradeItemAttrThree);

  factory OpenTradeItem.fromJson(Map<String, dynamic> json) {
    return OpenTradeItem(
        json["id"],
        json["openTradeDealId"],
        json["name"],
        json["condition"],
        json["userTradeItemAttrOne"],
        json["userTradeItemAttrTwo"],
        json["userTradeItemAttrThree"]);
  }

  get id => _id;

  set id(value) => _id = value;

  get openTradeDealId => _openTradeDealId;

  set openTradeDealId(value) => _openTradeDealId = value;

  get name => _name;

  set name(value) => _name = value;

  get condition => _condition;

  set condition(value) => _condition = value;

  get userTradeItemAttrOne => _userTradeItemAttrOne;

  set userTradeItemAttrOne(value) => _userTradeItemAttrOne = value;

  get userTradeItemAttrTwo => _userTradeItemAttrTwo;

  set userTradeItemAttrTwo(value) => _userTradeItemAttrTwo = value;

  get userTradeItemAttrThree => _userTradeItemAttrThree;

  set userTradeItemAttrThree(value) => _userTradeItemAttrThree = value;

  String getAttrs() {
    String attrs = "\n$condition\n\n";
    userTradeItemAttrOne != null
        ? attrs = "${attrs + userTradeItemAttrOne}\n\n"
        : null;
    userTradeItemAttrTwo != null
        ? attrs = "${attrs + userTradeItemAttrTwo}\n\n"
        : null;
    userTradeItemAttrThree != null
        ? attrs = "${attrs + userTradeItemAttrThree}\n\n"
        : null;
    return attrs;
  }
}
