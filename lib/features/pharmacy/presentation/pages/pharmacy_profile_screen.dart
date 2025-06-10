// filepath: d:\0_GitHub\Group\final\medimap_pharmacy_app\lib\features\pharmacy\presentation\pages\pharmacy_profile_screen.dart
import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';
import '../widgets/pharmacy_bottom_navigation.dart';

class PharmacyProfileScreen extends StatefulWidget {
  const PharmacyProfileScreen({super.key});

  @override
  State<PharmacyProfileScreen> createState() => _PharmacyProfileScreenState();
}

class _PharmacyProfileScreenState extends State<PharmacyProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'MediCare Pharmacy');
  final _emailController = TextEditingController(text: 'info@medicare.com');
  final _phoneController = TextEditingController(text: '+94 11 234 5678');
  final _addressController = TextEditingController(text: '123 Galle Road, Colombo 03');
  final _licenseController = TextEditingController(text: 'PH-2024-001234');
  final _descriptionController = TextEditingController(
    text: 'A trusted pharmacy serving the community for over 10 years with quality medicines and healthcare products.',
  );

  bool _isEditing = false;
  
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pharmacy Profile',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save_outlined : Icons.edit_outlined,
              size: screenWidth * 0.055,
            ),
            tooltip: _isEditing ? 'Save Profile' : 'Edit Profile',
            onPressed: () {
              if (_isEditing) {
                if (_formKey.currentState!.validate()) {
                  _saveProfile();
                }
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4CAF50).withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: screenWidth * 0.15,
                              backgroundColor: const Color(0xFF4CAF50),
                              child: Text(
                                'MC',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.09,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (_isEditing)
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.01),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4CAF50),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                    ),
                                  ],
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt_outlined, 
                                    color: Colors.white,
                                    size: screenWidth * 0.05,
                                  ),
                                  onPressed: _changeProfileImage,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenHeight * 0.006,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined, 
                              color: const Color(0xFF4CAF50), 
                              size: screenWidth * 0.05,
                            ),
                            SizedBox(width: screenWidth * 0.02),
                            Text(
                              'Verified Pharmacy',
                              style: TextStyle(
                                color: const Color(0xFF4CAF50),
                                fontWeight: FontWeight.w600,
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),

                // Basic Information
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF4CAF50),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Basic Information',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'Pharmacy Name',
                        controller: _nameController,
                        enabled: _isEditing,
                        icon: Icons.store_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter pharmacy name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'Email Address',
                        controller: _emailController,
                        enabled: _isEditing,
                        icon: Icons.email_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email address';
                          }
                          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'Phone Number',
                        controller: _phoneController,
                        enabled: _isEditing,
                        icon: Icons.phone_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'License Number',
                        controller: _licenseController,
                        enabled: false, // License number should not be editable
                        icon: Icons.badge_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                
                // Location Information
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pin_drop_outlined,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF4CAF50),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Location Information',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'Address',
                        controller: _addressController,
                        enabled: _isEditing,
                        icon: Icons.location_on_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        maxLines: 2,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.04),
                
                // Description
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF4CAF50),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildFormField(
                        label: 'About Pharmacy',
                        controller: _descriptionController,
                        enabled: _isEditing,
                        icon: Icons.description_outlined,
                        screenWidth: screenWidth,
                        screenHeight: screenHeight,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                
                // Operating Hours
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  margin: EdgeInsets.only(top: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule_outlined,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF4CAF50),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Operating Hours',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      _buildOperatingHour('Monday - Friday', '9:00 AM - 8:00 PM'),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 1,
                      ),
                      _buildOperatingHour('Saturday', '9:00 AM - 6:00 PM'),
                      Divider(
                        color: Colors.grey.withOpacity(0.2),
                        thickness: 1,
                      ),
                      _buildOperatingHour('Sunday', '10:00 AM - 4:00 PM'),
                      if (_isEditing) ...[
                        SizedBox(height: screenHeight * 0.02),
                        Center(
                          child: OutlinedButton.icon(
                            onPressed: _editOperatingHours,
                            icon: Icon(
                              Icons.edit_calendar_outlined,
                              size: screenWidth * 0.04,
                            ),
                            label: Text(
                              'Edit Hours',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4CAF50),
                              side: const BorderSide(color: Color(0xFF4CAF50)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                
                // Services Offered
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  margin: EdgeInsets.only(top: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            size: screenWidth * 0.05,
                            color: const Color(0xFF4CAF50),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            'Services Offered',
                            style: TextStyle(
                              fontSize: screenWidth * 0.045,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF333333),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Wrap(
                        spacing: screenWidth * 0.02,
                        runSpacing: screenWidth * 0.02,
                        children: [
                          _buildServiceChip('Prescription Medicines'),
                          _buildServiceChip('OTC Medications'),
                          _buildServiceChip('Health Supplements'),
                          _buildServiceChip('Medical Devices'),
                          _buildServiceChip('Home Delivery'),
                          _buildServiceChip('Health Consultation'),
                        ],
                      ),
                      if (_isEditing) ...[
                        SizedBox(height: screenHeight * 0.02),
                        Center(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Services editing functionality would be implemented here'),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.add_circle_outline,
                              size: screenWidth * 0.04,
                            ),
                            label: Text(
                              'Add Service',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF4CAF50),
                              side: const BorderSide(color: Color(0xFF4CAF50)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.04,
                                vertical: screenHeight * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                
                if (_isEditing) ...[
                  SizedBox(height: screenHeight * 0.04),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _cancelEditing,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey[700],
                            side: BorderSide(color: Colors.grey[400]!),
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.04),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _saveProfile();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4CAF50),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                            elevation: 2,
                            shadowColor: const Color(0xFF4CAF50).withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],

                SizedBox(height: screenHeight * 0.03),

                // Logout Button
                if (!_isEditing) ...[
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _showLogoutDialog(context);
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        size: screenWidth * 0.05,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.018),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      label: Text(
                        'Logout',
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
                
                // Add extra space to account for bottom navigation bar
                SizedBox(height: screenHeight * 0.1),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: PharmacyBottomNavigation(
        currentIndex: 4, // Profile tab
        onTap: (index) => PharmacyBottomNavigation.navigateToPage(context, index),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    required IconData icon,
    required double screenWidth,
    required double screenHeight,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF333333),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        TextFormField(
          controller: controller,
          enabled: enabled,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          style: TextStyle(fontSize: screenWidth * 0.04),
          decoration: InputDecoration(
            prefixIcon: Icon(
              icon,
              size: screenWidth * 0.05,
              color: enabled ? const Color(0xFF4CAF50) : Colors.grey,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: enabled ? const Color(0xFF4CAF50) : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF4CAF50),
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Color(0xFF4CAF50),
                width: 2,
              ),
            ),
            filled: true,
            fillColor: enabled ? Colors.white : Colors.grey.shade100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.015,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOperatingHour(String day, String hours) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: screenWidth * 0.02,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.access_time_outlined,
                size: screenWidth * 0.04,
                color: const Color(0xFF4CAF50),
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                day,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenWidth * 0.005,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              hours,
              style: TextStyle(
                color: const Color(0xFF4CAF50),
                fontSize: screenWidth * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(String service) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Chip(
      avatar: Icon(
        Icons.check_circle_outline,
        size: screenWidth * 0.035,
        color: const Color(0xFF4CAF50),
      ),
      label: Text(
        service,
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFFE0FFE0),
      labelStyle: const TextStyle(color: Color(0xFF4CAF50)),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.01,
        vertical: screenWidth * 0.005,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xFFBFE8BF), width: 1),
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  void _changeProfileImage() {
    // Implementation for changing profile image
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile image change functionality would be implemented here'),
      ),
    );
  }

  void _editOperatingHours() {
    // Implementation for editing operating hours
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Operating hours editing functionality would be implemented here'),
      ),
    );
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            const Text('Profile updated successfully'),
          ],
        ),
        backgroundColor: const Color(0xFF4CAF50),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
      ),
    );
  }

  void _cancelEditing() {
    setState(() {
      _isEditing = false;
      // Reset form fields to original values
      _nameController.text = 'MediCare Pharmacy';
      _emailController.text = 'info@medicare.com';
      _phoneController.text = '+94 11 234 5678';
      _addressController.text = '123 Galle Road, Colombo 03';
      _descriptionController.text = 'A trusted pharmacy serving the community for over 10 years with quality medicines and healthcare products.';
    });
  }

  void _showLogoutDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.logout_outlined,
              color: Colors.red,
              size: screenWidth * 0.055,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to logout?',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[700],
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenWidth * 0.01,
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppConstants.userTypeSelectionRoute,
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.03,
                vertical: screenWidth * 0.01,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _licenseController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
