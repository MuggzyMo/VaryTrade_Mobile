class ClosedTradeDeal {
  int _id;
  String _postDate;
  String _acceptDate;
  String authenticatedDate;
  String authenticityStatus;
  int _itemType;

  ClosedTradeDeal(this._id, this._postDate, this._acceptDate,
      this.authenticatedDate, this.authenticityStatus, this._itemType);

  factory ClosedTradeDeal.fromJson(Map<String, dynamic> json) {
    return ClosedTradeDeal(json["id"],
        json["postDate"],
        json["acceptDate"],
        json["authenticatedDate"],
        json["authenticityStatus"],
        json["itemType"]);
  }

  get id => _id;

  set id(value) => _id = value;

  get postDate => _postDate;

  set postDate(value) => _postDate = value;

  get acceptDate => _acceptDate;

  set acceptDate(value) => _acceptDate = value;

  get getAuthenticatedDate => authenticatedDate;

  set setAuthenticatedDate(authenticatedDate) =>
      this.authenticatedDate = authenticatedDate;

  get getAuthenticityStatus => authenticityStatus;

  set setAuthenticityStatus(authenticityStatus) =>
      this.authenticityStatus = authenticityStatus;

  get itemType => _itemType;

  set itemType(value) => _itemType = value;
}
