import 'package:decimal/decimal.dart';
import 'package:varytrade_flutter/Model/authentication_request.dart';
import 'package:varytrade_flutter/Model/authentication_response.dart';
import 'package:varytrade_flutter/Model/edited_user_info.dart';
import 'package:varytrade_flutter/Model/google_authentication_request.dart';
import 'package:varytrade_flutter/Model/google_registration_response.dart';
import 'package:varytrade_flutter/Model/google_user_registration.dart';
import 'package:varytrade_flutter/Model/general_response.dart';
import 'package:varytrade_flutter/Model/password_change.dart';
import 'package:varytrade_flutter/Model/password_creation.dart';
import 'package:varytrade_flutter/Model/payout.dart';
import 'package:varytrade_flutter/Model/user_info.dart';
import 'package:varytrade_flutter/Model/user_registration.dart';

abstract class UserService {
  Future<AuthenticationResponse> processAuthenticationRequest(AuthenticationRequest authenticationRequest);
  Future<GeneralResponse> proccessUserRegistration(UserRegistration userRegistration);
  Future<AuthenticationResponse> processGoogleAuthenticationRequest(GoogleAuthenticationRequest googleAuthenticationRequest);
  Future<GoogleRegistrationResponse> processGoogleUserRegistration(GoogleUserRegistration googleUserRegistration, bool refreshed);
  void processForgotPasswordRequest(String email);
  Future<UserInfo> retrieveUserInfo(String token, bool refreshed);
  Future<Decimal> retrieveUserCredit(String token, bool refreshed);
  Future<bool> isUserRegisteredWithHyperwallet(String token, bool refreshed);
  Future<bool> isUserPasswordSetup(String token, bool refreshed);
  Future<GeneralResponse> proccessHyperwalletRegistration(String token, DateTime dateOfBirth, bool refreshed);
  Future<GeneralResponse> proccessPayout(String token, bool refreshed);
  Future<List<Payout>> retrievePayouts(String token, bool refreshed);
  Future<GeneralResponse> processEditAccount(String token, EditedUserInfo editedUserInfo, bool refreshed);
  Future<GeneralResponse> processEditGoogleUserAccount(String token, EditedUserInfo editedUserInfo, bool refreshed);
  Future<GeneralResponse> processCreatePassword(String token, PasswordCreation passwordCreation, bool refreshed);
  Future<GeneralResponse> processChangePassword(String token, PasswordChange passwordChange, bool refreshed);
  Future<List<String>> retrieveFollowers(String token, bool refreshed);
  Future<List<String>> retrieveFollowing(String token, bool refreshed);
  Future<GeneralResponse> processFollow(String token, String username, bool refreshed);
  Future<GeneralResponse> processUnfollow(String token, String username, bool refreshed);
  Future<bool> doesCollectorFollowCollector(String token, String username, bool refreshed);
  Future<GeneralResponse> processProfileSearch(String token, String username, bool refreshed);
}