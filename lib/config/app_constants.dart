class AppConstants {
  // App Information
  static const String appName = 'MediMap';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Find your medicines easily from trusted pharmacies';

  // API Configuration
  static const String baseUrl = 'https://api.medimap.com';
  static const String apiVersion = 'v1';
  // Routes
  static const String splashRoute = '/';
  static const String onboardingRoute = '/onboarding';
  static const String userTypeSelectionRoute = '/user-type-selection';
  static const String patientLoginRoute = '/patient-login';
  static const String patientSignupRoute = '/patient-signup';
  static const String pharmacyLoginRoute = '/pharmacy-login';
  static const String pharmacySignupRoute = '/pharmacy-signup';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String otpVerificationRoute = '/otp-verification';
  static const String resetPasswordRoute = '/reset-password';
  static const String successRoute = '/success';
  
  // Patient Routes
  static const String patientDashboardRoute = '/patient-dashboard';
  static const String patientHomeRoute = '/patient-home';
  static const String patientSearchRoute = '/patient-search';
  static const String patientNotificationsRoute = '/patient-notifications';
  static const String patientProfileRoute = '/patient-profile';
  static const String editProfileRoute = '/edit-profile';
  static const String helpSupportRoute = '/help-support';
  static const String chatSupportRoute = '/chat-support';
  static const String prescriptionUploadRoute = '/prescription-upload';
  static const String medicineDetailRoute = '/medicine-detail';
  static const String cartRoute = '/cart';
  static const String myPrescriptionsRoute = '/my-prescriptions';
  static const String orderConfirmationRoute = '/order-confirmation';
  static const String deliveryOptionsRoute = '/delivery-options';
  static const String addressManagementRoute = '/address-management';
  static const String paymentOptionsRoute = '/payment-options';
  static const String addCardRoute = '/add-card';
  static const String paymentMethodsRoute = '/payment-methods';
  static const String orderStatusRoute = '/order-status';
  static const String orderDetailsRoute = '/order-details';
  static const String orderTrackingRoute = '/order-tracking';
  static const String ratingRoute = '/rating';
  static const String savedMedicinesRoute = '/saved-medicines';
  static const String patientOrderHistoryRoute = '/patient-order-history';
  
  // Pharmacy Routes
  static const String pharmacyDashboardRoute = '/pharmacy-dashboard';
  static const String newOrderDetailsRoute = '/new-order-details';
  static const String stockManagementRoute = '/stock-management';
  static const String pharmacyProfileRoute = '/pharmacy-profile';
  static const String salesReportRoute = '/sales-report';
  static const String staffManagementRoute = '/staff-management';
  static const String promotionManagementRoute = '/promotion-management';

  // User Types
  static const String userTypePatient = 'patient';
  static const String userTypePharmacy = 'pharmacy';

  // Shared Preferences Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyUserToken = 'user_token';
  static const String keyUserType = 'user_type';
  static const String keyUserId = 'user_id';
  static const String keyUserEmail = 'user_email';

  // Validation Constants
  static const int minPasswordLength = 8;
  static const int otpLength = 6;
  static const int otpExpiryMinutes = 5;

  // UI Constants
  static const double defaultPadding = 20.0;
  static const double cardBorderRadius = 15.0;
  static const double buttonBorderRadius = 10.0;
  static const double inputBorderRadius = 8.0;

  // Assets
  static const String logoPath = 'assets/images/logo.png';
  static const String onboardingImage1 = 'assets/images/onboarding_1.png';
  static const String onboardingImage2 = 'assets/images/onboarding_2.png';
  static const String onboardingImage3 = 'assets/images/onboarding_3.png';

  // Error Messages
  static const String errorNetworkConnection = 'Please check your internet connection';
  static const String errorInvalidCredentials = 'Invalid email or password';
  static const String errorUserNotFound = 'User not found';
  static const String errorEmailExists = 'Email already exists';
  static const String errorInvalidOTP = 'Invalid verification code';
  static const String errorOTPExpired = 'Verification code has expired';
  static const String errorGeneral = 'Something went wrong. Please try again';

  // Success Messages
  static const String successRegistration = 'Registration successful!';
  static const String successPasswordReset = 'Password reset successful!';
  static const String successOTPSent = 'Verification code sent successfully';
  static const String successOTPVerified = 'Verification successful';
}