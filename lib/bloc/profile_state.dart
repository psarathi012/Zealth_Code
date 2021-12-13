part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {
  const ProfileState();
}

class ProfileInitial extends ProfileState {

  //Color colors=Colors.orange;
  ProfileInitial();
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  const ProfileLoaded(this.profile);
}

class ProfileError extends ProfileState {
  final String error;
  const ProfileError(this.error);
}

class ProfileDate extends ProfileState {
   //Color colors=Colors.green;
   final DateTime date;
   ProfileDate(this.date);
}

class ProfileImage extends ProfileState {
  final NasaImage image;
  final DateTime date;
  final String base64String;
  ProfileImage(this.image,this.base64String,this.date);
}
class ProfilePage extends ProfileState {

  ProfilePage();
}

