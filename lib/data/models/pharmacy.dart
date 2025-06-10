class Pharmacy {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String city;
  final String province;
  final String postalCode;
  final double latitude;
  final double longitude;
  final String licenseNumber;
  final bool isVerified;
  final bool isOpen;
  final String? description;
  final String? website;
  final List<String> services;
  final PharmacyHours operatingHours;
  final double rating;
  final int totalReviews;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? profileImageUrl;
  final List<String> imageUrls;

  const Pharmacy({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.province,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.licenseNumber,
    required this.isVerified,
    required this.isOpen,
    this.description,
    this.website,
    required this.services,
    required this.operatingHours,
    required this.rating,
    required this.totalReviews,
    required this.createdAt,
    this.updatedAt,
    this.profileImageUrl,
    required this.imageUrls,
  });

  factory Pharmacy.fromJson(Map<String, dynamic> json) {
    return Pharmacy(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      province: json['province'] as String,
      postalCode: json['postal_code'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      licenseNumber: json['license_number'] as String,
      isVerified: json['is_verified'] as bool,
      isOpen: json['is_open'] as bool,
      description: json['description'] as String?,
      website: json['website'] as String?,
      services: List<String>.from(json['services'] as List),
      operatingHours: PharmacyHours.fromJson(
        json['operating_hours'] as Map<String, dynamic>
      ),
      rating: (json['rating'] as num).toDouble(),
      totalReviews: json['total_reviews'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
      profileImageUrl: json['profile_image_url'] as String?,
      imageUrls: List<String>.from(json['image_urls'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'address': address,
      'city': city,
      'province': province,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'license_number': licenseNumber,
      'is_verified': isVerified,
      'is_open': isOpen,
      'description': description,
      'website': website,
      'services': services,
      'operating_hours': operatingHours.toJson(),
      'rating': rating,
      'total_reviews': totalReviews,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'profile_image_url': profileImageUrl,
      'image_urls': imageUrls,
    };
  }

  Pharmacy copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? city,
    String? province,
    String? postalCode,
    double? latitude,
    double? longitude,
    String? licenseNumber,
    bool? isVerified,
    bool? isOpen,
    String? description,
    String? website,
    List<String>? services,
    PharmacyHours? operatingHours,
    double? rating,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? profileImageUrl,
    List<String>? imageUrls,
  }) {
    return Pharmacy(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      city: city ?? this.city,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      isVerified: isVerified ?? this.isVerified,
      isOpen: isOpen ?? this.isOpen,
      description: description ?? this.description,
      website: website ?? this.website,
      services: services ?? this.services,
      operatingHours: operatingHours ?? this.operatingHours,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      imageUrls: imageUrls ?? this.imageUrls,
    );
  }

  String get fullAddress => '$address, $city, $province $postalCode';

  String get statusText => isOpen ? 'Open' : 'Closed';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Pharmacy &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Pharmacy{id: $id, name: $name, city: $city, isOpen: $isOpen}';
  }
}

class PharmacyHours {
  final DayHours monday;
  final DayHours tuesday;
  final DayHours wednesday;
  final DayHours thursday;
  final DayHours friday;
  final DayHours saturday;
  final DayHours sunday;

  const PharmacyHours({
    required this.monday,
    required this.tuesday,
    required this.wednesday,
    required this.thursday,
    required this.friday,
    required this.saturday,
    required this.sunday,
  });

  factory PharmacyHours.fromJson(Map<String, dynamic> json) {
    return PharmacyHours(
      monday: DayHours.fromJson(json['monday'] as Map<String, dynamic>),
      tuesday: DayHours.fromJson(json['tuesday'] as Map<String, dynamic>),
      wednesday: DayHours.fromJson(json['wednesday'] as Map<String, dynamic>),
      thursday: DayHours.fromJson(json['thursday'] as Map<String, dynamic>),
      friday: DayHours.fromJson(json['friday'] as Map<String, dynamic>),
      saturday: DayHours.fromJson(json['saturday'] as Map<String, dynamic>),
      sunday: DayHours.fromJson(json['sunday'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'monday': monday.toJson(),
      'tuesday': tuesday.toJson(),
      'wednesday': wednesday.toJson(),
      'thursday': thursday.toJson(),
      'friday': friday.toJson(),
      'saturday': saturday.toJson(),
      'sunday': sunday.toJson(),
    };
  }

  DayHours getDayHours(int weekday) {
    switch (weekday) {
      case DateTime.monday:
        return monday;
      case DateTime.tuesday:
        return tuesday;
      case DateTime.wednesday:
        return wednesday;
      case DateTime.thursday:
        return thursday;
      case DateTime.friday:
        return friday;
      case DateTime.saturday:
        return saturday;
      case DateTime.sunday:
        return sunday;
      default:
        return monday;
    }
  }
}

class DayHours {
  final bool isOpen;
  final String? openTime;
  final String? closeTime;

  const DayHours({
    required this.isOpen,
    this.openTime,
    this.closeTime,
  });

  factory DayHours.fromJson(Map<String, dynamic> json) {
    return DayHours(
      isOpen: json['is_open'] as bool,
      openTime: json['open_time'] as String?,
      closeTime: json['close_time'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'is_open': isOpen,
      'open_time': openTime,
      'close_time': closeTime,
    };
  }

  String get displayHours {
    if (!isOpen) return 'Closed';
    if (openTime == null || closeTime == null) return 'Open 24 hours';
    return '$openTime - $closeTime';
  }
}

class Medicine {
  final String id;
  final String name;
  final String? brand;
  final String? genericName;
  final String category;
  final String? description;
  final double price;
  final int stockQuantity;
  final String? unit;
  final bool requiresPrescription;
  final String? imageUrl;
  final List<String> activeIngredients;
  final String? manufacturer;
  final DateTime? expiryDate;
  final String pharmacyId;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Medicine({
    required this.id,
    required this.name,
    this.brand,
    this.genericName,
    required this.category,
    this.description,
    required this.price,
    required this.stockQuantity,
    this.unit,
    required this.requiresPrescription,
    this.imageUrl,
    required this.activeIngredients,
    this.manufacturer,
    this.expiryDate,
    required this.pharmacyId,
    required this.createdAt,
    this.updatedAt,
  });

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      genericName: json['generic_name'] as String?,
      category: json['category'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      stockQuantity: json['stock_quantity'] as int,
      unit: json['unit'] as String?,
      requiresPrescription: json['requires_prescription'] as bool,
      imageUrl: json['image_url'] as String?,
      activeIngredients: List<String>.from(json['active_ingredients'] as List),
      manufacturer: json['manufacturer'] as String?,
      expiryDate: json['expiry_date'] != null 
          ? DateTime.parse(json['expiry_date'] as String)
          : null,
      pharmacyId: json['pharmacy_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'generic_name': genericName,
      'category': category,
      'description': description,
      'price': price,
      'stock_quantity': stockQuantity,
      'unit': unit,
      'requires_prescription': requiresPrescription,
      'image_url': imageUrl,
      'active_ingredients': activeIngredients,
      'manufacturer': manufacturer,
      'expiry_date': expiryDate?.toIso8601String(),
      'pharmacy_id': pharmacyId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  bool get isInStock => stockQuantity > 0;

  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());

  String get displayName => brand != null ? '$name ($brand)' : name;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Medicine &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Medicine{id: $id, name: $name, price: $price, stockQuantity: $stockQuantity}';
  }
}