import 'package:flutter/material.dart';
import '../../../../config/app_theme.dart';

class StaffManagementScreen extends StatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  State<StaffManagementScreen> createState() => _StaffManagementScreenState();
}

class _StaffManagementScreenState extends State<StaffManagementScreen> {
  final List<StaffMember> _staffMembers = [
    StaffMember(
      id: '1',
      name: 'Dr. Sarah Johnson',
      role: 'Pharmacist',
      email: 'sarah.johnson@medimap.com',
      phone: '+1 (555) 123-4567',
      isActive: true,
      joinDate: DateTime(2023, 1, 15),
    ),
    StaffMember(
      id: '2',
      name: 'Mike Chen',
      role: 'Pharmacy Assistant',
      email: 'mike.chen@medimap.com',
      phone: '+1 (555) 234-5678',
      isActive: true,
      joinDate: DateTime(2023, 3, 20),
    ),
    StaffMember(
      id: '3',
      name: 'Emily Davis',
      role: 'Pharmacy Technician',
      email: 'emily.davis@medimap.com',
      phone: '+1 (555) 345-6789',
      isActive: false,
      joinDate: DateTime(2022, 11, 10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Staff Management'),
        backgroundColor: AppTheme.primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewStaff,
          ),
        ],
      ),
      body: Column(
        children: [
          _buildStatsCard(),
          Expanded(
            child: _staffMembers.isEmpty ? _buildEmptyState() : _buildStaffList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewStaff,
        backgroundColor: AppTheme.primaryGreen,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildStatsCard() {
    final activeStaff = _staffMembers.where((staff) => staff.isActive).length;
    final inactiveStaff = _staffMembers.length - activeStaff;

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
            child: _buildStatItem('Total Staff', _staffMembers.length.toString(), Icons.people, AppTheme.primaryGreen),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem('Active', activeStaff.toString(), Icons.check_circle, Colors.green),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildStatItem('Inactive', inactiveStaff.toString(), Icons.pause_circle, Colors.orange),
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
            Icons.people_outline,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No Staff Members',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first staff member to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: _addNewStaff,
            icon: const Icon(Icons.add),
            label: const Text('Add Staff Member'),
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

  Widget _buildStaffList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: _staffMembers.length,
      itemBuilder: (context, index) {
        final staff = _staffMembers[index];
        return _buildStaffCard(staff, index);
      },
    );
  }

  Widget _buildStaffCard(StaffMember staff, int index) {
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
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppTheme.primaryGreen.withValues(alpha: 0.2),
                  child: Text(
                    staff.name.split(' ').map((e) => e[0]).take(2).join(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryGreen,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              staff.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: staff.isActive ? Colors.green[100] : Colors.red[100],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              staff.isActive ? 'Active' : 'Inactive',
                              style: TextStyle(
                                color: staff.isActive ? Colors.green[800] : Colors.red[800],
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        staff.role,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.email,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    staff.email,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.phone,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 8),
                Text(
                  staff.phone,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.date_range,
                  size: 16,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 8),
                Text(
                  'Joined: ${_formatDate(staff.joinDate)}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () => _editStaff(staff, index),
                  icon: const Icon(Icons.edit, size: 16),
                  label: const Text('Edit'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.primaryGreen,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _toggleStaffStatus(staff, index),
                  icon: Icon(
                    staff.isActive ? Icons.pause : Icons.play_arrow,
                    size: 16,
                  ),
                  label: Text(staff.isActive ? 'Deactivate' : 'Activate'),
                  style: TextButton.styleFrom(
                    foregroundColor: staff.isActive ? Colors.orange : Colors.green,
                  ),
                ),
                const SizedBox(width: 8),
                TextButton.icon(
                  onPressed: () => _deleteStaff(staff, index),
                  icon: const Icon(Icons.delete, size: 16),
                  label: const Text('Remove'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _addNewStaff() {
    showDialog(
      context: context,
      builder: (context) => _StaffFormDialog(
        onSave: (staff) {
          setState(() {
            _staffMembers.add(staff);
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Staff member added successfully!'),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
        },
      ),
    );
  }

  void _editStaff(StaffMember staff, int index) {
    showDialog(
      context: context,
      builder: (context) => _StaffFormDialog(
        staffMember: staff,
        onSave: (updatedStaff) {
          setState(() {
            _staffMembers[index] = updatedStaff;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Staff member updated successfully!'),
              backgroundColor: AppTheme.primaryGreen,
            ),
          );
        },
      ),
    );
  }

  void _toggleStaffStatus(StaffMember staff, int index) {
    setState(() {
      _staffMembers[index] = staff.copyWith(isActive: !staff.isActive);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Staff member ${staff.isActive ? 'deactivated' : 'activated'} successfully!',
        ),
        backgroundColor: AppTheme.primaryGreen,
      ),
    );
  }

  void _deleteStaff(StaffMember staff, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove Staff Member'),
        content: Text('Are you sure you want to remove ${staff.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _staffMembers.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Staff member removed successfully!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }
}

class StaffMember {
  final String id;
  final String name;
  final String role;
  final String email;
  final String phone;
  final bool isActive;
  final DateTime joinDate;

  StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.email,
    required this.phone,
    required this.isActive,
    required this.joinDate,
  });

  StaffMember copyWith({
    String? id,
    String? name,
    String? role,
    String? email,
    String? phone,
    bool? isActive,
    DateTime? joinDate,
  }) {
    return StaffMember(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      isActive: isActive ?? this.isActive,
      joinDate: joinDate ?? this.joinDate,
    );
  }
}

class _StaffFormDialog extends StatefulWidget {
  final StaffMember? staffMember;
  final Function(StaffMember) onSave;

  const _StaffFormDialog({
    this.staffMember,
    required this.onSave,
  });

  @override
  State<_StaffFormDialog> createState() => _StaffFormDialogState();
}

class _StaffFormDialogState extends State<_StaffFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  String _selectedRole = 'Pharmacist';
  final List<String> _roles = ['Pharmacist', 'Pharmacy Assistant', 'Pharmacy Technician', 'Manager'];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.staffMember?.name ?? '');
    _emailController = TextEditingController(text: widget.staffMember?.email ?? '');
    _phoneController = TextEditingController(text: widget.staffMember?.phone ?? '');
    _selectedRole = widget.staffMember?.role ?? _selectedRole;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.staffMember == null ? 'Add Staff Member' : 'Edit Staff Member'),
      content: SizedBox(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
                items: _roles.map((role) {
                  return DropdownMenuItem(
                    value: role,
                    child: Text(role),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _saveStaff,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            foregroundColor: Colors.white,
          ),
          child: Text(widget.staffMember == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }

  void _saveStaff() {
    if (_formKey.currentState!.validate()) {
      final staff = StaffMember(
        id: widget.staffMember?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        role: _selectedRole,
        email: _emailController.text,
        phone: _phoneController.text,
        isActive: widget.staffMember?.isActive ?? true,
        joinDate: widget.staffMember?.joinDate ?? DateTime.now(),
      );
      
      widget.onSave(staff);
      Navigator.pop(context);
    }
  }
}