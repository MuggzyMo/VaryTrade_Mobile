import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/Common/common_theme_provider.dart';
import 'package:varytrade_flutter/Common/common_widget_provider.dart';
import 'package:varytrade_flutter/ViewModel/profile_viewmodel.dart';
import 'dart:developer' as developer;

class Profile extends StatefulWidget {
  const Profile(this._username, {super.key});

  final String _username;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GetIt _getIt = GetIt.instance;
  late final ProfileViewmodel _profileViewmodel =
      _getIt.get<ProfileViewmodel>();
  late final CommonWidgetProvider _commonWidgetProvider =
      _getIt.get<CommonWidgetProvider>();
  late final CommonThemeProvider _commonThemeProvider =
      _getIt.get<CommonThemeProvider>();
  late final Future<List<String>> _collectibleNames =
      _profileViewmodel.retrieveCollectibleNames();

  @override
  void dispose() {
    _profileViewmodel.followStatusLoading = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileViewmodel.doesCollectorFollowCollector(widget._username);
    _profileViewmodel.onFollowStatusLoadingChanged = () => setState(() {
          developer.log("retrieve");
        });
  }

  @override
  Widget build(BuildContext context) {
    return   WillPopScope(onWillPop: () async {
      _profileViewmodel.displayHome();
      return false;

      }
    , child:
    Scaffold(
        appBar: AppBar(
          title: Text("${widget._username}'s Profile"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1),
        ),
        body: SingleChildScrollView(
            child: Center(
          child: _profileViewmodel.followStatusLoading
              ? const CircularProgressIndicator()
              : Column(
                  children: [
                    if (!_profileViewmodel.followStatus)
                    _commonWidgetProvider.space(context, 10),
                    if (!_profileViewmodel.followStatus)
                      TextButton(
                        onPressed: () {
                          _profileViewmodel.processFollow(widget._username);
                        },
                        style: _commonThemeProvider.buttonDesign(context, 90),
                        child: const Text(
                          "Follow",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    if (_profileViewmodel.followStatus)
                    _commonWidgetProvider.space(context, 10),
                    if (_profileViewmodel.followStatus)
                      TextButton(
                          onPressed: () {
                            _profileViewmodel.processUnfollow(widget._username);
                          },
                          style: _commonThemeProvider.buttonDesign(context, 90),
                          child: const Text(
                            "Unfollow",
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          )),
                    FutureBuilder<List<String>>(
                        future: _collectibleNames,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(children: [
                              _commonWidgetProvider.space(context, 50),
                              TextButton(
                                style: _commonThemeProvider.buttonDesign(
                                    context, 90),
                                onPressed: () {
                                  _profileViewmodel.displayProfileOpenTrades(widget._username, 1);
                                },
                                child: Text(
                                  "Collector's Open ${snapshot.data![0]} Trade Deals",
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ),
                              _commonWidgetProvider.space(context, 50),
                              TextButton(
                                style: _commonThemeProvider.buttonDesign(
                                    context, 90),
                                onPressed: () {
                                  _profileViewmodel.displayProfileOpenResales(widget._username, 1);
                                },
                                child: Text(
                                  "Collector's Open ${snapshot.data![0]} Resale Deals",
                                  style: const TextStyle(fontSize: 18.0),
                                ),
                              ),
                              if (snapshot.data!.length > 1)
                                _commonWidgetProvider.space(context, 50),
                              if (snapshot.data!.length > 1)
                                TextButton(
                                  style: _commonThemeProvider.buttonDesign(
                                      context, 90),
                                  onPressed: () {
                                    _profileViewmodel.displayProfileOpenTrades(widget._username, 2);
                                  },
                                  child: Text(
                                    "Collector's Open ${snapshot.data![1]} Trade Deals",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              if (snapshot.data!.length > 1)
                                _commonWidgetProvider.space(context, 50),
                              if (snapshot.data!.length > 1)
                                TextButton(
                                  style: _commonThemeProvider.buttonDesign(
                                      context, 90),
                                  onPressed: () {
                                    _profileViewmodel.displayProfileOpenResales(widget._username, 2);
                                  },
                                  child: Text(
                                    "Collector's Open ${snapshot.data![1]} Resale Deals",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              if (snapshot.data!.length > 2)
                                _commonWidgetProvider.space(context, 50),
                              if (snapshot.data!.length > 2)
                                TextButton(
                                  style: _commonThemeProvider.buttonDesign(
                                      context, 90),
                                  onPressed: () {
                                    _profileViewmodel.displayProfileOpenTrades(widget._username, 3);
                                  },
                                  child: Text(
                                    "Collector's Open ${snapshot.data![2]} Trade Deals",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                ),
                              if (snapshot.data!.length > 2)
                                _commonWidgetProvider.space(context, 50),
                              if (snapshot.data!.length > 2)
                                TextButton(
                                  style: _commonThemeProvider.buttonDesign(
                                      context, 90),
                                  onPressed: () {
                                    _profileViewmodel.displayProfileOpenResales(widget._username, 3);
                                  },
                                  child: Text(
                                    "Collector's Open ${snapshot.data![1]} Resale Deals",
                                    style: const TextStyle(fontSize: 18.0),
                                  ),
                                )
                            ]);
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })
                  ]
                ),
        ))));
  }
}
