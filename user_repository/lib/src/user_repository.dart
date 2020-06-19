abstract class UserRepository {
  Future<bool> isAuthenticated();

  Future<void> authenticate();

  Future<String> loadKey();

  Future<void> deleteKey();

  Future<void> persistKey(List<int> encryptionKey);

  Future<List<int>> getKey();

  Future<bool> hasKey(); 
}
