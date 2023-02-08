import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test_app/core/entity/activity.dart';
import 'package:test_app/core/faliure/network_faliure.dart';
import 'package:test_app/core/faliure/server_faliure.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/get_activity/data/data_source/remote_datasource.dart';
import 'package:test_app/features/get_activity/data/model/activity_model.dart';
import 'package:test_app/features/get_activity/data/repositroy/activity_repository.dart';

class MockNetworkInfo extends Mock implements NetworkInfo {}

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockActivityModel extends Mock implements ActivityModel {}

class MockServerFaliure extends Mock implements ServerFaliure {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockRemoteDataSource mockDataSource;
  late ActivityRepository sut;
  late MockActivityModel tResponse;
  late MockServerFaliure mockServerFaliure;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockDataSource = MockRemoteDataSource();
    sut = ActivityRepository(
        dataSource: mockDataSource, netInfo: mockNetworkInfo);
    tResponse = MockActivityModel();
    mockServerFaliure = MockServerFaliure();
  });

  group('ActivityRepositry testovi', () {
    void setResponse() =>
        when(() => mockDataSource.fetch()).thenAnswer((_) async => tResponse);
    void setFaliure() =>
        when(() => mockDataSource.fetch()).thenThrow(mockServerFaliure);

    void setNetwork(bool value) => when(() => mockNetworkInfo.hasConnection())
        .thenAnswer((_) => Future.value(value));

    test('Ako je sve u redu vrati Activity', () async {
      setResponse();
      setNetwork(true);
      final response = await sut.fetch();
      expect(response, const TypeMatcher<Activity>());
    });

    test('Provjeri internetsku vezu ako je sve u redu vrati vrijednost',
        () async {
      setResponse();
      setNetwork(true);
      final result = await sut.fetch();
      verify(() => mockNetworkInfo.hasConnection()).called(1);
      expect(result, const TypeMatcher<Activity>());
    });

    test('Ako internetska veza nije dostupna vrati NetworkFaliure', () async {
      setResponse();
      setNetwork(false);
      final result = await sut.fetch();
      expect(result, const TypeMatcher<NetworkFaliure>());
    });

    test('ako se desio ServerFaliure vrati ServerFaliure', () async {
      setFaliure();
      setNetwork(true);
      final result = await sut.fetch();
      expect(result, const TypeMatcher<ServerFaliure>());
    });
  });
}
