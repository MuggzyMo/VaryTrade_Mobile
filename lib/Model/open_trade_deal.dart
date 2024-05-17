class OpenTradeDeal {
  int _id;
  String _postDate;
  String? _acceptDate;
  int _itemType;

  OpenTradeDeal(this._id, this._postDate, this._acceptDate, this._itemType);

  factory OpenTradeDeal.fromJson(Map<String, dynamic> json) {
    return OpenTradeDeal(
        json["id"],
        json["postDate"],
        json["acceptDate"],
        json["itemType"]);
  }

  get id => _id;

  set id(value) => _id = value;

  get postDate => _postDate;

  set postDate(value) => _postDate = value;

  get acceptDate => _acceptDate;

  set acceptDate(value) => _acceptDate = value;

  get itemType => _itemType;

  set itemType(value) => _itemType = value;
}
