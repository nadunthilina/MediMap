import 'package:flutter/material.dart';
import '../config/app_constants.dart';
import '../features/auth/presentation/pages/splash_screen.dart';
import '../features/auth/presentation/pages/onboarding_screen.dart';
import '../features/auth/presentation/pages/user_type_selection_screen.dart';
import '../features/auth/presentation/pages/patient_login_screen.dart';
import '../features/auth/presentation/pages/patient_signup_screen.dart';
import '../features/auth/presentation/pages/pharmacy_login_screen.dart';
import '../features/auth/presentation/pages/pharmacy_signup_screen.dart';
import '../features/auth/presentation/pages/forgot_password_screen.dart';
import '../features/auth/presentation/pages/otp_verification_screen.dart';
import '../features/auth/presentation/pages/reset_password_screen.dart';
import '../features/auth/presentation/pages/success_screen.dart';
import '../features/patient/presentation/pages/patient_dashboard_screen.dart';
import '../features/patient/presentation/pages/patient_home_screen.dart';
import '../features/patient/presentation/pages/patient_search_screen.dart';
import '../features/patient/presentation/pages/patient_notifications_screen.dart';
import '../features/patient/presentation/pages/patient_profile_screen.dart';
import '../features/patient/presentation/pages/prescription_upload_screen.dart';
import '../features/patient/presentation/pages/medicine_detail_screen.dart';
import '../features/patient/presentation/pages/shopping_cart_screen.dart';
import '../features/patient/presentation/pages/patient_order_history_screen.dart';
import '../features/patient/presentation/pages/order_confirmation_screen.dart';
import '../features/patient/presentation/pages/edit_profile_screen.dart';
import '../features/patient/presentation/pages/help_support_screen.dart';
import '../features/patient/presentation/pages/chat_support_screen.dart';
import '../features/patient/presentation/pages/payment_options_screen.dart';
import '../features/patient/presentation/pages/add_card_screen.dart';
import '../features/patient/presentation/pages/delivery_options_screen.dart';
import '../features/patient/presentation/pages/address_management_screen.dart';
import '../features/patient/presentation/pages/order_status_screen.dart';
import '../features/patient/presentation/pages/order_details_screen.dart';
import '../features/patient/presentation/pages/rating_screen.dart';
import '../features/patient/presentation/pages/saved_medicines_screen.dart';
import '../features/patient/presentation/pages/my_prescriptions_screen.dart';
import '../features/pharmacy/presentation/pages/pharmacy_dashboard_screen.dart';
import '../features/pharmacy/presentation/pages/stock_management_screen.dart';
import '../features/pharmacy/presentation/pages/pharmacy_profile_screen.dart';
import '../features/pharmacy/presentation/pages/new_order_details_screen.dart';
import '../features/pharmacy/presentation/pages/sales_report_screen.dart';
import '../features/pharmacy/presentation/pages/staff_management_screen.dart';
import '../features/pharmacy/presentation/pages/promotion_management_screen.dart';

class AppRoutes {  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppConstants.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppConstants.onboardingRoute:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case AppConstants.userTypeSelectionRoute:
        return MaterialPageRoute(builder: (_) => const UserTypeSelectionScreen());
      case AppConstants.patientLoginRoute:
        return MaterialPageRoute(builder: (_) => const PatientLoginScreen());      case AppConstants.patientSignupRoute:
        return MaterialPageRoute(builder: (_) => const PatientSignupScreen());
      case AppConstants.pharmacyLoginRoute:
        return MaterialPageRoute(builder: (_) => const PharmacyLoginScreen());
      case AppConstants.pharmacySignupRoute:
        return MaterialPageRoute(builder: (_) => const PharmacySignupScreen());
      case AppConstants.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case AppConstants.otpVerificationRoute:
        return MaterialPageRoute(builder: (_) => const OTPVerificationScreen());
      case AppConstants.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ResetPasswordScreen());
      case AppConstants.successRoute:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => SuccessScreen(
            title: args?['title'] ?? 'Success!',
            message: args?['message'] ?? 'Operation completed successfully',
            buttonText: args?['buttonText'] ?? 'Continue',
            onButtonPressed: args?['onButtonPressed'],
          ),
        );
      case AppConstants.patientDashboardRoute:
        return MaterialPageRoute(builder: (_) => const PatientDashboardScreen());
      case AppConstants.patientHomeRoute:
        return MaterialPageRoute(builder: (_) => const PatientHomeScreen());
      case AppConstants.patientSearchRoute:
        return MaterialPageRoute(builder: (_) => const PatientSearchScreen());
      case AppConstants.patientNotificationsRoute:
        return MaterialPageRoute(builder: (_) => const PatientNotificationsScreen());      case AppConstants.patientProfileRoute:
        return MaterialPageRoute(builder: (_) => const PatientProfileScreen());
      case AppConstants.prescriptionUploadRoute:
        return MaterialPageRoute(builder: (_) => const PrescriptionUploadScreen());
      case AppConstants.medicineDetailRoute:
        return MaterialPageRoute(builder: (_) => const MedicineDetailScreen());
      case AppConstants.cartRoute:
        return MaterialPageRoute(builder: (_) => const ShoppingCartScreen());
      case AppConstants.orderConfirmationRoute:
        return MaterialPageRoute(builder: (_) => const OrderConfirmationScreen());
      case AppConstants.editProfileRoute:
        return MaterialPageRoute(builder: (_) => const EditProfileScreen());
      case AppConstants.helpSupportRoute:
        return MaterialPageRoute(builder: (_) => const HelpSupportScreen());
      case AppConstants.chatSupportRoute:
        return MaterialPageRoute(builder: (_) => const ChatSupportScreen());
      case AppConstants.myPrescriptionsRoute:
        return MaterialPageRoute(builder: (_) => const MyPrescriptionsScreen());
      case AppConstants.deliveryOptionsRoute:
        return MaterialPageRoute(builder: (_) => const DeliveryOptionsScreen());      case AppConstants.addressManagementRoute:
        return MaterialPageRoute(builder: (_) => const AddressManagementScreen());
      case AppConstants.paymentOptionsRoute:
        return MaterialPageRoute(builder: (_) => const PaymentOptionsScreen());
      case AppConstants.addCardRoute:
        return MaterialPageRoute(builder: (_) => const AddCardScreen());
      case AppConstants.paymentMethodsRoute:
        // Temporary redirect to payment options until PaymentMethodsScreen is implemented
        return MaterialPageRoute(builder: (_) => const PaymentOptionsScreen());
      case AppConstants.orderStatusRoute:
        return MaterialPageRoute(builder: (_) => const OrderStatusScreen());
      case AppConstants.orderDetailsRoute:
        return MaterialPageRoute(builder: (_) => const OrderDetailsScreen());
      case AppConstants.orderTrackingRoute:
        // Temporary redirect to order status until OrderTrackingScreen is implemented
        return MaterialPageRoute(builder: (_) => const OrderStatusScreen());
      case AppConstants.ratingRoute:
        return MaterialPageRoute(builder: (_) => const RatingScreen());
      case AppConstants.savedMedicinesRoute:
        return MaterialPageRoute(builder: (_) => const SavedMedicinesScreen());
      case AppConstants.patientOrderHistoryRoute:
        return MaterialPageRoute(builder: (_) => const PatientOrderHistoryScreen());
      case AppConstants.pharmacyDashboardRoute:
        return MaterialPageRoute(builder: (_) => const PharmacyDashboardScreen());
      case AppConstants.newOrderDetailsRoute:
        return MaterialPageRoute(builder: (_) => const NewOrderDetailsScreen());
      case AppConstants.stockManagementRoute:
        return MaterialPageRoute(builder: (_) => const StockManagementScreen());
      case AppConstants.pharmacyProfileRoute:
        return MaterialPageRoute(builder: (_) => const PharmacyProfileScreen());
      case AppConstants.salesReportRoute:
        return MaterialPageRoute(builder: (_) => const SalesReportScreen());
      case AppConstants.staffManagementRoute:
        return MaterialPageRoute(builder: (_) => const StaffManagementScreen());
      case AppConstants.promotionManagementRoute:
        return MaterialPageRoute(builder: (_) => const PromotionManagementScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}