part of 'gsso_bloc.dart';

abstract class  GSSOEvent {}

class GSSOInitialEvent extends GSSOEvent{
  /////
  // access token
  // noti token
  final  String accessToken;
  final  String notificationToken;

  GSSOInitialEvent({
    required  this.accessToken,
    required this.notificationToken
  });
}