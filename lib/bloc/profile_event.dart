part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class GetDateTime extends ProfileEvent {
  final DateTime date;
  GetDateTime(this.date);
}
class GetColor extends ProfileEvent {
  //final String weekday;
  final DateTime date;
  GetColor(this.date);
}
class GetProfile extends ProfileEvent {
  //final String weekday;

  GetProfile();
}