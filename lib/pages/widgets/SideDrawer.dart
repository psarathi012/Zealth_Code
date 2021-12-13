import 'package:flutter/material.dart';
import 'package:flutter_bloc/src/bloc_provider.dart';
import 'package:github_profile/bloc/profile_bloc.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Picture of the Day',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_box_rounded),
            title: Text('Profile'),
            onTap: () => _showProfilePage(context),
          ),
        ],
      ),
    );
  }

  void _showProfilePage(BuildContext context) {
    final profileBloc = context.bloc<ProfileBloc>();
    print("NAVBAR");
    profileBloc.add(GetProfile());
  }
}