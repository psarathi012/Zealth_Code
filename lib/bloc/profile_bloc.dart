import 'dart:async';
import 'dart:convert';
import 'package:github_profile/utils/DatetoColor.dart';
import 'package:github_profile/utils/globals.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:github_profile/data/ColorMap.dart';
import 'package:github_profile/data/DataRepository.dart';
import 'package:github_profile/data/models/NasaImage.dart';
import 'package:github_profile/data/models/Profile.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final DataRepository _profileRepo;
  ProfileBloc(this._profileRepo) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    // TODO: implement mapEventToState
    try {
      if (event is GetDateTime) {
        yield (ProfileLoading());
        SharedPreferences prefs = App.localStorage; //await SharedPreferences.getInstance();
        await prefs.setString('date', DatetoColor.covertDatetimetoString(event.date));
        final imageinfo = await _profileRepo.fetchUser(DatetoColor.covertDatetimetoString(event.date));
        http.Response response = await http.get(imageinfo.url);
        String base64Str = base64Encode(response.bodyBytes) ;
        yield (ProfileImage(imageinfo,base64Str,event.date));
      }
      else if (event is GetProfile) {
        //yield (ProfileLoading());

        //final Color color=ColorMap.map[event.weekday];
        yield (ProfilePage());
      }
      else if (event is GetColor) {
        //yield (ProfileLoading());
        SharedPreferences prefs = App.localStorage;//await SharedPreferences.getInstance();
        await prefs.setString('date', DatetoColor.covertDatetimetoString(event.date));

        //final Color color=ColorMap.map[event.weekday];
        yield (ProfileDate(event.date));
      }
    } on UserNotFoundException {
      yield (ProfileError('This User was Not Found!'));
    }
  }
}
