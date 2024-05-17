import 'dart:async';
import 'dart:developer' as developer;
import 'dart:convert';
import 'package:decimal/decimal.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:varytrade_flutter/Model/authentication_request.dart';
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
import 'package:varytrade_flutter/Service/refresh_jwt_service_util.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/general_config.dart';
import 'package:varytrade_flutter/http_code.dart';
import '../Model/authentication_response.dart';

class UserServiceImpl implements UserService {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;
  late final RefreshJwtServiceUtil _serviceUtil;

  UserServiceImpl() {
    _config = _getIt.get<Config>();
    _serviceUtil = _getIt.get<RefreshJwtServiceUtil>();
  }

  @override
  Future<GeneralResponse> processProfileSearch(
      String token, String username, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response =
        await http.post(Uri.parse('https://$baseUrlPort/api/profile/search'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({"username": username}));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processProfileSearch(
          _serviceUtil.refreshJwtToken()!, username, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processUnfollow(
      String token, String username, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse('https://$baseUrlPort/api/profile/unfollow?username=$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processUnfollow(_serviceUtil.refreshJwtToken()!, username, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processFollow(
      String token, String username, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
      Uri.parse('https://$baseUrlPort/api/profile/follow?username=$username'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processFollow(_serviceUtil.refreshJwtToken()!, username, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<List<String>> retrieveFollowers(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
      Uri.parse('https://$baseUrlPort/api/followers'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveFollowers(_serviceUtil.refreshJwtToken()!, false);
    } else {
      developer.log(response.body);
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<List<String>> retrieveFollowing(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
      Uri.parse('https://$baseUrlPort/api/following'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveFollowing(_serviceUtil.refreshJwtToken()!, false);
    } else {
      developer.log(response.body);
      return List<String>.from(jsonDecode(response.body));
    }
  }

  @override
  Future<GeneralResponse> processChangePassword(
      String token, PasswordChange passwordChange, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/account/password/edit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'currentPassword': '${passwordChange.currentPassword}',
          'password': '${passwordChange.newPassword}',
          'confirmPassword': '${passwordChange.confirmPassword}'
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processChangePassword(
          _serviceUtil.refreshJwtToken()!, passwordChange, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processCreatePassword(
      String token, PasswordCreation passwordCreation, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/account/password/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'password': '${passwordCreation.password}',
          'confirmPassword': '${passwordCreation.confirmPassword}'
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processCreatePassword(
          _serviceUtil.refreshJwtToken()!, passwordCreation, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<List<Payout>> retrievePayouts(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http
        .get(Uri.parse('https://$baseUrlPort/api/payout/history'), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrievePayouts(_serviceUtil.refreshJwtToken()!, true);
    } else {
      List<Payout> payouts = [];
      var list = json.decode(response.body) as List;
      for (var element in list) {
        payouts.add(Payout.fromJson(element));
      }
      return payouts;
    }
  }

  @override
  Future<GeneralResponse> proccessPayout(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(Uri.parse('https://$baseUrlPort/api/payout'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return proccessPayout(_serviceUtil.refreshJwtToken()!, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> proccessHyperwalletRegistration(
      String token, DateTime dateofBirth, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/hyperwallet/registration'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'dateOfBirth': dateofBirth
              .toString()
              .substring(0, dateofBirth.toString().indexOf(' '))
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return proccessHyperwalletRegistration(
          _serviceUtil.refreshJwtToken()!, dateofBirth, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<bool> isUserPasswordSetup(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/password/setup/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return isUserPasswordSetup(_serviceUtil.refreshJwtToken()!, true);
    } else {
      return bool.parse(response.body);
    }
  }

  @override
  Future<bool> doesCollectorFollowCollector(
      String token, String username, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse(
            'https://$baseUrlPort/api/profile/follow-status?username=$username'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return isUserRegisteredWithHyperwallet(
          _serviceUtil.refreshJwtToken()!, true);
    } else {
      return bool.parse(response.body);
    }
  }

  @override
  Future<bool> isUserRegisteredWithHyperwallet(
      String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(
        Uri.parse('https://$baseUrlPort/api/hyperwallet/verify'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return isUserRegisteredWithHyperwallet(
          _serviceUtil.refreshJwtToken()!, true);
    } else {
      return bool.parse(response.body);
    }
  }

  @override
  Future<Decimal> retrieveUserCredit(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(Uri.parse('https://$baseUrlPort/api/credit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveUserCredit(_serviceUtil.refreshJwtToken()!, true);
    } else {
      return Decimal.parse(response.body);
    }
  }

  @override
  Future<UserInfo> retrieveUserInfo(String token, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.get(Uri.parse('https://$baseUrlPort/api/account'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return retrieveUserInfo(_serviceUtil.refreshJwtToken()!, true);
    } else {
      return UserInfo.fromJson(jsonDecode(response.body));
    }
  }

  @override
  Future<void> processForgotPasswordRequest(String email) async {
    String baseUrlPort = _config.baseUrlPort;
    await http.post(Uri.parse('https://$baseUrlPort/api/password/forgot'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email}));
  }

  @override
  Future<GoogleRegistrationResponse> processGoogleUserRegistration(
      GoogleUserRegistration googleUserRegistration, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    String token = googleUserRegistration.token;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/google/register'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'email': googleUserRegistration.email,
          'zipCode': googleUserRegistration.zipCode,
          'state': googleUserRegistration.state,
          'city': googleUserRegistration.city,
          'address': googleUserRegistration.address,
          'phoneNum': _formattedPhoneNum(googleUserRegistration.phoneNum),
          'firstName': googleUserRegistration.firstName,
          'middleName': googleUserRegistration.middleName,
          'lastName': googleUserRegistration.lastName,
          'userName': googleUserRegistration.userName,
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      googleUserRegistration.token = _serviceUtil.refreshJwtToken();
      return processGoogleUserRegistration(googleUserRegistration, true);
    } else {
      return GoogleRegistrationResponse.fromJson(
          jsonDecode(response.body), response.statusCode);
    }
  }

  @override
  Future<AuthenticationResponse> processGoogleAuthenticationRequest(
      GoogleAuthenticationRequest googleAuthenticationRequest) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/google/login/verify'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': googleAuthenticationRequest.email,
          'token': googleAuthenticationRequest.token
        }));
    if (response.body.isNotEmpty && response.statusCode == HttpCode.success) {
      developer.log(response.body);
      return AuthenticationResponse.fromJson(
          jsonDecode(response.body), response.statusCode);
    } else {
      return AuthenticationResponse("", "", response.statusCode);
    }
  }

  @override
  Future<AuthenticationResponse> processAuthenticationRequest(
      AuthenticationRequest authenticationRequest) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(Uri.parse('https://$baseUrlPort/api/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': authenticationRequest.email,
          'password': authenticationRequest.password
        }));
    if (response.body.isNotEmpty && response.statusCode == HttpCode.success) {
      developer.log(response.body);
      return AuthenticationResponse.fromJson(
          jsonDecode(response.body), response.statusCode);
    } else {
      return AuthenticationResponse("", "", response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> proccessUserRegistration(
      UserRegistration userRegistration) async {
    String baseUrlPort = _config.baseUrlPort;
    var response =
        await http.post(Uri.parse('https://$baseUrlPort/api/register'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': userRegistration.email,
              'zipCode': userRegistration.zipCode,
              'state': userRegistration.state,
              'city': userRegistration.city,
              'address': userRegistration.address,
              'phoneNum': _formattedPhoneNum(userRegistration.phoneNum),
              'firstName': userRegistration.firstName,
              'middleName': userRegistration.middleName,
              'lastName': userRegistration.lastName,
              'username': userRegistration.userName,
              'password': userRegistration.password,
              'confirmPassword': userRegistration.confirmPassword,
            }));
    return GeneralResponse.fromJson(
        List<String>.from(jsonDecode(response.body)), response.statusCode);
  }

  @override
  Future<GeneralResponse> processEditAccount(
      String token, EditedUserInfo editedUserInfo, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/account/edit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'email': editedUserInfo.email,
          'zipCode': editedUserInfo.zipCode,
          'state': editedUserInfo.state,
          'city': editedUserInfo.city,
          'address': editedUserInfo.address,
          'phoneNum': _formattedPhoneNum(editedUserInfo.phoneNum),
          'firstName': editedUserInfo.firstName,
          'middleName': editedUserInfo.middleName,
          'lastName': editedUserInfo.lastName
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processEditAccount(
          _serviceUtil.refreshJwtToken()!, editedUserInfo, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  @override
  Future<GeneralResponse> processEditGoogleUserAccount(
      String token, EditedUserInfo editedUserInfo, bool refreshed) async {
    String baseUrlPort = _config.baseUrlPort;
    var response = await http.post(
        Uri.parse('https://$baseUrlPort/api/account/google/edit'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          'email': editedUserInfo.email,
          'zipCode': editedUserInfo.zipCode,
          'state': editedUserInfo.state,
          'city': editedUserInfo.city,
          'address': editedUserInfo.address,
          'phoneNum': _formattedPhoneNum(editedUserInfo.phoneNum),
          'firstName': editedUserInfo.firstName,
          'middleName': editedUserInfo.middleName,
          'lastName': editedUserInfo.lastName
        }));
    if (response.statusCode == HttpCode.unauthorized && !refreshed) {
      return processEditGoogleUserAccount(
          _serviceUtil.refreshJwtToken()!, editedUserInfo, true);
    } else {
      return GeneralResponse.fromJson(
          List<String>.from(jsonDecode(response.body)), response.statusCode);
    }
  }

  String _formattedPhoneNum(String phoneNum) {
    String formatted =
        '${phoneNum.substring(0, 3)}-${phoneNum.substring(3, 6)}-${phoneNum.substring(6)}';
    return formatted;
  }
}
