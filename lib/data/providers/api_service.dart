import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/order.dart';
import '../models/pharmacy.dart';
import '../../core/errors/app_exceptions.dart';
import '../../config/app_constants.dart';

class ApiService {
  static const String _baseUrl = AppConstants.baseUrl;
  static const String _apiVersion = AppConstants.apiVersion;
  static const Duration _timeout = Duration(seconds: 30);

  final http.Client _client;
  String? _authToken;

  ApiService({http.Client? client}) : _client = client ?? http.Client();

  // Set authentication token
  void setAuthToken(String token) {
    _authToken = token;
  }

  // Clear authentication token
  void clearAuthToken() {
    _authToken = null;
  }

  // Get headers with authentication
  Map<String, String> get _headers {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    
    if (_authToken != null) {
      headers['Authorization'] = 'Bearer $_authToken';
    }
    
    return headers;
  }
  // Generic GET request
  Future<Map<String, dynamic>> get(String endpoint) async {
    try {
      final url = Uri.parse('$_baseUrl/$_apiVersion/$endpoint');
      final response = await _client
          .get(url, headers: _headers)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw const TimeoutException();
      }
      throw ExceptionHandler.mapException(e);
    }
  }

  // Generic POST request
  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/$_apiVersion/$endpoint');
      final response = await _client
          .post(
            url,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw const TimeoutException();
      }
      throw ExceptionHandler.mapException(e);
    }
  }

  // Generic PUT request
  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl/$_apiVersion/$endpoint');
      final response = await _client
          .put(
            url,
            headers: _headers,
            body: body != null ? jsonEncode(body) : null,
          )
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw const TimeoutException();
      }
      throw ExceptionHandler.mapException(e);
    }
  }

  // Generic DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('$_baseUrl/$_apiVersion/$endpoint');
      final response = await _client
          .delete(url, headers: _headers)
          .timeout(_timeout);

      return _handleResponse(response);
    } on SocketException {
      throw const NoInternetException();
    } catch (e) {
      if (e.toString().contains('timeout')) {
        throw const TimeoutException();
      }
      throw ExceptionHandler.mapException(e);
    }
  }

  // Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    
    if (statusCode >= 200 && statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        throw const DataParsingException();
      }
    }

    // Handle different status codes
    switch (statusCode) {
      case 400:
        throw ValidationException(_getErrorMessage(response));
      case 401:
        throw const InvalidTokenException();
      case 403:
        throw const UnauthorizedException();
      case 404:
        throw DataNotFoundException(_getErrorMessage(response));
      case 422:
        throw ValidationException(_getErrorMessage(response));
      case 500:
      case 502:
      case 503:
      case 504:
        throw ServerException(_getErrorMessage(response));
      default:
        throw ServerException('Request failed with status: $statusCode');
    }
  }

  // Extract error message from response
  String _getErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      return body['message'] as String? ?? 
             body['error'] as String? ?? 
             'Request failed';
    } catch (e) {
      return 'Request failed with status: ${response.statusCode}';
    }
  }

  // Authentication endpoints
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await post('auth/login', body: {
      'email': email,
      'password': password,
    });
  }

  Future<Map<String, dynamic>> register({
    required String fullName,
    required String email,
    required String password,
    required String userType,
    String? phoneNumber,
  }) async {
    return await post('auth/register', body: {
      'full_name': fullName,
      'email': email,
      'password': password,
      'user_type': userType,
      'phone_number': phoneNumber,
    });
  }

  Future<Map<String, dynamic>> forgotPassword({required String email}) async {
    return await post('auth/forgot-password', body: {
      'email': email,
    });
  }

  Future<Map<String, dynamic>> verifyOTP({
    required String email,
    required String otp,
  }) async {
    return await post('auth/verify-otp', body: {
      'email': email,
      'otp': otp,
    });
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    return await post('auth/reset-password', body: {
      'email': email,
      'otp': otp,
      'new_password': newPassword,
    });
  }

  Future<Map<String, dynamic>> logout() async {
    return await post('auth/logout');
  }

  // User endpoints
  Future<User> getUserProfile() async {
    final response = await get('user/profile');
    return User.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<User> updateUserProfile(Map<String, dynamic> userData) async {
    final response = await put('user/profile', body: userData);
    return User.fromJson(response['data'] as Map<String, dynamic>);
  }

  // Pharmacy endpoints
  Future<List<Pharmacy>> getNearbyPharmacies({
    required double latitude,
    required double longitude,
    double? radius,
  }) async {
    final response = await get(
      'pharmacies/nearby?lat=$latitude&lng=$longitude${radius != null ? '&radius=$radius' : ''}'
    );
    
    return (response['data'] as List)
        .map((pharmacy) => Pharmacy.fromJson(pharmacy as Map<String, dynamic>))
        .toList();
  }

  Future<List<Pharmacy>> searchPharmacies({
    String? query,
    String? city,
    List<String>? services,
  }) async {
    String endpoint = 'pharmacies/search?';
    
    if (query != null) endpoint += 'q=$query&';
    if (city != null) endpoint += 'city=$city&';
    if (services != null && services.isNotEmpty) {
      endpoint += 'services=${services.join(',')}&';
    }
    
    final response = await get(endpoint);
    
    return (response['data'] as List)
        .map((pharmacy) => Pharmacy.fromJson(pharmacy as Map<String, dynamic>))
        .toList();
  }

  Future<Pharmacy> getPharmacyDetails(String pharmacyId) async {
    final response = await get('pharmacies/$pharmacyId');
    return Pharmacy.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<List<Medicine>> getPharmacyMedicines(String pharmacyId) async {
    final response = await get('pharmacies/$pharmacyId/medicines');
    
    return (response['data'] as List)
        .map((medicine) => Medicine.fromJson(medicine as Map<String, dynamic>))
        .toList();
  }

  // Order endpoints
  Future<Order> createOrder(Map<String, dynamic> orderData) async {
    final response = await post('orders', body: orderData);
    return Order.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<List<Order>> getUserOrders() async {
    final response = await get('orders');
    
    return (response['data'] as List)
        .map((order) => Order.fromJson(order as Map<String, dynamic>))
        .toList();
  }

  Future<Order> getOrderDetails(String orderId) async {
    final response = await get('orders/$orderId');
    return Order.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<Order> updateOrderStatus(String orderId, OrderStatus status) async {
    final response = await put('orders/$orderId/status', body: {
      'status': status.name,
    });
    return Order.fromJson(response['data'] as Map<String, dynamic>);
  }

  Future<void> cancelOrder(String orderId) async {
    await delete('orders/$orderId');
  }

  // Medicine search
  Future<List<Medicine>> searchMedicines({
    required String query,
    String? category,
    double? maxPrice,
    bool? requiresPrescription,
  }) async {
    String endpoint = 'medicines/search?q=$query';
    
    if (category != null) endpoint += '&category=$category';
    if (maxPrice != null) endpoint += '&max_price=$maxPrice';
    if (requiresPrescription != null) {
      endpoint += '&requires_prescription=$requiresPrescription';
    }
    
    final response = await get(endpoint);
    
    return (response['data'] as List)
        .map((medicine) => Medicine.fromJson(medicine as Map<String, dynamic>))
        .toList();
  }

  // Clean up
  void dispose() {
    _client.close();
  }
}