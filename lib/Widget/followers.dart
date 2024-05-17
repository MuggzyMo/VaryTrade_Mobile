import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/ViewModel/profile_viewmodel.dart';
import 'dart:developer' as developer;

class Followers extends StatefulWidget {
  const Followers({super.key});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  final GetIt _getIt = GetIt.instance;
  late final ProfileViewmodel _profileViewmodel =
      _getIt.get<ProfileViewmodel>();

  @override
  void dispose() {
    _profileViewmodel.followersListLoading = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileViewmodel.retrieveFollowers();
    _profileViewmodel.onFollowersListLoadingChanged = () => setState(() {
      developer.log("retrieve");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your Followers"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1)),
      body: Column(children: [
        Expanded(
          child: _profileViewmodel.followersListLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color.fromRGBO(52, 58, 64, 1),
                    );
                  },
                  itemCount: _profileViewmodel.followers!.length,
                  itemBuilder: (context, index) {
                    String follower = _profileViewmodel.followers![index];
                    return ListTile(
                      title: InkWell(child: Text(follower), onTap: () {
                        _profileViewmodel.displayProfile(follower);
                      },)
                    );
                  },
                ),
        )
      ]),
    );
  }
}
