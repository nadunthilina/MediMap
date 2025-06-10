import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';
import '../widgets/patient_bottom_navigation.dart';
import '../../../../data/models/order.dart';

class PatientOrderHistoryScreen extends StatefulWidget {
  const PatientOrderHistoryScreen({super.key});

  @override
  State<PatientOrderHistoryScreen> createState() => _PatientOrderHistoryScreenState();
}

class _PatientOrderHistoryScreenState extends State<PatientOrderHistoryScreen> {  final List<Order> _orders = [
    // Sample data
    Order(
      id: '1',
      patientId: 'patient_1',
      pharmacyId: 'pharm_1',
      status: OrderStatus.delivered,
      totalAmount: 145.50,
      finalAmount: 145.50,
      paymentStatus: PaymentStatus.paid,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      deliveryDate: DateTime.now().subtract(const Duration(days: 1)),
      items: [],
    ),
    Order(
      id: '2',
      patientId: 'patient_1',
      pharmacyId: 'pharm_2',
      status: OrderStatus.confirmed,
      totalAmount: 89.25,
      finalAmount: 89.25,
      paymentStatus: PaymentStatus.pending,
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      items: [],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],      appBar: AppBar(
        title: const Text('Order History'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,      ),
      body: _orders.isEmpty ? _buildEmptyState() : _buildOrderList(),
      bottomNavigationBar: PatientBottomNavigation(
        currentIndex: 3, // Orders tab
        onTap: (index) => PatientBottomNavigation.navigateToPage(context, index),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.history,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Orders Yet',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order history will appear here',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, AppConstants.patientDashboardRoute);
            },            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Browse Pharmacies'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _orders.length,
      itemBuilder: (context, index) {
        final order = _orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildStatusChip(order.status),
              ],
            ),            const SizedBox(height: 8),
            Text(
              'Pharmacy: ${order.pharmacyId}', // We'll use pharmacyId until we have pharmacy data
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  _formatDate(order.createdAt),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [                Text(
                  'Rs. ${(order.totalAmount * 100).toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryGreen,
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => _viewOrderDetails(order),
                      child: const Text('View Details'),
                    ),
                    if (order.status == OrderStatus.delivered)
                      TextButton(
                        onPressed: () => _reorderItems(order),
                        child: const Text('Reorder'),
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(OrderStatus status) {
    Color backgroundColor;
    Color textColor;
    String text;    switch (status) {
      case OrderStatus.pending:
        backgroundColor = Colors.orange[100]!;
        textColor = Colors.orange[800]!;
        text = 'Pending';
        break;
      case OrderStatus.confirmed:
        backgroundColor = Colors.blue[100]!;
        textColor = Colors.blue[800]!;
        text = 'Confirmed';
        break;
      case OrderStatus.preparing:
        backgroundColor = Colors.purple[100]!;
        textColor = Colors.purple[800]!;
        text = 'Preparing';
        break;
      case OrderStatus.ready:
        backgroundColor = Colors.purple[100]!;
        textColor = Colors.purple[800]!;
        text = 'Ready';
        break;
      case OrderStatus.delivered:
        backgroundColor = Colors.green[100]!;
        textColor = Colors.green[800]!;
        text = 'Delivered';
        break;
      case OrderStatus.cancelled:
        backgroundColor = Colors.red[100]!;
        textColor = Colors.red[800]!;
        text = 'Cancelled';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _viewOrderDetails(Order order) {
    // Navigate to order details screen
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order #${order.id}'),        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pharmacy ID: ${order.pharmacyId}'),
            Text('Status: ${order.status.toString().split('.').last}'),
            Text('Total: Rs. ${(order.totalAmount * 100).toStringAsFixed(0)}'),
            Text('Date: ${_formatDate(order.createdAt)}'),
            if (order.deliveryDate != null)
              Text('Delivered: ${_formatDate(order.deliveryDate!)}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
  void _reorderItems(Order order) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reordering items from pharmacy ${order.pharmacyId}...'),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }
}