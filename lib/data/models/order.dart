class Order {
  final String id;
  final String patientId;
  final String pharmacyId;
  final List<OrderItem> items;
  final double totalAmount;
  final double? deliveryCharge;
  final double? discount;
  final double finalAmount;
  final OrderStatus status;
  final PaymentStatus paymentStatus;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final DateTime? deliveryDate;
  final String? deliveryAddress;
  final String? notes;
  final String? prescriptionImageUrl;

  const Order({
    required this.id,
    required this.patientId,
    required this.pharmacyId,
    required this.items,
    required this.totalAmount,
    this.deliveryCharge,
    this.discount,
    required this.finalAmount,
    required this.status,
    required this.paymentStatus,
    this.paymentMethod,
    required this.createdAt,
    this.updatedAt,
    this.deliveryDate,
    this.deliveryAddress,
    this.notes,
    this.prescriptionImageUrl,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      patientId: json['patient_id'] as String,
      pharmacyId: json['pharmacy_id'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['total_amount'] as num).toDouble(),
      deliveryCharge: json['delivery_charge'] != null 
          ? (json['delivery_charge'] as num).toDouble() 
          : null,
      discount: json['discount'] != null 
          ? (json['discount'] as num).toDouble() 
          : null,
      finalAmount: (json['final_amount'] as num).toDouble(),
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      paymentStatus: PaymentStatus.values.firstWhere(
        (e) => e.name == json['payment_status'],
        orElse: () => PaymentStatus.pending,
      ),
      paymentMethod: json['payment_method'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
      deliveryDate: json['delivery_date'] != null 
          ? DateTime.parse(json['delivery_date'] as String) 
          : null,
      deliveryAddress: json['delivery_address'] as String?,
      notes: json['notes'] as String?,
      prescriptionImageUrl: json['prescription_image_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patient_id': patientId,
      'pharmacy_id': pharmacyId,
      'items': items.map((item) => item.toJson()).toList(),
      'total_amount': totalAmount,
      'delivery_charge': deliveryCharge,
      'discount': discount,
      'final_amount': finalAmount,
      'status': status.name,
      'payment_status': paymentStatus.name,
      'payment_method': paymentMethod,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'delivery_date': deliveryDate?.toIso8601String(),
      'delivery_address': deliveryAddress,
      'notes': notes,
      'prescription_image_url': prescriptionImageUrl,
    };
  }

  Order copyWith({
    String? id,
    String? patientId,
    String? pharmacyId,
    List<OrderItem>? items,
    double? totalAmount,
    double? deliveryCharge,
    double? discount,
    double? finalAmount,
    OrderStatus? status,
    PaymentStatus? paymentStatus,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deliveryDate,
    String? deliveryAddress,
    String? notes,
    String? prescriptionImageUrl,
  }) {
    return Order(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      pharmacyId: pharmacyId ?? this.pharmacyId,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      deliveryCharge: deliveryCharge ?? this.deliveryCharge,
      discount: discount ?? this.discount,
      finalAmount: finalAmount ?? this.finalAmount,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      notes: notes ?? this.notes,
      prescriptionImageUrl: prescriptionImageUrl ?? this.prescriptionImageUrl,
    );
  }

  String get statusDisplayName {
    switch (status) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get paymentStatusDisplayName {
    switch (paymentStatus) {
      case PaymentStatus.pending:
        return 'Payment Pending';
      case PaymentStatus.paid:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Payment Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Order &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Order{id: $id, patientId: $patientId, pharmacyId: $pharmacyId, status: $status}';
  }
}

class OrderItem {
  final String id;
  final String orderId;
  final String medicineId;
  final String medicineName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String? notes;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.medicineId,
    required this.medicineName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.notes,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'] as String,
      orderId: json['order_id'] as String,
      medicineId: json['medicine_id'] as String,
      medicineName: json['medicine_name'] as String,
      quantity: json['quantity'] as int,
      unitPrice: (json['unit_price'] as num).toDouble(),
      totalPrice: (json['total_price'] as num).toDouble(),
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_id': orderId,
      'medicine_id': medicineId,
      'medicine_name': medicineName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'notes': notes,
    };
  }

  OrderItem copyWith({
    String? id,
    String? orderId,
    String? medicineId,
    String? medicineName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? notes,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      medicineId: medicineId ?? this.medicineId,
      medicineName: medicineName ?? this.medicineName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'OrderItem{id: $id, medicineName: $medicineName, quantity: $quantity}';
  }
}

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  delivered,
  cancelled,
}

enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

// Extensions for better display
extension OrderStatusExtension on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.preparing:
        return 'Preparing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  String get description {
    switch (this) {
      case OrderStatus.pending:
        return 'Order is being processed';
      case OrderStatus.confirmed:
        return 'Order has been confirmed by the pharmacy';
      case OrderStatus.preparing:
        return 'Order is being prepared';
      case OrderStatus.ready:
        return 'Order is ready for pickup';
      case OrderStatus.delivered:
        return 'Order has been delivered';
      case OrderStatus.cancelled:
        return 'Order has been cancelled';
    }
  }
}