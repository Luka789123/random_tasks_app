import 'package:test_app/core/contracts/repository.dart';
import 'package:test_app/core/contracts/server_response.dart';
import 'package:test_app/core/faliure/network_faliure.dart';
import 'package:test_app/core/faliure/server_faliure.dart';
import 'package:test_app/core/network/network_info.dart';
import 'package:test_app/features/get_activity/data/data_source/remote_datasource.dart';

class ActivityRepository extends Repository {
  final RemoteDataSource dataSource;
  final NetworkInfo netInfo;

  ActivityRepository({required this.netInfo, required this.dataSource});
  @override
  Future<ServerResponse> fetch() async {
    try {
      final connection = await netInfo.hasConnection();
      if (connection) {
        final response = await dataSource.fetch();
        return response;
      } else {
        return NetworkFaliure();
      }
    } on ServerFaliure {
      return ServerFaliure();
    }
  }
}
