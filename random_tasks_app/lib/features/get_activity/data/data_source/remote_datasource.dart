import 'dart:convert';

import 'package:test_app/core/contracts/data_source.dart';
import 'package:test_app/core/faliure/server_faliure.dart';

import '../model/activity_model.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource extends DataSource<ActivityModel> {
  final http.Client client;

  RemoteDataSource({required this.client});

  @override
  Future<ActivityModel> fetch() async {
    final result = await client.get(
        Uri.parse('http://www.boredapi.com/api/activity/'),
        headers: {'Accept': 'application/json,*/*'});

    if (result.statusCode == 200) {
      return ActivityModel.fromJson(json.decode(result.body));
    } else {
      throw ServerFaliure();
    }
  }
}
