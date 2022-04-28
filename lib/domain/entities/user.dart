import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class User extends Equatable {
  User({
    this.alogin,
    this.name,
    this.userid,
    this.stayLoggedIn,
    this.otp,
    this.image,
    this.lastLoginTime,
    this.points,
  });

  final String? alogin;
  final String? name;
  final String? userid;
  bool? stayLoggedIn;
  final String? otp;
  final String? image;
  final DateTime? lastLoginTime;
  final String? points;

  @override
  List<Object?> get props =>
      [alogin, name, userid, stayLoggedIn, otp, image, lastLoginTime, points];
}
