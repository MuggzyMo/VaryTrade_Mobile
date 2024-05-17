import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Service/braintree_service.dart';
import 'package:varytrade_flutter/Service/navigation_service.dart';
import 'package:varytrade_flutter/Service/resale_service.dart';
import 'package:varytrade_flutter/Service/resale_service_impl.dart';
import 'package:varytrade_flutter/Service/trade_service.dart';
import 'package:varytrade_flutter/Service/trade_service_impl.dart';
import 'package:varytrade_flutter/ViewModel/account_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/collector_resale_info_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/collector_trade_info_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/contact_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/create_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/forgot_password_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/home_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/nav_drawer_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/login_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/open_resale_deal_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/open_trade_deal_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/payout_list_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/profile_viewmodel.dart';
import 'package:varytrade_flutter/ViewModel/registration_viewmodel.dart';
import 'package:varytrade_flutter/Service/misc_service.dart';
import 'package:varytrade_flutter/Service/misc_service_impl.dart';
import 'package:varytrade_flutter/Service/secure_storage.dart';
import 'package:varytrade_flutter/Service/refresh_jwt_service_util.dart';
import 'package:varytrade_flutter/Service/user_service.dart';
import 'package:varytrade_flutter/Service/user_service_impl.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/general_config.dart';


import 'Widget/login.dart';

class MyHttpOverrides extends HttpOverrides {
  final Config _config = const Config();

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) {
        if (host == _config.baseUrl) {
          return true;
        } else {
          return false;
        }
      };
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();

  final getIt = GetIt.instance;
  getIt.registerLazySingleton<UserService>(() => UserServiceImpl());
  getIt.registerLazySingleton<MiscService>(() => MiscServiceImpl());
  getIt.registerLazySingleton<TradeService>(() => TradeServiceImpl());
  getIt.registerLazySingleton<Config>(() => const Config());
  getIt.registerLazySingleton<SecureStorage>(() => const SecureStorage());
  getIt.registerLazySingleton<CommonWidgetProvider>(() => const CommonWidgetProvider());
  getIt.registerLazySingleton<CommonThemeProvider>(() => CommonThemeProvider());
  getIt.registerLazySingleton<RefreshJwtServiceUtil>(() => RefreshJwtServiceUtil());
  getIt.registerLazySingleton<NavigationService>(() => NavigationService());
  getIt.registerLazySingleton<AccountViewmodel>(() => AccountViewmodel());
  getIt.registerLazySingleton<RegistrationViewModel>(() => RegistrationViewModel());
  getIt.registerLazySingleton<LoginViewModel>(() => LoginViewModel());
  getIt.registerLazySingleton<ContactViewModel>(() => ContactViewModel());
  getIt.registerLazySingleton<NavDrawerViewModel>(() => NavDrawerViewModel());
  getIt.registerLazySingleton<ForgotPasswordViewModel>(() => ForgotPasswordViewModel());
  getIt.registerLazySingleton<HomeViewModel>(() => HomeViewModel());
  getIt.registerLazySingleton<PayoutListViewModel>(() => PayoutListViewModel());
  getIt.registerLazySingleton<OpenTradeDealViewmodel>(() => OpenTradeDealViewmodel());
  getIt.registerLazySingleton<OpenResaleDealViewmodel>(() => OpenResaleDealViewmodel());
  getIt.registerLazySingleton<ResaleService>(() => ResaleServiceImpl());
  getIt.registerLazySingleton<CollectorResaleInfoViewmodel>(() => CollectorResaleInfoViewmodel());
  getIt.registerLazySingleton<CollectorTradeInfoViewmodel>(() => CollectorTradeInfoViewmodel());
  getIt.registerLazySingleton<ProfileViewmodel>(() => ProfileViewmodel());
  getIt.registerLazySingleton<CreateViewmodel>(() => CreateViewmodel());
  getIt.registerLazySingleton<BraintreeService>(() => BraintreeService());
  runApp(const VaryTrade());
}

class VaryTrade extends StatelessWidget {
  const VaryTrade({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Login(),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
