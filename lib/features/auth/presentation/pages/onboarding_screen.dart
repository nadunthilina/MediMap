import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Find Your Medicines Easily',
      description: 'Discover a wide range of medications from trusted pharmacies near you. Fast, reliable, and convenient.',
      image: 'assets/images/onboarding_1.png',
    ),
    OnboardingPage(
      title: 'Quick & Safe Delivery',
      description: 'Get your medicines delivered quickly to your doorstep with our secure and reliable delivery service.',
      image: 'assets/images/onboarding_2.png',
    ),
    OnboardingPage(
      title: 'Trusted Pharmacies',
      description: 'Connect with licensed pharmacies and certified professionals for all your healthcare needs.',
      image: 'assets/images/onboarding_3.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(_pages[index], screenHeight, screenWidth);
                },
              ),
            ),
            _buildBottomSection(screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }  Widget _buildOnboardingPage(OnboardingPage page, double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        children: [
          // Character image at the top with responsive height
          Container(
            width: double.infinity,
            height: screenHeight * 0.35,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppTheme.primaryGreen.withValues(alpha: 0.1),
                  Colors.white,
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: screenWidth * 0.7,
                  maxHeight: screenHeight * 0.5,
                ),
                child: Image.asset(
                  'assets/images/character 1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          
          // Content section with flexible spacing
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.08,
                vertical: screenHeight * 0.04,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    page.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textPrimary,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    page.description,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      color: AppTheme.textSecondary,
                      height: 1.6,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildBottomSection(double screenHeight, double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.06,
        vertical: screenHeight * 0.025,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Page indicators with better spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _pages.length,
              (index) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.015),
                width: _currentPage == index ? screenWidth * 0.08 : screenWidth * 0.025,
                height: screenWidth * 0.025,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: _currentPage == index
                      ? AppTheme.primaryGreen
                      : Colors.grey[300],
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          
          // Main action button
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.065,
            child: ElevatedButton(
              onPressed: () {
                if (_currentPage == _pages.length - 1) {
                  Navigator.pushReplacementNamed(context, AppConstants.userTypeSelectionRoute);
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                elevation: 2,
                shadowColor: AppTheme.primaryGreen.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                _currentPage == _pages.length - 1 ? 'Get Started' : 'Next',
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.015),
          
          // Skip button with improved design
          SizedBox(
            width: double.infinity,
            height: screenHeight * 0.055,
            child: OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppConstants.userTypeSelectionRoute);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: AppTheme.primaryGreen,
                side: BorderSide(
                  color: AppTheme.primaryGreen.withOpacity(0.3),
                  width: 1.5,
                ),
                backgroundColor: AppTheme.backgroundGreen.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
  });
}
