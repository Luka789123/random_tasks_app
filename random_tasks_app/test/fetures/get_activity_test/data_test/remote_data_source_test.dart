import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test_app/core/faliure/server_faliure.dart';
import 'package:test_app/features/get_activity/data/data_source/remote_datasource.dart';
import 'package:test_app/features/get_activity/data/model/activity_model.dart';

import '../../../core/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late RemoteDataSource sut;
  late String tResponse;
  late ActivityModel mResponse;
  setUp(() {
    mockClient = MockClient();
    sut = RemoteDataSource(client: mockClient);
    tResponse = fixture('mock_response.json');
    mResponse = ActivityModel(
        activtiyName: 'test', participants: 1, price: 0, accessibility: 0.05);
  });

  void setUpHttp200() {
    when(() => mockClient.get(
            Uri.parse('http://www.boredapi.com/api/activity/'),
            headers: {'Accept': 'application/json,*/*'}))
        .thenAnswer((_) async => http.Response(tResponse, 200));
  }

  void setUpHttp404() {
    when(() => mockClient.get(
            Uri.parse('http://www.boredapi.com/api/activity/'),
            headers: {'Accept': 'application/json,*/*'}))
        .thenAnswer((_) async => http.Response(tResponse, 404));
  }

  group('Remote data source testovi', () {
    test('Metoda fetch vraća ActivityModel kad je sve u redu', () async {
      setUpHttp200();
      final response = await sut.fetch();
      expect(response, mResponse);
    });

    test('Baca ServerFaliure kad http kod nije 200', () async {
      setUpHttp404();
      final call = sut.fetch;
      expect(() => call(), throwsA(const TypeMatcher<ServerFaliure>()));
    });
  });
}
