import 'package:test_app/core/contracts/server_response.dart';

class Activity extends ServerResponse {
  final String activtiyName;
  final int participants;
  final double price;
  final double accessibility;

  Activity(
      {required this.activtiyName,
      required this.participants,
      required this.price,
      required this.accessibility});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Activity &&
          activtiyName == other.activtiyName &&
          participants == other.participants &&
          price == other.price &&
          accessibility == other.accessibility;

  @override
  int get hashCode =>
      Object.hash(activtiyName, participants, price, accessibility);
}
