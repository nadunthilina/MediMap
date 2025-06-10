import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';
import '../widgets/patient_bottom_navigation.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  State<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  
  final List<Map<String, dynamic>> _cartItems = [
    {
      'id': '1',
      'name': 'Paracetamol 500mg',
      'category': 'Pain Relief',
      'price': 12.99,
      'quantity': 2,
      'image': 'medicine_1',
    },
    {
      'id': '2',
      'name': 'Vitamin D3 Tablets',
      'category': 'Vitamins',
      'price': 24.99,
      'quantity': 1,
      'image': 'medicine_2',
    },
    {
      'id': '3',
      'name': 'Cough Syrup',
      'category': 'Cold & Flu',
      'price': 8.99,
      'quantity': 1,
      'image': 'medicine_3',
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  double get _subtotal {
    return _cartItems.fold(0.0, (sum, item) => sum + (item['price'] * item['quantity']));
  }

  double get _deliveryFee => 5.99;
  double get _total => _subtotal + _deliveryFee;

  void _updateQuantity(String itemId, int newQuantity) {
    setState(() {
      if (newQuantity <= 0) {
        _cartItems.removeWhere((item) => item['id'] == itemId);
      } else {
        final itemIndex = _cartItems.indexWhere((item) => item['id'] == itemId);
        if (itemIndex != -1) {
          _cartItems[itemIndex]['quantity'] = newQuantity;
        }
      }
    });
  }
  void _removeItem(String itemId) {
    setState(() {
      _cartItems.removeWhere((item) => item['id'] == itemId);
    });
  }
  void _showClearCartDialog(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(screenWidth * 0.04),
        ),
        title: Row(
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: screenWidth * 0.06,
              ),
            ),
            SizedBox(width: screenWidth * 0.03),
            Text(
              'Clear Cart',
              style: TextStyle(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        content: Text(
          'Are you sure you want to remove all items from your cart? This action cannot be undone.',
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.grey[600],
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: screenWidth * 0.04,
                vertical: screenWidth * 0.02,
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.red, Color(0xFFE53E3E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.02),
              boxShadow: [
                BoxShadow(
                  color: Colors.red.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _cartItems.clear();
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Cart cleared successfully'),
                    backgroundColor: AppTheme.primaryGreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                shadowColor: Colors.transparent,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenWidth * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
              ),
              child: Text(
                'Clear All',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      backgroundColor: Colors.grey[50],      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.grey.withOpacity(0.1),
        leading: Container(
          margin: EdgeInsets.all(screenWidth * 0.02),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.grey[50]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(screenWidth * 0.03),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
              ),
              child: Icon(
                Icons.shopping_cart,
                color: AppTheme.primaryGreen,
                size: screenWidth * 0.05,
              ),
            ),
            SizedBox(width: screenWidth * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shopping Cart',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '${_cartItems.length} items',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: screenWidth * 0.03,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          if (_cartItems.isNotEmpty)
            Container(
              margin: EdgeInsets.all(screenWidth * 0.02),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red[50]!, Colors.red[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(screenWidth * 0.03),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.red,
                  size: screenWidth * 0.06,
                ),
                onPressed: () => _showClearCartDialog(context),
              ),
            ),
        ],
      ),body: FadeTransition(
        opacity: _fadeAnimation,
        child: _cartItems.isEmpty
            ? _buildEmptyCart(screenWidth, screenHeight)
            : _buildCartContent(screenWidth, screenHeight),
      ),
      bottomNavigationBar: PatientBottomNavigation(
        currentIndex: 2, // Cart tab
        onTap: (index) => PatientBottomNavigation.navigateToPage(context, index),
      ),
    );
  }
  Widget _buildEmptyCart(double screenWidth, double screenHeight) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.08),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              size: screenWidth * 0.25,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            'Your cart is empty',
            style: TextStyle(
              fontSize: screenWidth * 0.05,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF666666),
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Add medicines to get started',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              color: const Color(0xFF999999),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppConstants.patientHomeRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryGreen,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.08,
                  vertical: screenHeight * 0.02,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: Text(
                'Continue Shopping',
                style: TextStyle(
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildCartContent(double screenWidth, double screenHeight) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(screenWidth * 0.05),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              final item = _cartItems[index];
              return _CartItem(
                name: item['name'],
                category: item['category'],
                price: item['price'],
                quantity: item['quantity'],
                screenWidth: screenWidth,
                screenHeight: screenHeight,
                onQuantityChanged: (newQuantity) {
                  _updateQuantity(item['id'], newQuantity);
                },
                onRemove: () {
                  _removeItem(item['id']);
                },
              );
            },
          ),
        ),
        // Cart Summary
        Container(
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(screenWidth * 0.06),
              topRight: Radius.circular(screenWidth * 0.06),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [              _SummaryRow(
                label: 'Subtotal', 
                value: 'Rs. ${(_subtotal * 100).toStringAsFixed(0)}',
                screenWidth: screenWidth,
              ),              _SummaryRow(
                label: 'Delivery Fee', 
                value: 'Rs. ${(_deliveryFee * 100).toStringAsFixed(0)}',
                screenWidth: screenWidth,
              ),
              Divider(
                height: screenHeight * 0.03,
                thickness: 1,
                color: Colors.grey[200],
              ),              _SummaryRow(
                label: 'Total',
                value: 'Rs. ${(_total * 100).toStringAsFixed(0)}',
                isTotal: true,
                screenWidth: screenWidth,
              ),
              SizedBox(height: screenHeight * 0.025),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  gradient: const LinearGradient(
                    colors: [AppTheme.primaryGreen, Color(0xFF45B65C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppConstants.paymentOptionsRoute);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.04),
                    ),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  child: Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CartItem extends StatelessWidget {
  final String name;
  final String category;
  final double price;
  final int quantity;
  final double screenWidth;
  final double screenHeight;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const _CartItem({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.screenWidth,
    required this.screenHeight,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: screenHeight * 0.02),
      padding: EdgeInsets.all(screenWidth * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.04),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: screenWidth * 0.15,
            height: screenWidth * 0.15,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFE8F5E8), Color(0xFFD4F0D4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryGreen.withOpacity(0.1),
                  blurRadius: 4,
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
          SizedBox(width: screenWidth * 0.04),
          Expanded(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: screenWidth * 0.035,
                    color: const Color(0xFF666666),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),                Text(
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
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
                child: IconButton(
                  onPressed: onRemove,
                  icon: Icon(
                    Icons.delete_outline,
                    color: Colors.red,
                    size: screenWidth * 0.05,
                  ),
                  constraints: BoxConstraints(
                    minWidth: screenWidth * 0.08,
                    minHeight: screenWidth * 0.08,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEEEEEE)),
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  color: Colors.grey[50],
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantity > 1) {
                          onQuantityChanged(quantity - 1);
                        }
                      },
                      icon: Icon(
                        Icons.remove, 
                        size: screenWidth * 0.04,
                        color: quantity > 1 ? AppTheme.primaryGreen : Colors.grey,
                      ),
                      constraints: BoxConstraints(
                        minWidth: screenWidth * 0.08,
                        minHeight: screenWidth * 0.08,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
                      child: Text(
                        quantity.toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        onQuantityChanged(quantity + 1);
                      },
                      icon: Icon(
                        Icons.add, 
                        size: screenWidth * 0.04,
                        color: AppTheme.primaryGreen,
                      ),
                      constraints: BoxConstraints(
                        minWidth: screenWidth * 0.08,
                        minHeight: screenWidth * 0.08,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  final double screenWidth;

  const _SummaryRow({
    required this.label,
    required this.value,
    required this.screenWidth,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.01),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? screenWidth * 0.045 : screenWidth * 0.04,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w500,
              color: isTotal ? const Color(0xFF1A1A1A) : const Color(0xFF666666),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? screenWidth * 0.045 : screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: isTotal ? AppTheme.primaryGreen : const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}
