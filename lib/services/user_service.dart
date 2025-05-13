import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

class UserService {
  static const String userBoxName = 'users';
  final _uuid = Uuid();

  Future<void> initialize() async {
    await Hive.openBox<User>(userBoxName);
  }

  bool isValidGmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@gmail\.com$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPassword(String password) {
    // Password must be at least 8 characters long and contain:
    // - At least one uppercase letter
    // - At least one lowercase letter
    // - At least one number
    // - At least one special character
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    );
    return passwordRegex.hasMatch(password);
  }

  Future<User?> getUserByEmail(String email) async {
    final box = await Hive.openBox<User>(userBoxName);
    try {
      return box.values.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }

  Future<User> createUser({
    required String email,
    required String password,
    required String name,
  }) async {
    if (!isValidGmail(email)) {
      throw Exception('Please enter a valid Gmail address');
    }

    if (!isValidPassword(password)) {
      throw Exception(
        'Password must be at least 8 characters long and contain uppercase, lowercase, number, and special character',
      );
    }

    final existingUser = await getUserByEmail(email);
    if (existingUser != null) {
      throw Exception('User with this email already exists');
    }

    final user = User(
      id: _uuid.v4(),
      email: email,
      password: password, // In a real app, this should be hashed
      name: name,
    );

    final box = await Hive.openBox<User>(userBoxName);
    await box.put(user.id, user);
    return user;
  }

  Future<User?> authenticateUser(String email, String password) async {
    final user = await getUserByEmail(email);
    if (user == null) {
      throw Exception('User not found');
    }

    if (user.password != password) {
      // In a real app, compare hashed passwords
      throw Exception('Invalid password');
    }

    return user;
  }
}
