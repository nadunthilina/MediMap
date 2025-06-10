import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
            vertical: screenHeight * 0.02,
          ),
          child: Column(
            children: [
              // Top spacing
              SizedBox(height: screenHeight * 0.04),
              
              // App title
              Text(
                'MediMap',
                style: TextStyle(
                  fontSize: screenWidth * 0.08,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: const Color(0xFF23B1A4),
                  fontFamily: 'Montserrat',
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              
              // Subtitle
              Text(
                'Pharmacy Finder',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                  color: Colors.black54,
                ),
              ),
              
              // Flexible space for logo
              Expanded(
                flex: 3,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: screenWidth * 0.6,
                      maxHeight: screenHeight * 0.5,
                    ),
                    child: Image.asset(
                      'assets/images/Hero_img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              
              // Welcome text section
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Let's get started!",
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015),
                    Text(
                      'Login to enjoy the features we\'ve provided, and stay healthy!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Get Started Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF23B1A4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.02,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      AppConstants.onboardingRoute,
                    );
                  },
                  child: Text(
                    'GET STARTED',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              
              // Bottom spacing
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
