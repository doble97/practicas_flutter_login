abstract class IApi<T> {
  Future<List<T>> getAll();
  Future<T> login(T value);
  Future<T> register(T value);
}
