abstract class UserRepository {
  Future<bool> authenticate(String password);

  Future<void> authenticateWithoutPW();

  Future<void> register(String password);

  Future<bool> isRegistered();

  Future<String> loadKey();

  Future<void> deleteKey();

  Future<void> persistKey(List<int> encryptionKey);

  Future<List<int>> getKey();

  Future<bool> hasKey(); 
}
