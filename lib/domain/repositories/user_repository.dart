import '../entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getAllUsers();
  Future<User> createUser(User user);
  Future<User> updateUser(int id, User user);
  Future<void> deleteUser(int id);
}
