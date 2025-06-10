class User {
  final String id;
  final String fullName;
  final String email;
  final String? phoneNumber;
  final String userType; // 'patient' or 'pharmacy'
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isActive;
  final String? profileImageUrl;
  final UserProfile? profile;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    this.phoneNumber,
    required this.userType,
    required this.createdAt,
    this.updatedAt,
    this.isActive = true,
    this.profileImageUrl,
    this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String?,
      userType: json['user_type'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String) 
          : null,
      isActive: json['is_active'] as bool? ?? true,
      profileImageUrl: json['profile_image_url'] as String?,
      profile: json['profile'] != null 
          ? UserProfile.fromJson(json['profile'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone_number': phoneNumber,
      'user_type': userType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'is_active': isActive,
      'profile_image_url': profileImageUrl,
      'profile': profile?.toJson(),
    };
  }

  User copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    String? userType,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    String? profileImageUrl,
    UserProfile? profile,
  }) {
    return User(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profile: profile ?? this.profile,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is User &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'User{id: $id, fullName: $fullName, email: $email, userType: $userType}';
  }
}

class UserProfile {
  final String userId;
  final String? address;
  final String? city;
  final String? province;
  final String? postalCode;
  final double? latitude;
  final double? longitude;
  final Map<String, dynamic>? additionalInfo;

  const UserProfile({
    required this.userId,
    this.address,
    this.city,
    this.province,
    this.postalCode,
    this.latitude,
    this.longitude,
    this.additionalInfo,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userId: json['user_id'] as String,
      address: json['address'] as String?,
      city: json['city'] as String?,
      province: json['province'] as String?,
      postalCode: json['postal_code'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      additionalInfo: json['additional_info'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'address': address,
      'city': city,
      'province': province,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'additional_info': additionalInfo,
    };
  }

  UserProfile copyWith({
    String? userId,
    String? address,
    String? city,
    String? province,
    String? postalCode,
    double? latitude,
    double? longitude,
    Map<String, dynamic>? additionalInfo,
  }) {
    return UserProfile(
      userId: userId ?? this.userId,
      address: address ?? this.address,
      city: city ?? this.city,
      province: province ?? this.province,
      postalCode: postalCode ?? this.postalCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
}