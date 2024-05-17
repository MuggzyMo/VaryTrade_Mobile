import 'dart:convert';
import 'dart:developer' as developer;
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:varytrade_flutter/Model/authentication_request.dart';
import 'package:varytrade_flutter/Model/authentication_response.dart';
import 'package:varytrade_flutter/Model/google_authentication_request.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/general_config.dart';
import 'package:http/http.dart' as http;
import 'package:varytrade_flutter/http_code.dart';

class RefreshJwtServiceUtil {
  final GetIt _getIt = GetIt.instance;
  late final Config _config;
  late final SecureStorage _secureStorage;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: <String>[
        'email',
        'https://www.googleapis.com/auth/userinfo.profile'
      ],
      serverClientId:
          "75331537615-80rrn5099lhe8k5j849v7581mlvdeipk.apps.googleusercontent.com");

  RefreshJwtServiceUtil() {
    _config = _getIt.get<Config>();
    _secureStorage = _getIt.get<SecureStorage>();
  }

  String? refreshJwtToken() {
    _secureStorage.getPassword().then((password) {
      if (password != null) {
        _secureStorage.getEmail().then((email) {
          AuthenticationRequest authenticationRequest =
              AuthenticationRequest(email!, password);
          _refreshJwtTokenWithEmailPasswordSignIn(authenticationRequest)
              .then((value) {
            return value;
          });
        });
      } else {
        _googleSignIn.signIn().then((value) {
          GoogleAuthenticationRequest googleAuthenticationRequest =
              GoogleAuthenticationRequest("", "");
          googleAuthenticationRequest.email = value!.email;
          value.authentication.then((value) {
            googleAuthenticationRequest.token = value.idToken;
            _refreshJwtTokenWithGoogleSignIn(googleAuthenticationRequest)
                .then((value) {
              return value;
            });
          });
        });
      }
    });
    return null;
  }

  Future<String?> _refreshJwtTokenWithGoogleSignIn(
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
      AuthenticationResponse authenticationResponse =
          AuthenticationResponse.fromJson(
              jsonDecode(response.body), response.statusCode);
      _secureStorage.storeJwtToken(authenticationResponse.token);
      return authenticationResponse.token;
    } else {
      return null;
    }
  }

  Future<String?> _refreshJwtTokenWithEmailPasswordSignIn(
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
      AuthenticationResponse authenticationResponse =
          AuthenticationResponse.fromJson(
              jsonDecode(response.body), response.statusCode);
      _secureStorage.storeJwtToken(authenticationResponse.token);
      return authenticationResponse.token;
    } else {
      return null;
    }
  }
}
