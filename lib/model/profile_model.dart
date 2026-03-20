class ProfileModel {
  final int? partnerId;
  final String? name;
  final String? email;
  final String? mobile;
  final String? profileImage;
  final String? membershipStatus;
  final int? vehiclesCount;
  final int? bookingsCount;
  final int? servicesCount;

  ProfileModel({
    this.partnerId,
    this.name,
    this.email,
    this.mobile,
    this.profileImage,
    this.membershipStatus,
    this.vehiclesCount,
    this.bookingsCount,
    this.servicesCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? json; 
    
    return ProfileModel(
      partnerId: data['partner_id'],
      name: data['name'],
      email: data['email'],
      mobile: data['mobile'] ?? data['phone_number'],
      profileImage: data['profile_picture'] ?? data['profile_image'],
      membershipStatus: data['membership_status'],
      vehiclesCount: (data['vehicles'] as List?)?.length ?? 0,
      bookingsCount: (data['bookings'] as List?)?.length ?? 0,
      servicesCount: 0, 
    );
  }
}