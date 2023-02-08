import 'server_response.dart';

abstract class Repository {
  Future<ServerResponse> fetch();
}
