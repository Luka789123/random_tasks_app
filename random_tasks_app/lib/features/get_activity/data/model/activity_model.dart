import 'package:test_app/core/entity/activity.dart';

class ActivityModel extends Activity {
  ActivityModel(
      {required super.activtiyName,
      required super.participants,
      required super.price,
      required super.accessibility});
  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
        activtiyName: json['activity'],
        participants: (json['participants'] as num).toInt(),
        price: (json['price'] as num).toDouble(),
        accessibility: (json['accessibility'] as num).toDouble());
  }
}
