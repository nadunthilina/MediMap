import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';
import '../../../../core/utils/app_validators.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_button.dart';

class PharmacySignupScreen extends StatefulWidget {
  const PharmacySignupScreen({super.key});

  @override
  State<PharmacySignupScreen> createState() => _PharmacySignupScreenState();
}

class _PharmacySignupScreenState extends State<PharmacySignupScreen> {
  final _pharmacyNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _licenseNumberController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void dispose() {
    _pharmacyNameController.dispose();
    _ownerNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _licenseNumberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _signUp() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));

      setState(() {
        _isLoading = false;
      });      if (mounted) {
        Navigator.pushReplacementNamed(
          context,
          AppConstants.successRoute,
          arguments: {
            'title': 'Pharmacy Account Created!',
            'message': 'Your pharmacy has been registered successfully. You can now start managing your business.',
            'buttonText': 'Access Dashboard',
            'onButtonPressed': () {
              Navigator.pushNamedAndRemoveUntil(
                context, 
                AppConstants.pharmacyDashboardRoute,
                (Route<dynamic> route) => false,
              );
            },
          },
        );
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87, size: screenWidth * 0.06),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.02,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,              children: [
                SizedBox(height: screenHeight * 0.04),
                
                // Logo with enhanced design
                Center(
                  child: Container(
                    width: screenWidth * 0.18,
                    height: screenWidth * 0.18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 5,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(
                        color: AppTheme.primaryGreen.withOpacity(0.1),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                
                // Title with responsive typography
                Text(
                  'Register Your Pharmacy',
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.008),
                Text(
                  'Join our network and grow your pharmacy business',
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    color: const Color(0xFF666666),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.035),                
                // Pharmacy Name
                CustomTextField(
                  label: 'Pharmacy Name',
                  controller: _pharmacyNameController,
                  validator: AppValidators.validateName,
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Owner Name
                CustomTextField(
                  label: 'Owner Name',
                  controller: _ownerNameController,
                  validator: AppValidators.validateName,
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Email
                CustomTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: AppValidators.validateEmail,
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Phone Number
                CustomTextField(
                  label: 'Phone Number',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  validator: AppValidators.validatePhoneNumber,
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // License Number
                CustomTextField(
                  label: 'Pharmacy License Number',
                  controller: _licenseNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter license number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Address
                CustomTextField(
                  label: 'Pharmacy Address',
                  controller: _addressController,
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter pharmacy address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Password
                CustomTextField(
                  label: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  showPasswordToggle: true,
                  validator: AppValidators.validatePassword,
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Confirm Password
                CustomTextField(
                  label: 'Confirm Password',
                  controller: _confirmPasswordController,
                  obscureText: true,
                  showPasswordToggle: true,
                  validator: (value) => AppValidators.validateConfirmPassword(
                    value,
                    _passwordController.text,
                  ),
                ),
                SizedBox(height: screenHeight * 0.035),
                
                // Sign Up Button
                CustomButton(
                  text: 'Register Pharmacy',
                  onPressed: _signUp,
                  isLoading: _isLoading,
                ),
                SizedBox(height: screenHeight * 0.025),
                
                // Sign In Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF666666),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, AppConstants.pharmacyLoginRoute);
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w600,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.025),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
