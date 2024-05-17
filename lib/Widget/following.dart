import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:varytrade_flutter/ViewModel/profile_viewmodel.dart';
import 'dart:developer' as developer;

class Following extends StatefulWidget {
  const Following({super.key});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  final GetIt _getIt = GetIt.instance;
  late final ProfileViewmodel _profileViewmodel =
      _getIt.get<ProfileViewmodel>();

  @override
  void dispose() {
    _profileViewmodel.followingListLoading = true;
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileViewmodel.retrieveFollowing();
    _profileViewmodel.onFollowingListLoadingChanged = () => setState(() {
      developer.log("retrieve");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Your Following"),
          backgroundColor: const Color.fromRGBO(52, 58, 64, 1)),
      body: Column(children: [
        Expanded(
          child: _profileViewmodel.followingListLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Color.fromRGBO(52, 58, 64, 1),
                    );
                  },
                  itemCount: _profileViewmodel.following!.length,
                  itemBuilder: (context, index) {
                    String following = _profileViewmodel.following![index];
                    return ListTile(
                      title: InkWell(child: Text(following), onTap: () {
                        _profileViewmodel.displayProfile(following);
                      },),
                    );
                  },
                ),
        )
      ]),
    );
  }
}
