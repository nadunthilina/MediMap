import 'package:flutter/material.dart';
import '../widgets/pharmacy_bottom_navigation.dart';

class StockManagementScreen extends StatefulWidget {
  const StockManagementScreen({super.key});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _medicines = [
    {
      'name': 'Paracetamol 500mg',
      'category': 'Pain Relief',
      'stock': 150,
      'minStock': 20,
      'price': 5.50,
      'expiry': '2026-12-31',
    },
    {
      'name': 'Vitamin D3',
      'category': 'Supplements',
      'stock': 8,
      'minStock': 15,
      'price': 12.00,
      'expiry': '2025-08-15',
    },
    {
      'name': 'Cough Syrup',
      'category': 'Respiratory',
      'stock': 45,
      'minStock': 10,
      'price': 8.75,
      'expiry': '2025-06-20',
    },
    {
      'name': 'Antibiotics',
      'category': 'Prescription',
      'stock': 25,
      'minStock': 20,
      'price': 15.00,
      'expiry': '2025-09-10',
    },
  ];
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Stock Management',
          style: TextStyle(
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1A1A1A),
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.add,
                size: screenWidth * 0.055,
                color: const Color(0xFF4CAF50),
              ),
              onPressed: _showAddMedicineDialog,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search medicines...',
                      hintStyle: TextStyle(
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF999999),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: const Color(0xFF666666),
                        size: screenWidth * 0.05,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: screenHeight * 0.018,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                Row(
                  children: [
                    Text(
                      'Filter: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: screenWidth * 0.035,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildFilterChip('All', screenWidth),
                            _buildFilterChip('Low Stock', screenWidth),
                            _buildFilterChip('Expiring Soon', screenWidth),
                            _buildFilterChip('Pain Relief', screenWidth),
                            _buildFilterChip('Supplements', screenWidth),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Stock Summary Cards
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Row(
              children: [
                Expanded(
                  child: _buildSummaryCard(
                    'Total Items',
                    '${_medicines.length}',
                    Icons.inventory_outlined,
                    Colors.blue,
                    screenWidth,
                    screenHeight,
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: _buildSummaryCard(
                    'Low Stock',
                    '${_medicines.where((m) => m['stock'] <= m['minStock']).length}',
                    Icons.warning_outlined,
                    Colors.red,
                    screenWidth,
                    screenHeight,
                  ),
                ),
              ],
            ),
          ),

          // Medicine List
          Expanded(            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              itemCount: _getFilteredMedicines().length,
              itemBuilder: (context, index) {
                final medicine = _getFilteredMedicines()[index];
                return _buildMedicineCard(medicine, screenWidth, screenHeight);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: PharmacyBottomNavigation(
        currentIndex: 1, // Stock tab
        onTap: (index) => PharmacyBottomNavigation.navigateToPage(context, index),
      ),
    );
  }
  Widget _buildFilterChip(String label, double screenWidth) {
    final isSelected = _selectedFilter == label;
    return Container(
      margin: EdgeInsets.only(right: screenWidth * 0.02),
      child: FilterChip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.03,
            fontWeight: FontWeight.w500,
          ),
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? label : 'All';
          });
        },
        selectedColor: const Color(0xFF4CAF50).withOpacity(0.2),
        checkmarkColor: const Color(0xFF4CAF50),
        backgroundColor: Colors.grey[100],
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, IconData icon, Color color, double screenWidth, double screenHeight) {
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
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.025),
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
            SizedBox(width: screenWidth * 0.03),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: screenWidth * 0.045,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.03,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF666666),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine, double screenWidth, double screenHeight) {
    final isLowStock = medicine['stock'] <= medicine['minStock'];
    final isExpiring = _isExpiringSoon(medicine['expiry']);
    
    return Card(
      margin: EdgeInsets.only(bottom: screenHeight * 0.015),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        medicine['name'],
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.025,
                          vertical: screenHeight * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4CAF50).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          medicine['category'],
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: const Color(0xFF4CAF50),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [                    Text(
                      'Rs. ${(medicine['price'] * 100).toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF4CAF50),
                      ),
                    ),
                    if (isLowStock || isExpiring) ...[
                      SizedBox(height: screenHeight * 0.005),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.02,
                          vertical: screenHeight * 0.003,
                        ),
                        decoration: BoxDecoration(
                          color: isLowStock ? Colors.red.withOpacity(0.1) : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          isLowStock ? 'Low Stock' : 'Expiring',
                          style: TextStyle(
                            color: isLowStock ? Colors.red : Colors.orange,
                            fontSize: screenWidth * 0.025,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    'Stock',
                    '${medicine['stock']} units',
                    isLowStock ? Colors.red : Colors.green,
                    screenWidth,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    'Min Stock',
                    '${medicine['minStock']} units',
                    Colors.grey,
                    screenWidth,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    'Expiry',
                    medicine['expiry'],
                    isExpiring ? Colors.orange : Colors.grey,
                    screenWidth,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.015),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showUpdateStockDialog(medicine),
                    icon: Icon(Icons.edit_outlined, size: screenWidth * 0.04),
                    label: Text(
                      'Update',
                      style: TextStyle(fontSize: screenWidth * 0.032),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4CAF50),
                      side: const BorderSide(color: Color(0xFF4CAF50)),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _showAddStockDialog(medicine),
                    icon: Icon(Icons.add, size: screenWidth * 0.04),
                    label: Text(
                      'Add Stock',
                      style: TextStyle(fontSize: screenWidth * 0.032),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4CAF50),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.012),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color color, double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.028,
            color: const Color(0xFF666666),
          ),
        ),
        SizedBox(height: screenWidth * 0.005),
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.032,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _getFilteredMedicines() {
    List<Map<String, dynamic>> filtered = _medicines.where((medicine) {
      final matchesSearch = _searchController.text.isEmpty ||
          medicine['name'].toLowerCase().contains(_searchController.text.toLowerCase());

      final matchesFilter = _selectedFilter == 'All' ||
          (_selectedFilter == 'Low Stock' && medicine['stock'] <= medicine['minStock']) ||
          (_selectedFilter == 'Expiring Soon' && _isExpiringSoon(medicine['expiry'])) ||
          (_selectedFilter == medicine['category']);

      return matchesSearch && matchesFilter;
    }).toList();

    return filtered;
  }

  bool _isExpiringSoon(String expiryDate) {
    final expiry = DateTime.parse(expiryDate);
    final now = DateTime.now();
    final difference = expiry.difference(now).inDays;
    return difference <= 30; // Expiring within 30 days
  }

  void _showAddMedicineDialog() {
    // Implementation for adding new medicine
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Medicine'),
        content: const Text('Add medicine functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showUpdateStockDialog(Map<String, dynamic> medicine) {
    // Implementation for updating medicine details
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Update ${medicine['name']}'),
        content: const Text('Update medicine functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void _showAddStockDialog(Map<String, dynamic> medicine) {
    // Implementation for adding stock
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Stock - ${medicine['name']}'),
        content: const Text('Add stock functionality would be implemented here.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}