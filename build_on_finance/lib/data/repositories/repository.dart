abstract class Repository<T> {
  Future<int> insert(T item);
  Future<T?> getById(int id);
  Future<List<T>> getAll();
  Future<int> update(T item);
  Future<int> delete(int id);
}
