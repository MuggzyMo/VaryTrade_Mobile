import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/ViewModel/nav_drawer_viewmodel.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({super.key});

  final GetIt _getIt = GetIt.instance;
  late final NavDrawerViewModel _navDrawerViewModel = _getIt.get<NavDrawerViewModel>();


  @override
  Widget build(BuildContext context) => Drawer(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildNavMenuHeader(context),
            buildNavMenuItems(context)
          ],
        ),
      ));

  Widget buildNavMenuHeader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      );

  Widget buildNavMenuItems(BuildContext context) => Column(
        children: [
          ListTile(
            title: const Text("Home"),
            onTap: () {
              _navDrawerViewModel.displayHome();
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Account'),
            onTap: () {
              _navDrawerViewModel.displayAccount();
            },
          ),
          ListTile(
            title: const Text("Your Trade Deals"),
            onTap: () {
              _navDrawerViewModel.displayCollectorTradeInfo();
            },
          ),
          ListTile(
            title: const Text("Your Resale Deals"),
            onTap: () {
              _navDrawerViewModel.displayCollectorResaleInfo();
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_search),
            title: const Text("Search for Collector"),
            onTap: () {
              _navDrawerViewModel.displayProfileSearch();
            },
          ),
          ListTile(
            title: const Text("Followers"),
            onTap: () {
              _navDrawerViewModel.displayFollowers();
            },
          ),
          ListTile(
            title: const Text("Following"),
            onTap: () {
              _navDrawerViewModel.displayFollowing();
            },
          ),
          ListTile(
            title: const Text("Contact Us"),
            onTap: () {
              _navDrawerViewModel.displayContact();
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text("Logout"),
            onTap: () {
              _navDrawerViewModel.logout();
            },
          ),
        ],
      );
}
