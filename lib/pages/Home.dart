import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_profile/bloc/profile_bloc.dart';
import 'package:github_profile/data/models/NasaImage.dart';
import 'package:github_profile/pages/LoadingPage.dart';
import 'package:github_profile/pages/ProfilePage.dart';
import 'package:github_profile/utils/globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DatePickerPage.dart';
import 'ImagePage.dart';

class Master extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  final String DEFAULT_DATE='2000-01-01';
  @override
  Widget build(BuildContext context) {
    Future _localStorage = App.init();
    return FutureBuilder(
      future: _localStorage,
        builder:  (context, snapshot) {
          Widget child;
          if (snapshot.connectionState == ConnectionState.done) {
            child = Container(
                child: BlocConsumer<ProfileBloc, ProfileState>(
                  builder:(context,state) {
                    if (state is ProfileInitial)
                      return buildImitialPage();
                    else if(state is ProfileDate )
                      return buildDatePicker(state.date);
                    else if(state is ProfileImage )
                      return buildImage(state.image,state.base64String,state.date);
                    else if(state is ProfileLoading )
                      return buildLoadingPage();
                    else if(state is ProfilePage )
                      return buildProfilePage();



                  },
                  listener:(context,state){},
                )
            );
          } else if (snapshot.hasError) {
            child = Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else {
            child = Scaffold(
              body: Center(child: Text('Loading...')),
            );
          }
          return child;
        },
    );

  }

  Widget buildDatePicker(DateTime date) {
    return DateScreen(date);
  }
  Widget buildImitialPage() {
    SharedPreferences prefs = App.localStorage;
    String dateStr= prefs.getString('date')??DEFAULT_DATE;

    return DateScreen(DateTime.parse(dateStr));
  }

  Widget buildImage(NasaImage nasaImage, String base64Str, DateTime date) {
    return ImagePage(nasaImage,base64Str,date);
  }

  Widget buildLoadingPage() {
    return LoadingScreen();
  }
  Widget buildProfilePage(){
    return ProfilePages();
  }
}
