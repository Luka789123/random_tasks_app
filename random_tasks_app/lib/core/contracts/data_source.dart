abstract class DataSource<T> {
  Future<T> fetch();
}
