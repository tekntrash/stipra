import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  User({
    this.alogin,
    this.name,
    this.userid,
    this.stayLoggedIn,
    this.otp,
  });

  final String? alogin;
  final String? name;
  final String? userid;
  bool? stayLoggedIn;
  final String? otp;

  @override
  List<Object?> get props => [alogin, name, userid, stayLoggedIn, otp];
}
