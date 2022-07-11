import 'package:hive/hive.dart';

part 'error_model.g.dart';

@HiveType(typeId: 6)
class ErrorModel with HiveObjectMixin {
  ErrorModel({
    required this.tag,
    required this.message,
    required this.timestamp,
    required this.isUploaded,
  });

  @HiveField(0)
  final String tag;
  @HiveField(1)
  final String message;
  @HiveField(2)
  final int timestamp;
  @HiveField(3)
  bool isUploaded;

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      tag: json['tag'] as String,
      message: json['message'] as String,
      timestamp: json['timestamp'] as int,
      isUploaded: json['isUploaded'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tag': tag,
      'message': message,
      'timestamp': timestamp,
      'isUploaded': isUploaded,
    };
  }
}
