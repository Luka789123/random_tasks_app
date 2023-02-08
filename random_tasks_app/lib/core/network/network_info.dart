import 'dart:io';

class NetworkInfo {
  bool _isConnected = false;

  Future<bool> hasConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _isConnected = true;
      }
    } on SocketException catch (_) {
      _isConnected = false;
    }
    return Future.value(_isConnected);
  }
}
