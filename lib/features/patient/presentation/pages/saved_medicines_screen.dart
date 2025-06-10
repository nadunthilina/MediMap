import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';

class SavedMedicinesScreen extends StatefulWidget {
  const SavedMedicinesScreen({super.key});

  @override
  State<SavedMedicinesScreen> createState() => _SavedMedicinesScreenState();
}

class _SavedMedicinesScreenState extends State<SavedMedicinesScreen> {
  String selectedCategory = 'All';
  final List<String> categories = ['All', 'Prescription', 'OTC', 'Vitamins', 'Pain Relief'];
  
  final List<Map<String, dynamic>> savedMedicines = [
    {
      'id': '1',
      'name': 'Paracetamol 500mg',
      'brand': 'Generic',
      'category': 'Pain Relief',
      'price': 8.99,
      'originalPrice': 12.99,
      'inStock': true,
      'isPrescription': true,
      'savedDate': '2024-03-10',
      'pharmacy': 'HealthPlus Pharmacy',
      'rating': 4.5,
      'reviews': 120,
    },
    {
      'id': '2',
      'name': 'Vitamin D3 1000 IU',
      'brand': 'Nature Made',
      'category': 'Vitamins',
      'price': 12.50,
      'originalPrice': 15.99,
      'inStock': true,
      'isPrescription': false,
      'savedDate': '2024-03-08',
      'pharmacy': 'MediCare Plus',
      'rating': 4.8,
      'reviews': 85,
    },
    {
      'id': '3',
      'name': 'Ibuprofen 400mg',
      'brand': 'Advil',
      'category': 'Pain Relief',
      'price': 14.99,
      'originalPrice': 18.99,
      'inStock': false,
      'isPrescription': false,
      'savedDate': '2024-03-05',
      'pharmacy': 'Quick Pharmacy',
      'rating': 4.3,
      'reviews': 200,
    },
    {
      'id': '4',
      'name': 'Omega-3 Fish Oil',
      'brand': 'Nordic Naturals',
      'category': 'Vitamins',
      'price': 24.99,
      'originalPrice': 29.99,
      'inStock': true,
      'isPrescription': false,
      'savedDate': '2024-03-03',
      'pharmacy': 'HealthPlus Pharmacy',
      'rating': 4.7,
      'reviews': 150,
    },
    {
      'id': '5',
      'name': 'Lisinopril 10mg',
      'brand': 'Generic',
      'category': 'Prescription',
      'price': 18.50,
      'originalPrice': 22.99,
      'inStock': true,
      'isPrescription': true,
      'savedDate': '2024-02-28',
      'pharmacy': 'MediCare Plus',
      'rating': 4.2,
      'reviews': 75,
    },
  ];

  List<Map<String, dynamic>> get filteredMedicines {
    if (selectedCategory == 'All') {
      return savedMedicines;
    }
    return savedMedicines.where((medicine) => medicine['category'] == selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Saved Medicines',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () => _showSearchDialog(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryFilter(),
          Expanded(
            child: filteredMedicines.isEmpty 
                ? _buildEmptyState() 
                : _buildMedicinesList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;
          
          return Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 20 : 8,
              right: index == categories.length - 1 ? 20 : 0,
            ),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                });
              },
              backgroundColor: Colors.grey[100],
              selectedColor: AppTheme.primaryGreen.withOpacity(0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppTheme.primaryGreen : Colors.grey[700],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              side: BorderSide(
                color: isSelected ? AppTheme.primaryGreen : Colors.grey[300]!,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMedicinesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: filteredMedicines.length,
      itemBuilder: (context, index) {
        return _buildMedicineCard(filteredMedicines[index]);
      },
    );
  }

  Widget _buildMedicineCard(Map<String, dynamic> medicine) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.medication,
                    color: AppTheme.primaryGreen,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              medicine['name'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () => _removeMedicine(medicine),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            medicine['brand'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          if (medicine['isPrescription'])
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Rx',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.orange,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${medicine['rating']}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            ' (${medicine['reviews']})',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.local_pharmacy,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              medicine['pharmacy'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Rs. ${(medicine['price'] * 100).toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Rs. ${(medicine['originalPrice'] * 100).toStringAsFixed(0)}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: medicine['inStock'] ? AppTheme.primaryGreen : Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            medicine['inStock'] ? 'In Stock' : 'Out of Stock',
                            style: TextStyle(
                              fontSize: 12,
                              color: medicine['inStock'] ? AppTheme.primaryGreen : Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: medicine['inStock'] 
                      ? () => _addToCart(medicine)
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: medicine['inStock'] 
                        ? AppTheme.primaryGreen 
                        : Colors.grey[300],
                    foregroundColor: medicine['inStock'] 
                        ? Colors.white 
                        : Colors.grey[600],
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    medicine['inStock'] ? 'Add to Cart' : 'Notify Me',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Saved on ${_formatDate(medicine['savedDate'])}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.favorite_border,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            selectedCategory == 'All' 
                ? 'No Saved Medicines'
                : 'No $selectedCategory Medicines',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            selectedCategory == 'All'
                ? 'Start saving medicines to your favorites\nfor quick access later'
                : 'No saved medicines in this category',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, AppConstants.patientSearchRoute),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
              ),
            ),
            child: const Text(
              'Search Medicines',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Saved Medicines'),
        content: TextField(
          decoration: const InputDecoration(
            hintText: 'Enter medicine name...',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            Navigator.pop(context);
            // Implement search functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Searching for "$value"...'),
                backgroundColor: AppTheme.primaryGreen,
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _removeMedicine(Map<String, dynamic> medicine) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Saved'),
        content: Text('Remove ${medicine['name']} from your saved medicines?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                savedMedicines.remove(medicine);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Medicine removed from saved list'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _addToCart(Map<String, dynamic> medicine) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${medicine['name']} added to cart'),
        backgroundColor: AppTheme.primaryGreen,
        action: SnackBarAction(
          label: 'View Cart',
          textColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, AppConstants.cartRoute);
          },
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
