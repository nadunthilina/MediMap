// Base app exception class
abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  const AppException(this.message, {this.code, this.details});

  @override
  String toString() => message;
}

// Network related exceptions
class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.details});
}

class NoInternetException extends NetworkException {
  const NoInternetException()
      : super('No internet connection. Please check your connection and try again.');
}

class TimeoutException extends NetworkException {
  const TimeoutException()
      : super('Request timed out. Please try again.');
}

class ServerException extends NetworkException {
  const ServerException(super.message, {super.code, super.details});
}

// Authentication related exceptions
class AuthException extends AppException {
  const AuthException(super.message, {super.code, super.details});
}

class InvalidCredentialsException extends AuthException {
  const InvalidCredentialsException()
      : super('Invalid email or password. Please try again.');
}

class UserNotFoundException extends AuthException {
  const UserNotFoundException()
      : super('User not found. Please check your credentials.');
}

class EmailAlreadyExistsException extends AuthException {
  const EmailAlreadyExistsException()
      : super('An account with this email already exists.');
}

class InvalidTokenException extends AuthException {
  const InvalidTokenException()
      : super('Your session has expired. Please login again.');
}

class UnauthorizedException extends AuthException {
  const UnauthorizedException()
      : super('You are not authorized to perform this action.');
}

// Validation related exceptions
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.details});
}

class InvalidEmailException extends ValidationException {
  const InvalidEmailException()
      : super('Please enter a valid email address.');
}

class WeakPasswordException extends ValidationException {
  const WeakPasswordException()
      : super('Password is too weak. Please choose a stronger password.');
}

class InvalidOTPException extends ValidationException {
  const InvalidOTPException()
      : super('Invalid verification code. Please try again.');
}

class ExpiredOTPException extends ValidationException {
  const ExpiredOTPException()
      : super('Verification code has expired. Please request a new one.');
}

// Data related exceptions
class DataException extends AppException {
  const DataException(super.message, {super.code, super.details});
}

class DataNotFoundException extends DataException {
  const DataNotFoundException(String resource)
      : super('$resource not found.');
}

class DataParsingException extends DataException {
  const DataParsingException()
      : super('Failed to process data. Please try again.');
}

// Business logic exceptions
class BusinessLogicException extends AppException {
  const BusinessLogicException(super.message, {super.code, super.details});
}

class InsufficientStockException extends BusinessLogicException {
  const InsufficientStockException(String medicineName)
      : super('Insufficient stock for $medicineName.');
}

class OrderNotAllowedException extends BusinessLogicException {
  const OrderNotAllowedException(String reason)
      : super('Order cannot be placed: $reason');
}

class PaymentFailedException extends BusinessLogicException {
  const PaymentFailedException()
      : super('Payment failed. Please try again or use a different payment method.');
}

// File/Storage related exceptions
class StorageException extends AppException {
  const StorageException(super.message, {super.code, super.details});
}

class FileNotFoundException extends StorageException {
  const FileNotFoundException(String fileName)
      : super('File not found: $fileName');
}

class FileUploadException extends StorageException {
  const FileUploadException()
      : super('Failed to upload file. Please try again.');
}

// Permission related exceptions
class PermissionException extends AppException {
  const PermissionException(super.message, {super.code, super.details});
}

class LocationPermissionException extends PermissionException {
  const LocationPermissionException()
      : super('Location permission is required to find nearby pharmacies.');
}

class CameraPermissionException extends PermissionException {
  const CameraPermissionException()
      : super('Camera permission is required to scan prescriptions.');
}

// Generic exceptions
class UnknownException extends AppException {
  const UnknownException()
      : super('Something went wrong. Please try again.');
}

class FeatureNotImplementedException extends AppException {
  const FeatureNotImplementedException(String feature)
      : super('$feature is not yet implemented.');
}

// Exception handler utility
class ExceptionHandler {
  static String getErrorMessage(dynamic exception) {
    if (exception is AppException) {
      return exception.message;
    } else if (exception is Exception) {
      return exception.toString();
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }

  static AppException mapException(dynamic exception) {
    if (exception is AppException) {
      return exception;
    }
    
    // Map common Flutter/Dart exceptions to custom exceptions
    final errorMessage = exception.toString().toLowerCase();
    
    if (errorMessage.contains('network') || errorMessage.contains('connection')) {
      return const NetworkException('Network error occurred');
    } else if (errorMessage.contains('timeout')) {
      return const TimeoutException();
    } else if (errorMessage.contains('unauthorized') || errorMessage.contains('401')) {
      return const UnauthorizedException();
    } else if (errorMessage.contains('not found') || errorMessage.contains('404')) {
      return DataNotFoundException('Resource');
    } else {
      return const UnknownException();
    }
  }
}