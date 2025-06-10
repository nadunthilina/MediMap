import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';
import '../../../../config/app_constants.dart';
import '../widgets/patient_bottom_navigation.dart';

class MyPrescriptionsScreen extends StatefulWidget {
  const MyPrescriptionsScreen({super.key});

  @override
  State<MyPrescriptionsScreen> createState() => _MyPrescriptionsScreenState();
}

class _MyPrescriptionsScreenState extends State<MyPrescriptionsScreen> {
  String selectedFilter = 'All';
  final List<String> filters = ['All', 'Active', 'Expired', 'Used'];
  
  final List<Map<String, dynamic>> prescriptions = [
    {
      'id': 'RX001',
      'doctorName': 'Dr. Sarah Johnson',
      'hospital': 'City General Hospital',
      'date': '2024-03-15',
      'expiryDate': '2024-06-15',
      'status': 'Active',
      'medicines': [
        {'name': 'Paracetamol 500mg', 'dosage': '1 tablet, 3 times daily', 'duration': '7 days'},
        {'name': 'Vitamin D3', 'dosage': '1 capsule daily', 'duration': '30 days'},
      ],
      'notes': 'Take with food. Complete the full course.',
      'refillsRemaining': 2,
      'totalRefills': 3,
    },
    {
      'id': 'RX002',
      'doctorName': 'Dr. Michael Chen',
      'hospital': 'Metro Health Clinic',
      'date': '2024-03-10',
      'expiryDate': '2024-04-10',
      'status': 'Used',
      'medicines': [
        {'name': 'Amoxicillin 250mg', 'dosage': '1 capsule, 3 times daily', 'duration': '10 days'},
      ],
      'notes': 'Complete antibiotic course even if symptoms improve.',
      'refillsRemaining': 0,
      'totalRefills': 0,
    },
    {
      'id': 'RX003',
      'doctorName': 'Dr. Emily Davis',
      'hospital': 'Wellness Medical Center',
      'date': '2024-02-20',
      'expiryDate': '2024-02-20',
      'status': 'Expired',
      'medicines': [
        {'name': 'Ibuprofen 400mg', 'dosage': '1 tablet when needed', 'duration': 'As required'},
        {'name': 'Muscle relaxant', 'dosage': '1 tablet at bedtime', 'duration': '14 days'},
      ],
      'notes': 'For back pain. Avoid driving after muscle relaxant.',
      'refillsRemaining': 1,
      'totalRefills': 2,
    },
    {
      'id': 'RX004',
      'doctorName': 'Dr. Robert Wilson',
      'hospital': 'Family Health Practice',
      'date': '2024-03-12',
      'expiryDate': '2024-09-12',
      'status': 'Active',
      'medicines': [
        {'name': 'Lisinopril 10mg', 'dosage': '1 tablet daily', 'duration': 'Ongoing'},
        {'name': 'Metformin 500mg', 'dosage': '1 tablet, 2 times daily', 'duration': 'Ongoing'},
      ],
      'notes': 'Regular medications for blood pressure and diabetes management.',
      'refillsRemaining': 5,
      'totalRefills': 6,
    },
  ];

  List<Map<String, dynamic>> get filteredPrescriptions {
    if (selectedFilter == 'All') {
      return prescriptions;
    }
    return prescriptions.where((prescription) => prescription['status'] == selectedFilter).toList();
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
          'My Prescriptions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () => Navigator.pushNamed(context, AppConstants.prescriptionUploadRoute),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterTabs(),
          Expanded(            child: filteredPrescriptions.isEmpty 
                ? _buildEmptyState() 
                : _buildPrescriptionsList(),
          ),
        ],
      ),
      bottomNavigationBar: PatientBottomNavigation(
        currentIndex: 4, // Profile tab (prescriptions are typically accessed from profile)
        onTap: (index) => PatientBottomNavigation.navigateToPage(context, index),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = selectedFilter == filter;
          final count = filter == 'All' 
              ? prescriptions.length 
              : prescriptions.where((p) => p['status'] == filter).length;
          
          return Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 20 : 8,
              right: index == filters.length - 1 ? 20 : 0,
            ),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(filter),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: isSelected ? AppTheme.primaryGreen : Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      count.toString(),
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedFilter = filter;
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

  Widget _buildPrescriptionsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      itemCount: filteredPrescriptions.length,
      itemBuilder: (context, index) {
        return _buildPrescriptionCard(filteredPrescriptions[index]);
      },
    );
  }

  Widget _buildPrescriptionCard(Map<String, dynamic> prescription) {
    final Color statusColor = _getStatusColor(prescription['status']);
    final bool canReorder = prescription['status'] == 'Active' && prescription['refillsRemaining'] > 0;
    
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prescription ${prescription['id']}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        prescription['doctorName'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                      Text(
                        prescription['hospital'],
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    prescription['status'],
                    style: TextStyle(
                      fontSize: 12,
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.medication,
                        size: 18,
                        color: AppTheme.primaryGreen,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Medicines (${prescription['medicines'].length})',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...prescription['medicines'].map<Widget>((medicine) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 4,
                          height: 4,
                          margin: const EdgeInsets.only(top: 8, right: 8),
                          decoration: const BoxDecoration(
                            color: AppTheme.primaryGreen,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                medicine['name'],
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${medicine['dosage']} • ${medicine['duration']}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
                ],
              ),
            ),
            if (prescription['notes'].isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 18,
                      color: Colors.blue[600],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Doctor\'s Notes',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.blue[700],
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            prescription['notes'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Prescribed', _formatDate(prescription['date'])),
                      _buildInfoRow('Expires', _formatDate(prescription['expiryDate'])),
                      if (prescription['totalRefills'] > 0)
                        _buildInfoRow('Refills', '${prescription['refillsRemaining']}/${prescription['totalRefills']} remaining'),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  children: [
                    if (canReorder)
                      ElevatedButton(
                        onPressed: () => _reorderPrescription(prescription),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryGreen,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Reorder',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: () => _viewPrescriptionDetails(prescription),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.primaryGreen,
                        side: const BorderSide(color: AppTheme.primaryGreen),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
                        ),
                      ),
                      child: const Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
              Icons.description_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            selectedFilter == 'All' 
                ? 'No Prescriptions Found'
                : 'No $selectedFilter Prescriptions',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            selectedFilter == 'All'
                ? 'Upload your prescriptions to manage\nyour medications easily'
                : 'No prescriptions in this category',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () => Navigator.pushNamed(context, AppConstants.prescriptionUploadRoute),
            icon: const Icon(Icons.add),
            label: const Text('Upload Prescription'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryGreen,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppConstants.buttonBorderRadius),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return AppTheme.primaryGreen;
      case 'Expired':
        return Colors.red;
      case 'Used':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    final date = DateTime.parse(dateString);
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _reorderPrescription(Map<String, dynamic> prescription) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reorder Prescription'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prescription ${prescription['id']}'),
            const SizedBox(height: 8),
            Text('${prescription['medicines'].length} medicines'),
            const SizedBox(height: 8),
            Text('Refills remaining: ${prescription['refillsRemaining']}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Add medicines to cart and navigate
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Prescription medicines added to cart'),
                  backgroundColor: AppTheme.primaryGreen,
                ),
              );
              Navigator.pushNamed(context, AppConstants.cartRoute);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryGreen),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }

  void _viewPrescriptionDetails(Map<String, dynamic> prescription) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Prescription ${prescription['id']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailSection('Doctor Information', [
                      'Name: ${prescription['doctorName']}',
                      'Hospital: ${prescription['hospital']}',
                      'Date: ${_formatDate(prescription['date'])}',
                    ]),
                    const SizedBox(height: 20),
                    _buildDetailSection('Prescription Details', [
                      'Status: ${prescription['status']}',
                      'Expires: ${_formatDate(prescription['expiryDate'])}',
                      'Refills: ${prescription['refillsRemaining']}/${prescription['totalRefills']}',
                    ]),
                    const SizedBox(height: 20),
                    _buildDetailSection('Medicines', 
                      prescription['medicines'].map<String>((medicine) => 
                        '${medicine['name']} - ${medicine['dosage']} for ${medicine['duration']}'
                      ).toList()
                    ),
                    if (prescription['notes'].isNotEmpty) ...[
                      const SizedBox(height: 20),
                      _buildDetailSection('Doctor\'s Notes', [prescription['notes']]),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            item,
            style: const TextStyle(fontSize: 14),
          ),
        )),
      ],
    );
  }
}
