import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../providers/api_service.dart';
import '../../config/app_constants.dart';
import '../../core/errors/app_exceptions.dart';

class AuthRepository {
  final ApiService _apiService;
  final SharedPreferences _prefs;

  AuthRepository({
    required ApiService apiService,
    required SharedPreferences prefs,
  })  : _apiService = apiService,
        _prefs = prefs;

  // Login user
  Future<User> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      final user = User.fromJson(response['user'] as Map<String, dynamic>);
      final token = response['token'] as String;

      // Store authentication data
      await _storeAuthData(user, token);

      // Set token in API service
      _apiService.setAuthToken(token);

      return user;
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Register user
  Future<User> register({
    required String fullName,
    required String email,
    required String password,
    required String userType,
    String? phoneNumber,
  }) async {
    try {
      final response = await _apiService.register(
        fullName: fullName,
        email: email,
        password: password,
        userType: userType,
        phoneNumber: phoneNumber,
      );

      final user = User.fromJson(response['user'] as Map<String, dynamic>);
      final token = response['token'] as String;

      // Store authentication data
      await _storeAuthData(user, token);

      // Set token in API service
      _apiService.setAuthToken(token);

      return user;
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Forgot password
  Future<void> forgotPassword({required String email}) async {
    try {
      await _apiService.forgotPassword(email: email);
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Verify OTP
  Future<void> verifyOTP({
    required String email,
    required String otp,
  }) async {
    try {
      await _apiService.verifyOTP(email: email, otp: otp);
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Reset password
  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    try {
      await _apiService.resetPassword(
        email: email,
        otp: otp,
        newPassword: newPassword,
      );
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Logout user
  Future<void> logout() async {
    try {
      // Call logout API if token exists
      if (await isLoggedIn()) {
        try {
          await _apiService.logout();
        } catch (e) {
          // Continue with local logout even if API call fails
        }
      }

      // Clear local auth data
      await _clearAuthData();

      // Clear token from API service
      _apiService.clearAuthToken();
    } catch (e) {
      throw ExceptionHandler.mapException(e);
    }
  }

  // Check if user is logged in
  Future<bool> isLoggedIn() async {
    try {
      final token = _prefs.getString(AppConstants.keyUserToken);
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  // Get current user
  Future<User?> getCurrentUser() async {
    try {
      if (!await isLoggedIn()) {
        return null;
      }

      // Try to get user from API first
      try {
        final user = await _apiService.getUserProfile();
        await _storeUserData(user);
        return user;
      } catch (e) {
        // If API call fails, get from local storage
        return await _getUserFromStorage();
      }
    } catch (e) {
      return null;
    }
  }

  // Get stored user from local storage
  Future<User?> getStoredUser() async {
    try {
      return await _getUserFromStorage();
    } catch (e) {
      return null;
    }
  }

  // Refresh token
  Future<void> refreshToken() async {
    try {
      if (!await isLoggedIn()) {
        throw const InvalidTokenException();
      }

      // In a real app, you would call a refresh token endpoint
      // For now, we'll just validate the current token
      await getCurrentUser();
    } catch (e) {
      // If refresh fails, logout the user
      await logout();
      throw const InvalidTokenException();
    }
  }

  // Initialize auth state
  Future<void> initializeAuth() async {
    try {
      final token = _prefs.getString(AppConstants.keyUserToken);
      if (token != null && token.isNotEmpty) {
        _apiService.setAuthToken(token);
      }
    } catch (e) {
      // Handle initialization error silently
    }
  }

  // Private helper methods

  // Store authentication data
  Future<void> _storeAuthData(User user, String token) async {
    await _prefs.setString(AppConstants.keyUserToken, token);
    await _storeUserData(user);
  }

  // Store user data
  Future<void> _storeUserData(User user) async {
    await _prefs.setString(AppConstants.keyUserId, user.id);
    await _prefs.setString(AppConstants.keyUserEmail, user.email);
    await _prefs.setString(AppConstants.keyUserType, user.userType);
    
    // Store full user object as JSON
    await _prefs.setString('user_data', user.toJson().toString());
  }

  // Get user from storage
  Future<User?> _getUserFromStorage() async {
    try {
      final userId = _prefs.getString(AppConstants.keyUserId);
      final email = _prefs.getString(AppConstants.keyUserEmail);
      final userType = _prefs.getString(AppConstants.keyUserType);

      if (userId != null && email != null && userType != null) {
        // For now, create a basic user object
        // In a real app, you'd parse the full user data from JSON
        return User(
          id: userId,
          fullName: 'User', // You'd get this from stored data
          email: email,
          userType: userType,
          createdAt: DateTime.now(),
        );
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // Clear authentication data
  Future<void> _clearAuthData() async {
    await _prefs.remove(AppConstants.keyUserToken);
    await _prefs.remove(AppConstants.keyUserId);
    await _prefs.remove(AppConstants.keyUserEmail);
    await _prefs.remove(AppConstants.keyUserType);
    await _prefs.remove('user_data');
  }
}