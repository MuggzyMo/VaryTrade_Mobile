class ClosedTradeItem {
  int _id;
  int _closedTradeDealId;
  String _name;
  String _condition;
  String? _userTradeItemAttrOne;
  String? _userTradeItemAttrTwo;
  String? _userTradeItemAttrThree;

  ClosedTradeItem(
      this._id,
      this._closedTradeDealId,
      this._name,
      this._condition,
      this._userTradeItemAttrOne,
      this._userTradeItemAttrTwo,
      this._userTradeItemAttrThree);

  factory ClosedTradeItem.fromJson(Map<String, dynamic> json) {
    return ClosedTradeItem(
        json["id"],
        json["closedTradeDealId"],
        json["name"],
        json["condition"],
        json["userTradeItemAttrOne"],
        json["userTradeItemAttrTwo"],
        json["userTradeItemAttrThree"]);
  }

  get id => _id;

  set id(value) => _id = value;

  get closedTradeDealId => _closedTradeDealId;

  set closedTradeDealId(value) => _closedTradeDealId = value;

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
    userTradeItemAttrOne != null ? attrs = "${attrs + userTradeItemAttrOne}\n\n" : null;
    userTradeItemAttrTwo != null ? attrs = "${attrs + userTradeItemAttrTwo}\n\n" : null;
    userTradeItemAttrThree != null ? attrs = "${attrs + userTradeItemAttrThree}\n\n" : null;
    return attrs;
  }
}