import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class ProfileViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final TradeService _tradeService = _getIt.get<TradeService>();
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  List<String>? _followers;
  get followers => _followers;
  bool _followersListLoading = true;
  get followersListLoading => _followersListLoading;
  set followersListLoading(value) => _followersListLoading = followersListLoading;
  Function()? onFollowersListLoadingChanged;


  List<String>? _following;
  get following => _following;
  bool _followingListLoading = true;
  get followingListLoading => _followingListLoading;
  set followingListLoading(value) => _followingListLoading = followersListLoading;
  Function()? onFollowingListLoadingChanged;

  bool _followStatusLoading = true;
  get followStatusLoading => _followStatusLoading;
  set followStatusLoading(value) => _followStatusLoading = value;

  bool? _followStatus;
  get followStatus => _followStatus;
  Function()? onFollowStatusLoadingChanged;

  Future<void> retrieveFollowers() async {
    String? token = await _secureStorage.getJwtToken();
    _followers = await _userService.retrieveFollowers(token!, false);
    _followersListLoading = false;
    onFollowersListLoadingChanged?.call();
  }

  Future<void> retrieveFollowing() async {
    String? token = await _secureStorage.getJwtToken();
    _following = await _userService.retrieveFollowing(token!, false);
    _followingListLoading = false;
    onFollowingListLoadingChanged?.call();
  }

  Future<void> doesCollectorFollowCollector(String username) async {
    String? token = await _secureStorage.getJwtToken();
    _followStatus = await _userService.doesCollectorFollowCollector(token!, username, false);
    _followStatusLoading = false;
    onFollowStatusLoadingChanged?.call();
  }

  void processFollow(String username) {
    _secureStorage.getJwtToken().then((value) {
      _userService.processFollow(value!, username, false).then((value) {
        if(value.statusCode == HttpCode.success) {
          doesCollectorFollowCollector(username);
        } else {
          _navigation.displayErrorDialog("Follow Unsuccessful", value);
        }
      });
    });
  }

  void processUnfollow(String username) {
        _secureStorage.getJwtToken().then((value) {
      _userService.processUnfollow(value!, username, false).then((value) {
        if(value.statusCode == HttpCode.success) {
          doesCollectorFollowCollector(username);
        } else {
          _navigation.displayErrorDialog("Unfollow Unsuccessful", value);
        }
      });
    });
  }

  void processProfileSearch(String username) {
    _secureStorage.getJwtToken().then((value) {
      _userService.processProfileSearch(value!, username, false).then((value) {
        if(value.statusCode == HttpCode.success) {
          _navigation.pop();
          _navigation.pop();
          _navigation.displayProfile(username);
        } else {
          _navigation.displayErrorDialog("Profile Search Result", value);
        }
      });
    });
  }

  Future<List<String>> retrieveCollectibleNames() async {
    String? token = await _secureStorage.getJwtToken();
    return _tradeService.retrieveCollectibleNames(token!, false);
  }

  void displayProfile(String username) async {
    String? currentCollectorUsername = await _secureStorage.getUserName();
    if(currentCollectorUsername != username) {
       _navigation.displayProfile(username);
    } else {
      _navigation.displayErrorDialog("Profile Lookup Error", GeneralResponse(HttpCode.forbidden, ["You cannot view your own profile."]));
    }
  }

  void displayProfileOpenTrades(String username, int id) {
    _navigation.displayProfileOpenTrades(username, id);
  }

  void displayProfileOpenResales(String username, int id) {
    _navigation.displayProfileOpenResales(username, id);
  }

  void displayHome() {
    return _navigation.displayHome();
  }
}