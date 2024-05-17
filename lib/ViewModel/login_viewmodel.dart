import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/Model/authentication_request.dart';
import 'package:varytrade_flutter/Model/authentication_response.dart';
import 'package:varytrade_flutter/Model/company.dart';
import 'package:varytrade_flutter/Model/google_authentication_request.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/http_code.dart';

class LoginViewModel {
  final GetIt _getIt = GetIt.instance;
  late final UserService _userService = _getIt.get<UserService>();
  late final MiscService _miscService = _getIt.get<MiscService>();
  late final SecureStorage _secureStorage = _getIt.get<SecureStorage>();
  late final NavigationService _navigation = _getIt.get<NavigationService>();

  Future<Company> companyInfo() {
    return _miscService.retrieveCompanyInfo();
  }

  void displayGoogleSignInIssue() {
    _navigation.displayErrorDialog(
        "Unsupported",
        GeneralResponse(HttpCode.notImplemented, [
          "This feature is currently unsupported due to a dependency issue."
        ]));
  }

  void displayForgotPassword() {
    _navigation.displayForgotPassword();
  }

  void displayRegistration() {
    _navigation.displayRegistration();
  }

  void processLogin(String email, String password, BuildContext context) {
    AuthenticationRequest authenticationRequest =
        AuthenticationRequest(email, password);
    _userService
        .processAuthenticationRequest(authenticationRequest)
        .then((value) {
      AuthenticationResponse authenticationResponse = value;
      if (authenticationResponse.statusCode == HttpCode.success) {
        _secureStorage.storeJwtToken(authenticationResponse.token);
        _secureStorage.storeEmail(authenticationRequest.email);
        _secureStorage.storeUserName(authenticationResponse.userName);
        _navigation.displayHomeFromLogin();
      } else {
        _navigation.displayLoginErrorDialog();
      }
    });
  }

  void processGoogleLogin(
      GoogleSignInAccount? googleSignInAccount, BuildContext context) {
    GoogleAuthenticationRequest googleAuthenticationRequest =
        GoogleAuthenticationRequest("", "");
    googleAuthenticationRequest.email = googleSignInAccount!.email;
    googleSignInAccount.authentication.then((value) {
      googleAuthenticationRequest.token = value.idToken;
      _userService
          .processGoogleAuthenticationRequest(googleAuthenticationRequest)
          .then((value) {
        AuthenticationResponse authenticationResponse = value;
        if (authenticationResponse.statusCode == HttpCode.success) {
          _secureStorage.storeJwtToken(authenticationResponse.token);
          _secureStorage.storeEmail(googleAuthenticationRequest.email);
          if (authenticationResponse.userName != null) {
            _secureStorage.storeUserName(authenticationResponse.userName);
          }
          // Means that a user has not fully registered after signing in with Google Account
          if (authenticationResponse.userName == null) {
            _navigation
                .displayGoogleRegistration(googleAuthenticationRequest.email);
          } else {
            _navigation.displayHomeFromLogin();
          }
        } else {
          _navigation.displayLoginErrorDialog();
        }
      });
    });
  }
}
