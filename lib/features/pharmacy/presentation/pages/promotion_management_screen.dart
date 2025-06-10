import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';

class PromotionManagementScreen extends StatefulWidget {
  const PromotionManagementScreen({super.key});

  @override
  State<PromotionManagementScreen> createState() => _PromotionManagementScreenState();
}

class _PromotionManagementScreenState extends State<PromotionManagementScreen> {
  final List<Promotion> _promotions = [
    Promotion(
      id: '1',
      title: 'Summer Health Sale',
      description: '20% off on all vitamins and supplements',
      discountType: DiscountType.percentage,
      discountValue: 20,
      startDate: DateTime.now().subtract(const Duration(days: 5)),
      endDate: DateTime.now().add(const Duration(days: 25)),
      isActive: true,
      applicableCategories: ['Vitamins', 'Supplements'],
    ),
    Promotion(
      id: '2',
      title: 'Buy 2 Get 1 Free',
      description: 'Buy any 2 pain relief medicines, get 1 free',
      discountType: DiscountType.buyXGetY,
      discountValue: 1,
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().add(const Duration(days: 20)),
      isActive: true,
      applicableCategories: ['Pain Relief'],
    ),
    Promotion(
      id: '3',
      title: 'First Time Customer',
      description: 'Rs. 1,000 off on first purchase above Rs. 5,000',
      discountType: DiscountType.fixed,
      discountValue: 10,
      startDate: DateTime.now().subtract(const Duration(days: 30)),
      endDate: DateTime.now().add(const Duration(days: 60)),
      isActive: false,
      applicableCategories: ['All'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Promotion Management'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewPromotion,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCard(),
          Expanded(
            child: _promotions.isEmpty ? _buildEmptyState() : _buildPromotionsList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewPromotion,
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatsCard() {
    final activePromotions = _promotions.where((promo) => promo.isActive).length;
    final expiringSoon = _promotions.where((promo) => 
      promo.endDate.difference(DateTime.now()).inDays <= 7).length;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem('Total', _promotions.length.toString(), Icons.local_offer, AppTheme.primaryGreen),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem('Active', activePromotions.toString(), Icons.check_circle, Colors.green),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem('Expiring Soon', expiringSoon.toString(), Icons.warning, Colors.orange),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_offer_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Promotions',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first promotion to boost sales',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _addNewPromotion,
            icon: const Icon(Icons.add),
            label: const Text('Create Promotion'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromotionsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _promotions.length,
      itemBuilder: (context, index) {
        final promotion = _promotions[index];
        return _buildPromotionCard(promotion, index);
      },
    );
  }

  Widget _buildPromotionCard(Promotion promotion, int index) {
    final daysRemaining = promotion.endDate.difference(DateTime.now()).inDays;
    final isExpiringSoon = daysRemaining <= 7;
    final isExpired = daysRemaining < 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
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
              children: [
                Expanded(
                  child: Text(
                    promotion.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: promotion.isActive && !isExpired
                            ? Colors.green[100]
                            : isExpired
                                ? Colors.red[100]
                                : Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isExpired
                            ? 'Expired'
                            : promotion.isActive
                                ? 'Active'
                                : 'Inactive',
                        style: TextStyle(
                          color: promotion.isActive && !isExpired
                              ? Colors.green[800]
                              : isExpired
                                  ? Colors.red[800]
                                  : Colors.grey[800],
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) => _handleMenuAction(value, promotion, index),
                      itemBuilder: (context) => [
                        const PopupMenuItem(value: 'edit', child: Text('Edit')),
                        PopupMenuItem(
                          value: 'toggle',
                          child: Text(promotion.isActive ? 'Deactivate' : 'Activate'),
                        ),
                        const PopupMenuItem(value: 'delete', child: Text('Delete')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              promotion.description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    _getDiscountText(promotion),
                    style: const TextStyle(
                      color: AppTheme.primaryGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (isExpiringSoon && !isExpired)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Expires in $daysRemaining days',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  '${_formatDate(promotion.startDate)} - ${_formatDate(promotion.endDate)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.category, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'Categories: ${promotion.applicableCategories.join(', ')}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
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

  String _getDiscountText(Promotion promotion) {
    switch (promotion.discountType) {
      case DiscountType.percentage:
        return '${promotion.discountValue.toInt()}% OFF';
      case DiscountType.fixed:
        return 'Rs. ${(promotion.discountValue * 100).toInt()} OFF';
      case DiscountType.buyXGetY:
        return 'Buy 2 Get ${promotion.discountValue.toInt()} Free';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _handleMenuAction(String action, Promotion promotion, int index) {
    switch (action) {
      case 'edit':
        _editPromotion(promotion, index);
        break;
      case 'toggle':
        _togglePromotionStatus(promotion, index);
        break;
      case 'delete':
        _deletePromotion(promotion, index);
        break;
    }
  }

  void _addNewPromotion() {
    showDialog(
      context: context,
      builder: (context) => _PromotionFormDialog(
        onSave: (promotion) {
          setState(() {
            _promotions.add(promotion);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Promotion created successfully!'),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
        },
      ),
    );
  }

  void _editPromotion(Promotion promotion, int index) {
    showDialog(
      context: context,
      builder: (context) => _PromotionFormDialog(
        promotion: promotion,
        onSave: (updatedPromotion) {
          setState(() {
            _promotions[index] = updatedPromotion;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Promotion updated successfully!'),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
        },
      ),
    );
  }

  void _togglePromotionStatus(Promotion promotion, int index) {
    setState(() {
      _promotions[index] = promotion.copyWith(isActive: !promotion.isActive);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Promotion ${promotion.isActive ? 'deactivated' : 'activated'} successfully!',
        ),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  void _deletePromotion(Promotion promotion, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Promotion'),
        content: Text('Are you sure you want to delete "${promotion.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _promotions.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Promotion deleted successfully!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

enum DiscountType { percentage, fixed, buyXGetY }

class Promotion {
  final String id;
  final String title;
  final String description;
  final DiscountType discountType;
  final double discountValue;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final List<String> applicableCategories;

  Promotion({
    required this.id,
    required this.title,
    required this.description,
    required this.discountType,
    required this.discountValue,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.applicableCategories,
  });

  Promotion copyWith({
    String? id,
    String? title,
    String? description,
    DiscountType? discountType,
    double? discountValue,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    List<String>? applicableCategories,
  }) {
    return Promotion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      discountType: discountType ?? this.discountType,
      discountValue: discountValue ?? this.discountValue,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      applicableCategories: applicableCategories ?? this.applicableCategories,
    );
  }
}

class _PromotionFormDialog extends StatefulWidget {
  final Promotion? promotion;
  final Function(Promotion) onSave;

  const _PromotionFormDialog({
    this.promotion,
    required this.onSave,
  });

  @override
  State<_PromotionFormDialog> createState() => _PromotionFormDialogState();
}

class _PromotionFormDialogState extends State<_PromotionFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _discountValueController;  DiscountType _selectedDiscountType = DiscountType.percentage;
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  List<String> _selectedCategories = ['All'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.promotion?.title ?? '');
    _descriptionController = TextEditingController(text: widget.promotion?.description ?? '');
    _discountValueController = TextEditingController(
      text: widget.promotion?.discountValue.toString() ?? '',
    );
    _selectedDiscountType = widget.promotion?.discountType ?? _selectedDiscountType;
    _startDate = widget.promotion?.startDate ?? _startDate;
    _endDate = widget.promotion?.endDate ?? _endDate;
    _selectedCategories = widget.promotion?.applicableCategories ?? _selectedCategories;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _discountValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.promotion == null ? 'Create Promotion' : 'Edit Promotion'),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Promotion Title',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<DiscountType>(
                  value: _selectedDiscountType,
                  decoration: const InputDecoration(
                    labelText: 'Discount Type',
                    border: OutlineInputBorder(),
                  ),
                  items: DiscountType.values.map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(_getDiscountTypeName(type)),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedDiscountType = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _discountValueController,
                  decoration: InputDecoration(
                    labelText: _getDiscountValueLabel(),
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Simple date selection (in a real app, use date picker)
                Text(
                  'Duration: ${_formatDate(_startDate)} - ${_formatDate(_endDate)}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                // Categories selection (simplified)
                Text(
                  'Categories: ${_selectedCategories.join(', ')}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _savePromotion,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
          ),
          child: Text(widget.promotion == null ? 'Create' : 'Update'),
        ),
      ],
    );
  }

  String _getDiscountTypeName(DiscountType type) {
    switch (type) {
      case DiscountType.percentage:
        return 'Percentage';
      case DiscountType.fixed:
        return 'Fixed Amount';
      case DiscountType.buyXGetY:
        return 'Buy X Get Y';
    }
  }

  String _getDiscountValueLabel() {
    switch (_selectedDiscountType) {
      case DiscountType.percentage:
        return 'Percentage (%)';
      case DiscountType.fixed:
        return 'Amount (Rs.)';
      case DiscountType.buyXGetY:
        return 'Free Items Count';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _savePromotion() {
    if (_formKey.currentState!.validate()) {
      final promotion = Promotion(
        id: widget.promotion?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        description: _descriptionController.text,
        discountType: _selectedDiscountType,
        discountValue: double.parse(_discountValueController.text),
        startDate: _startDate,
        endDate: _endDate,
        isActive: widget.promotion?.isActive ?? true,
        applicableCategories: _selectedCategories,
      );
      
      widget.onSave(promotion);
      Navigator.pop(context);
    }
  }
}