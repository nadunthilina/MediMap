import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../widgets/pharmacy_bottom_navigation.dart';

class SalesReportScreen extends StatefulWidget {
  const SalesReportScreen({super.key});

  @override
  State<SalesReportScreen> createState() => _SalesReportScreenState();
}

class _SalesReportScreenState extends State<SalesReportScreen> {
  String _selectedPeriod = 'This Month';
  final List<String> _periods = ['Today', 'This Week', 'This Month', 'Last Month', 'This Year'];
  // Sample sales data with Sri Lankan context
  final List<SaleRecord> _salesData = [
    SaleRecord(
      date: DateTime.now().subtract(const Duration(days: 1)),
      orderId: 'ORD-001',
      customerName: 'Nimal Perera',
      items: 3,
      total: 4875.00,
      paymentMethod: 'Credit Card',
    ),
    SaleRecord(
      date: DateTime.now().subtract(const Duration(days: 2)),
      orderId: 'ORD-002',
      customerName: 'Sita Fernando',
      items: 2,
      total: 2850.00,
      paymentMethod: 'Cash',
    ),
    SaleRecord(
      date: DateTime.now().subtract(const Duration(days: 3)),
      orderId: 'ORD-003',
      customerName: 'Kamal Silva',
      items: 5,
      total: 7320.00,
      paymentMethod: 'eZCash',
    ),
    SaleRecord(
      date: DateTime.now().subtract(const Duration(days: 4)),
      orderId: 'ORD-004',
      customerName: 'Priya Jayawardena',
      items: 1,
      total: 1450.00,
      paymentMethod: 'Visa Card',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],      appBar: AppBar(
        title: Text(
          'Sales Report',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.download_outlined,
              size: screenWidth * 0.055,
            ),
            tooltip: 'Export Report',
            onPressed: _exportReport,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPeriodSelector(screenWidth, screenHeight),
          _buildSummaryCards(screenWidth, screenHeight),
          Expanded(
            child: _buildSalesChart(screenWidth, screenHeight),
          ),          
          Expanded(
            child: _buildSalesHistory(screenWidth, screenHeight),
          ),
        ],
      ),
      bottomNavigationBar: PharmacyBottomNavigation(
        currentIndex: 3, // Reports tab
        onTap: (index) => PharmacyBottomNavigation.navigateToPage(context, index),
      ),
    );
  }
  Widget _buildPeriodSelector(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.01,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedPeriod,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
          items: _periods.map((period) {
            return DropdownMenuItem(
              value: period,
              child: Text(period),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedPeriod = value!;
            });
          },
        ),
      ),
    );
  }
  Widget _buildSummaryCards(double screenWidth, double screenHeight) {
    final totalSales = _salesData.fold<double>(0, (sum, sale) => sum + sale.total);
    final totalOrders = _salesData.length;
    final averageOrderValue = totalOrders > 0 ? totalSales / totalOrders : 0.0;
    final totalItems = _salesData.fold<int>(0, (sum, sale) => sum + sale.items);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(                child: _buildSummaryCard(
                  'Total Sales',
                  'Rs.${totalSales.toStringAsFixed(2)}',
                  Icons.monetization_on_outlined,
                  AppTheme.primaryGreen,
                  screenWidth,
                  screenHeight,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: _buildSummaryCard(
                  'Orders',
                  totalOrders.toString(),
                  Icons.shopping_cart_outlined,
                  Colors.blue,
                  screenWidth,
                  screenHeight,
            ),          ),
            ],
          ),
          SizedBox(height: screenHeight * 0.02),
          Row(
            children: [
              Expanded(                child: _buildSummaryCard(
                  'Avg. Order',
                  'Rs.${averageOrderValue.toStringAsFixed(2)}',
                  Icons.trending_up_outlined,
                  Colors.orange,
                  screenWidth,
                  screenHeight,
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              Expanded(
                child: _buildSummaryCard(
                  'Items Sold',
                  totalItems.toString(),
                  Icons.inventory_2_outlined,
                  Colors.purple,
                  screenWidth,
                  screenHeight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.035),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, color.withOpacity(0.05)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: screenWidth * 0.06),
          SizedBox(height: screenHeight * 0.01),
          Text(
            value,
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.005),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }  Widget _buildSalesChart(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      padding: EdgeInsets.all(screenWidth * 0.035),
      height: screenHeight * 0.22, // Slightly reduced height for better mobile fit
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.grey.shade50],
        ),
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
          Row(
            children: [
              Icon(
                Icons.insights_outlined, 
                color: AppTheme.primaryGreen,
                size: screenWidth * 0.05,
              ),
              SizedBox(width: screenWidth * 0.02),
              Text(
                'Sales Trend',
                style: TextStyle(
                  fontSize: screenWidth * 0.038, // Slightly smaller for mobile
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.012), // Reduced spacing
          Expanded(
            child: _buildSimpleChart(screenWidth, screenHeight),
          ),
        ],
      ),
    );
  }Widget _buildSimpleChart(double screenWidth, double screenHeight) {
    // Simple bar chart representation
    final maxSale = _salesData.isNotEmpty 
        ? _salesData.map((sale) => sale.total).reduce((a, b) => a > b ? a : b)
        : 0.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015), // Slightly reduced padding
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: _salesData.asMap().entries.map((entry) {
          final sale = entry.value;
          final height = maxSale > 0 ? (sale.total / maxSale) * (screenHeight * 0.10) : 0.0; // Reduced chart height
          final index = entry.key;
          final isLatest = index == 0;
          
          return Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.008), // Reduced horizontal padding
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Rs.${(sale.total / 1000).toStringAsFixed(0)}k', // Show in thousands for space
                    style: TextStyle(
                      fontSize: screenWidth * 0.024, // Slightly smaller font
                      fontWeight: isLatest ? FontWeight.bold : FontWeight.normal,
                      color: isLatest ? AppTheme.primaryGreen : Colors.black87,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.006), // Reduced spacing
                  Container(
                    width: screenWidth * 0.09, // Slightly wider bars
                    height: height.clamp(18, double.infinity), // Minimum height adjusted
                    decoration: BoxDecoration(
                      color: isLatest 
                        ? AppTheme.primaryGreen 
                        : AppTheme.primaryGreen.withOpacity(0.6 + (index * 0.1).clamp(0.0, 0.4)),
                      borderRadius: BorderRadius.circular(5), // Slightly smaller radius
                      boxShadow: isLatest ? [
                        BoxShadow(
                          color: AppTheme.primaryGreen.withOpacity(0.3),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ] : null,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.006), // Reduced spacing
                  Text(
                    '${sale.date.day}/${sale.date.month}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.022, // Smaller date font
                      fontWeight: isLatest ? FontWeight.w500 : FontWeight.normal,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
  Widget _buildSalesHistory(double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
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
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.045),
            child: Row(
              children: [
                Icon(
                  Icons.receipt_outlined,
                  size: screenWidth * 0.05,
                  color: AppTheme.primaryGreen,
                ),
                SizedBox(width: screenWidth * 0.02),
                Text(
                  'Recent Sales',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
          ),          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              itemCount: _salesData.length,
              separatorBuilder: (context, index) => Divider(
                height: screenHeight * 0.02,
                thickness: 1,
                color: Colors.grey.withOpacity(0.1),
              ),
              itemBuilder: (context, index) {
                final sale = _salesData[index];
                return _buildSaleItem(sale, screenWidth, screenHeight);
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
  Widget _buildSaleItem(SaleRecord sale, double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.1,
            height: screenWidth * 0.1,
            decoration: BoxDecoration(
              color: AppTheme.primaryGreen.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.shopping_bag_outlined,
              color: AppTheme.primaryGreen,
              size: screenWidth * 0.05,
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sale.orderId,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
                SizedBox(height: screenHeight * 0.003),
                Text(
                  sale.customerName,
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: screenHeight * 0.003),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.015,
                        vertical: screenHeight * 0.002,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '${sale.items} items',
                        style: TextStyle(
                          fontSize: screenWidth * 0.025,
                          color: AppTheme.primaryGreen,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Text(
                      sale.paymentMethod,
                      style: TextStyle(
                        fontSize: screenWidth * 0.025,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [              Text(
                'Rs.${sale.total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryGreen,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                _formatDate(sale.date),
                style: TextStyle(
                  fontSize: screenWidth * 0.025,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
  void _exportReport() {
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
              Icons.file_download_outlined,
              color: AppTheme.primaryGreen,
              size: screenWidth * 0.055,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              'Export Report',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose export format:',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildExportOption(
                  icon: Icons.picture_as_pdf_outlined,
                  label: 'PDF',
                  onTap: () {
                    Navigator.pop(context);
                    _showExportSuccess('PDF');
                  },
                ),
                _buildExportOption(
                  icon: Icons.table_chart_outlined,
                  label: 'Excel',
                  onTap: () {
                    Navigator.pop(context);
                    _showExportSuccess('Excel');
                  },
                ),
                _buildExportOption(
                  icon: Icons.text_snippet_outlined,
                  label: 'CSV',
                  onTap: () {
                    Navigator.pop(context);
                    _showExportSuccess('CSV');
                  },
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildExportOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: screenWidth * 0.025,
          horizontal: screenWidth * 0.03,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryGreen,
              size: screenWidth * 0.07,
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              label,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showExportSuccess(String format) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            Text('Sales report exported as $format successfully!'),
          ],
        ),
        backgroundColor: AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

class SaleRecord {
  final DateTime date;
  final String orderId;
  final String customerName;
  final int items;
  final double total;
  final String paymentMethod;

  SaleRecord({
    required this.date,
    required this.orderId,
    required this.customerName,
    required this.items,
    required this.total,
    required this.paymentMethod,
  });
}