import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  const UserTypeSelectionScreen({super.key});

  @override
  State<UserTypeSelectionScreen> createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  String? selectedUserType;  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),          child: Container(
            constraints: BoxConstraints(minHeight: screenHeight),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              children: [
                SizedBox(height: screenHeight * 0.03),
                
                // Logo and Header
                _buildHeader(screenHeight, screenWidth),
                
                SizedBox(height: screenHeight * 0.06),
                
                // User Type Selection Cards
                _buildUserTypeCards(screenHeight, screenWidth),
                
                SizedBox(height: screenHeight * 0.04),
                
                // Continue Button
                _buildContinueButton(screenHeight, screenWidth),
                
                SizedBox(height: screenHeight * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildHeader(double screenHeight, double screenWidth) {
    return Column(
      children: [
        // Logo with enhanced design
        Container(
          width: screenWidth * 0.25,
          height: screenWidth * 0.25,
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
        
        SizedBox(height: screenHeight * 0.04),
        
        // Title with responsive typography
        Text(
          'Choose Your Account Type',
          style: TextStyle(
            fontSize: screenWidth * 0.065,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        
        SizedBox(height: screenHeight * 0.015),
        
        // Subtitle
        Text(
          'Select how you want to use MediMap',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.grey[600],
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
  Widget _buildUserTypeCards(double screenHeight, double screenWidth) {
    return Column(
      children: [
        // Patient Option
        _buildUserTypeCard(
          userType: AppConstants.userTypePatient,
          title: 'I\'m a Patient',
          subtitle: 'Order medicines and manage prescriptions',
          icon: Icons.person,
          description: 'Find pharmacies, order medicines, upload prescriptions, and track your health',
          screenHeight: screenHeight,
          screenWidth: screenWidth,
        ),
        
        SizedBox(height: screenHeight * 0.025),
        
        // Pharmacy Option
        _buildUserTypeCard(
          userType: AppConstants.userTypePharmacy,
          title: 'I\'m a Pharmacy',
          subtitle: 'Manage pharmacy business and orders',
          icon: Icons.local_pharmacy,
          description: 'Manage inventory, process orders, handle staff, and grow your business',
          screenHeight: screenHeight,
          screenWidth: screenWidth,
        ),
      ],
    );
  }
  Widget _buildUserTypeCard({
    required String userType,
    required String title,
    required String subtitle,
    required IconData icon,
    required String description,
    required double screenHeight,
    required double screenWidth,
  }) {
    final bool isSelected = selectedUserType == userType;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedUserType = userType;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryGreen : Colors.grey[300]!,
            width: isSelected ? 2.5 : 1.5,
          ),
          color: isSelected 
              ? AppTheme.primaryGreen.withOpacity(0.08) 
              : Colors.white,
          boxShadow: [
            BoxShadow(
              color: isSelected 
                  ? AppTheme.primaryGreen.withOpacity(0.2)
                  : Colors.black.withOpacity(0.05),
              blurRadius: isSelected ? 15 : 8,
              offset: Offset(0, isSelected ? 6 : 2),
              spreadRadius: isSelected ? 2 : 0,
            ),
          ],
        ),
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Enhanced Icon Container
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.all(screenWidth * 0.035),
                  decoration: BoxDecoration(
                    color: isSelected ? AppTheme.primaryGreen : Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ] : null,
                  ),
                  child: Icon(
                    icon,
                    size: screenWidth * 0.08,
                    color: isSelected ? Colors.white : Colors.grey[600],
                  ),
                ),
                
                SizedBox(width: screenWidth * 0.04),
                
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: screenWidth * 0.048,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? AppTheme.primaryGreen : Colors.black87,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: screenWidth * 0.035,
                          color: Colors.grey[600],
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Enhanced Selection Indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: screenWidth * 0.065,
                  height: screenWidth * 0.065,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppTheme.primaryGreen : Colors.grey[400]!,
                      width: 2.5,
                    ),
                    boxShadow: isSelected ? [
                      BoxShadow(
                        color: AppTheme.primaryGreen.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ] : null,
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: screenWidth * 0.04,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
            
            SizedBox(height: screenHeight * 0.02),
            
            // Enhanced Description
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenHeight * 0.01,
              ),
              decoration: BoxDecoration(
                color: isSelected 
                    ? AppTheme.primaryGreen.withOpacity(0.05)
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected 
                      ? AppTheme.primaryGreen.withOpacity(0.2)
                      : Colors.grey[200]!,
                  width: 1,
                ),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: screenWidth * 0.037,
                  color: isSelected ? AppTheme.primaryGreen : Colors.grey[700],
                  height: 1.5,
                  fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildContinueButton(double screenHeight, double screenWidth) {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: selectedUserType != null 
            ? LinearGradient(
                colors: [
                  AppTheme.primaryGreen,
                  AppTheme.primaryGreen.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        boxShadow: selectedUserType != null ? [
          BoxShadow(
            color: AppTheme.primaryGreen.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
            spreadRadius: 2,
          ),
        ] : null,
      ),
      child: ElevatedButton(
        onPressed: selectedUserType != null ? _continueToLogin : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: selectedUserType != null 
              ? Colors.transparent 
              : Colors.grey[300],
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.grey[600],
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedUserType != null) ...[
              Icon(
                Icons.arrow_forward_rounded,
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.02),
            ],
            Text(
              selectedUserType != null ? 'Continue' : 'Select an option to continue',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _continueToLogin() {
    if (selectedUserType != null) {
      String targetRoute = selectedUserType == AppConstants.userTypePharmacy
          ? AppConstants.pharmacyLoginRoute
          : AppConstants.patientLoginRoute;
      
      Navigator.pushNamed(context, targetRoute);
    }
  }
}
