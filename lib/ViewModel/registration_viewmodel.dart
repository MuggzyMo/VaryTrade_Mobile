import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Model/google_registration_response.dart';
import 'package:varytrade_flutter/Model/google_user_registration.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/Model/authentication_request.dart';
import 'package:varytrade_flutter/Model/authentication_response.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/user_registration.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class RegistrationViewModel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  Future<Company> companyInfo() {
    return _miscService.retrieveCompanyInfo();
  }

  void processGoogleRegistration(
      String userName,
      String address,
      String zipCode,
      String city,
      String state,
      String firstName,
      String lastName,
      String middleName,
      String phoneNum) {
    GoogleUserRegistration googleUserRegistration = GoogleUserRegistration(
        "",
        zipCode,
        state,
        city,
        address,
        phoneNum,
        firstName,
        middleName,
        lastName,
        userName,
        "");
    _retrieveGoogleUserInfoFromStorage().then((value) {
      googleUserRegistration.token = value[0];
      googleUserRegistration.email = value[1];
      _userService
          .processGoogleUserRegistration(googleUserRegistration, false)
          .then((value) {
        GoogleRegistrationResponse googleRegistrationResponse = value;
        if (googleRegistrationResponse.statusCode == HttpCode.success) {
          _secureStorage.storeUserName(googleUserRegistration.userName);
          _navigation.displayHomeFromLogin();
        } else {
            _navigation.displayGoogleRegistrationErrorDialog(googleRegistrationResponse);
        }
      });
    });
  }

  void processRegistration(
    String userName,
    String email,
    String password,
    String confirmPassword,
    String address,
    String zipCode,
    String city,
    String state,
    String firstName,
    String lastName,
    String middleName,
    String phoneNum,
  ) {
    UserRegistration userRegistration = UserRegistration(
        email,
        zipCode,
        state,
        city,
        address,
        phoneNum,
        firstName,
        middleName,
        lastName,
        userName,
        password,
        confirmPassword);
    _userService.proccessUserRegistration(userRegistration).then((value) {
      GeneralResponse registrationResponse = value;
      if (registrationResponse.statusCode == HttpCode.success) {
        AuthenticationRequest authenticationRequest = AuthenticationRequest(
            userRegistration.email, userRegistration.password);
        _userService
            .processAuthenticationRequest(authenticationRequest)
            .then((value) {
          AuthenticationResponse authenticationResponse = value;
          if (authenticationResponse.statusCode == HttpCode.success) {
            _secureStorage.storeJwtToken(authenticationResponse.token);
            _secureStorage.storeEmail(authenticationRequest.email);
            _secureStorage.storeUserName(userRegistration.userName);
            _navigation.displayHome();
          } else {
            _navigation.displayLogin();
          }
        });
      } else {
        _navigation.displayErrorDialog("Registration Error", registrationResponse);
      }
    });
  }

  Future<List<String>> states() {
    return _miscService.retrieveStates();
  }

    Future<List<String?>> _retrieveGoogleUserInfoFromStorage() {
    return Future.wait(
        [_secureStorage.getJwtToken(), _secureStorage.getEmail()]);
  }
}
