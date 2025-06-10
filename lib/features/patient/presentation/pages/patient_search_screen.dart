import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';
import '../widgets/patient_bottom_navigation.dart';

class PatientSearchScreen extends StatefulWidget {
  const PatientSearchScreen({super.key});

  @override
  State<PatientSearchScreen> createState() => _PatientSearchScreenState();
}

class _PatientSearchScreenState extends State<PatientSearchScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;
  final List<String> _recentSearches = [
    'Paracetamol',
    'Vitamin D',
    'Cough Syrup',
    'Band-aid',
  ];
  final List<Map<String, dynamic>> _searchResults = [
    {
      'name': 'Paracetamol 500mg',
      'category': 'Pain Relief',
      'price': 12.99,
      'image': 'medicine_1',
    },
    {
      'name': 'Vitamin D3 Tablets',
      'category': 'Vitamins',
      'price': 24.99,
      'image': 'medicine_2',
    },
    {
      'name': 'Cough Syrup',
      'category': 'Cold & Flu',
      'price': 8.99,
      'image': 'medicine_3',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    setState(() {
      _isSearching = query.isNotEmpty;
    });
  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
              size: screenWidth * 0.06,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Search Medicines',
          style: TextStyle(
            color: Colors.black87,
            fontSize: screenWidth * 0.045,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Input
          Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Container(
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
                  hintText: 'Search medicines, brands, categories...',
                  hintStyle: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: const Color(0xFF999999),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: const Color(0xFF666666),
                    size: screenWidth * 0.055,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            Icons.clear,
                            color: const Color(0xFF666666),
                            size: screenWidth * 0.05,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            _performSearch('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04,
                    vertical: screenHeight * 0.02,
                  ),
                ),
                onChanged: _performSearch,
                autofocus: true,
              ),
            ),
          ),
          // Content
          Expanded(
            child: _isSearching ? _buildSearchResults(screenWidth, screenHeight) : _buildRecentSearches(screenWidth, screenHeight),
          ),
        ],
      ),
      bottomNavigationBar: PatientBottomNavigation(
        currentIndex: 1, // Search tab
        onTap: (index) => PatientBottomNavigation.navigateToPage(context, index),
      ),
    );
  }
  Widget _buildRecentSearches(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Searches',
            style: TextStyle(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),          Expanded(
            child: ListView.builder(
              itemCount: _recentSearches.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: screenHeight * 0.01),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(screenWidth * 0.02),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.history,
                        color: AppTheme.primaryGreen,
                        size: screenWidth * 0.05,
                      ),
                    ),
                    title: Text(
                      _recentSearches[index],
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF333333),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: const Color(0xFF999999),
                        size: screenWidth * 0.045,
                      ),
                      onPressed: () {
                        setState(() {
                          _recentSearches.removeAt(index);
                        });
                      },
                    ),
                    onTap: () {
                      _searchController.text = _recentSearches[index];
                      _performSearch(_recentSearches[index]);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildSearchResults(double screenWidth, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_searchResults.length} results found',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF666666),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final medicine = _searchResults[index];
                return _MedicineSearchItem(
                  name: medicine['name'],
                  category: medicine['category'],
                  price: medicine['price'],
                  screenWidth: screenWidth,
                  screenHeight: screenHeight,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppConstants.medicineDetailRoute,
                      arguments: medicine,
                    );
                  },
                  onAddToCart: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${medicine['name']} added to cart'),
                        backgroundColor: AppTheme.primaryGreen,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _MedicineSearchItem extends StatelessWidget {
  final String name;
  final String category;
  final double price;
  final double screenWidth;
  final double screenHeight;
  final VoidCallback onTap;
  final VoidCallback onAddToCart;

  const _MedicineSearchItem({
    required this.name,
    required this.category,
    required this.price,
    required this.screenWidth,
    required this.screenHeight,
    required this.onTap,
    required this.onAddToCart,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: screenHeight * 0.02),
        padding: EdgeInsets.all(screenWidth * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: screenWidth * 0.15,
              height: screenWidth * 0.15,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFFE8F5E8),
                    const Color(0xFFF0F9F0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.medication,
                color: AppTheme.primaryGreen,
                size: screenWidth * 0.08,
              ),
            ),
            SizedBox(width: screenWidth * 0.04),            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1A1A1A),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    category,
                    style: TextStyle(
                      fontSize: screenWidth * 0.035,
                      color: const Color(0xFF666666),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.008),                  Text(
                    'Rs. ${(price * 100).toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryGreen,
                    AppTheme.primaryGreen.withOpacity(0.8),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryGreen.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: onAddToCart,
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: screenWidth * 0.05,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
