import 'package:decimal/decimal.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/edited_user_info.dart';
import 'package:varytrade_flutter/Model/password_change.dart';
import 'package:varytrade_flutter/Model/password_creation.dart';
import 'package:varytrade_flutter/Model/user_info.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class AccountViewmodel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  UserInfo? _userInfo;
  bool? _passwordSetup;
  bool? _hyperwallet;
  Decimal? _credit;

  bool _loading = true;

  Function()? onLoadingChanged;

  get passwordSetup => _passwordSetup;
  get hyperwallet => _hyperwallet;
  get credit => _credit;
  get userInfo => _userInfo;
  get loading => _loading;

  set loading(loading) => _loading = loading;

  Future<void> retrieveAccount() async {
    String? token = await _secureStorage.getJwtToken();
    _userInfo = await _userService.retrieveUserInfo(token!, false);
    await _secureStorage.storeEmail(_userInfo!.email);
    _passwordSetup = await _userService.isUserPasswordSetup(token, false);
    _hyperwallet =
        await _userService.isUserRegisteredWithHyperwallet(token, false);
    _credit = await _userService.retrieveUserCredit(token, false);
    _loading = false;
    onLoadingChanged?.call();
  }

  void displayChangePassword() {
    _navigation.displayChangePassword();
  }

  void processChangePassword(String currentPassword, String newPassword, String confirmNewPassword) {
    PasswordChange passwordChange = PasswordChange(currentPassword, newPassword, confirmNewPassword);
    _secureStorage.getJwtToken().then((value) {
      _userService.processChangePassword(value!, passwordChange, false).then((value) {
        if(value.statusCode == HttpCode.success) {
          _secureStorage.storePassword(passwordChange.newPassword);
          _navigation.pop();
        } else {
          _navigation.displayErrorDialog("Change Password Error", value);
        }
      });
    });
  }

  void displayCreatePassword() {
    _navigation.displayCreatePassword();
  }

  void proccessCreatePassword(String password, String confirmPassword) {
    PasswordCreation passwordCreation = PasswordCreation(password, confirmPassword);
    _secureStorage.getJwtToken().then((value) {
      _userService.processCreatePassword(value!, passwordCreation, false).then((value) {
        if(value.statusCode == HttpCode.success) {
          _secureStorage.storePassword(password);
          retrieveAccount();
          _navigation.pop();
        } else {
          _navigation.displayErrorDialog("Password Creation Error", value);
        }
      });
    });
  }

  void processEditAccount(
    String? email,
    String address,
    String zipCode,
    String city,
    String state,
    String firstName,
    String lastName,
    String middleName,
    String phoneNum,
  ) {
    EditedUserInfo editedUserInfo = EditedUserInfo(email, zipCode, state, city,
        address, phoneNum, firstName, middleName, lastName);
    _secureStorage.getJwtToken().then((value) {
      if (editedUserInfo.email == null) {
        _userService.processEditGoogleUserAccount(
            value!, editedUserInfo, false).then((value) {
              if(value.statusCode == HttpCode.success) {
                retrieveAccount();
                _navigation.pop();
              }
              else {
                _navigation.displayErrorDialog("Account Editing Error", value);
              }
            });
      } else {
        _userService.processEditAccount(value!, editedUserInfo, false).then((value) {
          if(value.statusCode == HttpCode.success) {
                retrieveAccount();
                _navigation.pop();
              }
              else {
                _navigation.displayErrorDialog("Account Editing Error", value);
              }
        });
      }
    });
  }

  void proccessPayout() {
    _secureStorage.getJwtToken().then((value) {
      _userService.proccessPayout(value!, false).then((value) {
        if (value.statusCode == HttpCode.success) {
          _navigation.displayPayoutSuccessfulDialog();
          retrieveAccount();
        } else {
          _navigation.displayErrorDialog("Payout Error", value);
        }
      });
    });
  }

  void proccessHyperwalletRegistration(String date) {
    _getIt.get<SecureStorage>().getJwtToken().then((value) {
      _getIt
          .get<UserService>()
          .proccessHyperwalletRegistration(value!, DateTime.parse(date), false)
          .then((value) {
        if (value.statusCode == HttpCode.success) {
          retrieveAccount();
          _navigation.pop();
        } else {
          _navigation.displayErrorDialog("Hyperwallet Error", value);
        }
      });
    });
  }

  Future<List<String>> states() {
    return _miscService.retrieveStates();
  }

  void displayEditAccount() {
    _navigation.displayEditAccount();
  }

  void displayPayoutList() {
    _navigation.displayPayoutList();
  }

  void displayHome() {
    _navigation.displayHome();
  }

  void displayHyperwalletRegistrationDialog() {
    _navigation.displayHyperwalletRegistration();
  }
}
