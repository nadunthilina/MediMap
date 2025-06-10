import 'package:flutter/material.dart';
import '../../../../config/app_constants.dart';
import '../widgets/pharmacy_bottom_navigation.dart';

class PharmacyDashboardScreen extends StatefulWidget {
  const PharmacyDashboardScreen({super.key});

  @override
  State<PharmacyDashboardScreen> createState() => _PharmacyDashboardScreenState();
}

class _PharmacyDashboardScreenState extends State<PharmacyDashboardScreen> {  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Pharmacy Dashboard',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.notifications_outlined,
                size: screenWidth * 0.055,
                color: const Color(0xFF333333),
              ),
              onPressed: () {},
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              icon: Icon(
                Icons.person_outline,
                size: screenWidth * 0.055,
                color: const Color(0xFF333333),
              ),
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.pharmacyProfileRoute);
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.04,
          vertical: screenHeight * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Header
            Container(
              padding: EdgeInsets.all(screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome to MediMap! 🏥',
                    style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Text(
                    'Manage your pharmacy operations efficiently',
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF666666),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.025),
              // Stats Cards
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'New Orders', 
                    '12', 
                    Icons.shopping_cart_outlined, 
                    Colors.blue,
                    screenWidth,
                    screenHeight,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),                Expanded(
                  child: _buildStatCard(
                    'Total Sales', 
                    'Rs. 452,800', 
                    Icons.monetization_on_outlined, 
                    Colors.green,
                    screenWidth,
                    screenHeight,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.02),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    'Stock Items', 
                    '245', 
                    Icons.inventory_outlined, 
                    Colors.orange,
                    screenWidth,
                    screenHeight,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: _buildStatCard(
                    'Low Stock', 
                    '8', 
                    Icons.warning_outlined, 
                    Colors.red,
                    screenWidth,
                    screenHeight,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),

            // Quick Actions Section
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: screenWidth * 0.03,
              crossAxisSpacing: screenWidth * 0.03,
              childAspectRatio: 1.2,
              children: [
                _buildActionCard(
                  'New Orders',
                  Icons.assignment_outlined,
                  () => Navigator.pushNamed(context, AppConstants.newOrderDetailsRoute),
                  screenWidth,
                  screenHeight,
                ),
                _buildActionCard(
                  'Stock Management',
                  Icons.inventory_2_outlined,
                  () => Navigator.pushNamed(context, AppConstants.stockManagementRoute),
                  screenWidth,
                  screenHeight,
                ),
                _buildActionCard(
                  'Sales Report',
                  Icons.bar_chart_outlined,
                  () => Navigator.pushNamed(context, AppConstants.salesReportRoute),
                  screenWidth,
                  screenHeight,
                ),
                _buildActionCard(
                  'Staff Management',
                  Icons.group_outlined,
                  () => Navigator.pushNamed(context, AppConstants.staffManagementRoute),
                  screenWidth,
                  screenHeight,
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.03),            // Recent Orders Section
            Text(
              'Recent Orders',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            _buildRecentOrdersList(screenWidth, screenHeight),
            SizedBox(height: screenHeight * 0.1), // Bottom navigation space
          ],
        ),
      ),
      bottomNavigationBar: PharmacyBottomNavigation(
        currentIndex: 0, // Dashboard tab
        onTap: (index) => PharmacyBottomNavigation.navigateToPage(context, index),
      ),
    );
  }
  Widget _buildStatCard(String title, String value, IconData icon, Color color, double screenWidth, double screenHeight) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.white, color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.all(screenWidth * 0.02),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon, 
                    color: color, 
                    size: screenWidth * 0.055,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Text(
              title,
              style: TextStyle(
                fontSize: screenWidth * 0.032,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF666666),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(String title, IconData icon, VoidCallback onTap, double screenWidth, double screenHeight) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(screenWidth * 0.04),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.white, const Color(0xFF4CAF50).withOpacity(0.05)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.025),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  icon,
                  size: screenWidth * 0.08,
                  color: const Color(0xFF4CAF50),
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: screenWidth * 0.032,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF333333),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildRecentOrdersList(double screenWidth, double screenHeight) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [            _buildOrderItem('Order #001', 'Paracetamol 500mg', 'Rs. 1,200', 'Pending', screenWidth),
            Divider(height: screenHeight * 0.002),
            _buildOrderItem('Order #002', 'Vitamin D3', 'Rs. 2,500', 'Confirmed', screenWidth),
            Divider(height: screenHeight * 0.002),
            _buildOrderItem('Order #003', 'Cough Syrup', 'Rs. 1,800', 'Ready', screenWidth),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenHeight * 0.02,
              ),
              child: Text(
                'View All Orders',
                style: TextStyle(
                  color: const Color(0xFF4CAF50),
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String orderId, String medicine, String amount, String status, double screenWidth) {
    Color statusColor;
    switch (status) {
      case 'Pending':
        statusColor = Colors.orange;
        break;
      case 'Confirmed':
        statusColor = Colors.blue;
        break;
      case 'Ready':
        statusColor = Colors.green;
        break;
      default:
        statusColor = Colors.grey;
    }

    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: screenWidth * 0.01,
      ),
      leading: Container(
        width: screenWidth * 0.1,
        height: screenWidth * 0.1,
        decoration: BoxDecoration(
          color: const Color(0xFF4CAF50).withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.medical_services_outlined,
          color: const Color(0xFF4CAF50),
          size: screenWidth * 0.05,
        ),
      ),
      title: Text(
        orderId,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: screenWidth * 0.035,
          color: const Color(0xFF1A1A1A),
        ),
      ),
      subtitle: Text(
        medicine,
        style: TextStyle(
          fontSize: screenWidth * 0.03,
          color: const Color(0xFF666666),
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: screenWidth * 0.035,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: screenWidth * 0.01),
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.02,
              vertical: screenWidth * 0.005,
            ),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: screenWidth * 0.025,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}