class ProfileModel {
  final int? partnerId;
  final String? name;
  final String? email;
  final String? mobile;
  final String? membershipStatus;
  final String? membershipType;
  final int? vehiclesCount;
  final int? bookingsCount;
  final int? servicesCount;

  ProfileModel({
    this.partnerId,
    this.name,
    this.email,
    this.mobile,
    this.membershipStatus,
    this.membershipType,
    this.vehiclesCount,
    this.bookingsCount,
    this.servicesCount,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      partnerId: json['partner_id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      membershipStatus: json['membership_status'],
      membershipType: json['membership_type'],
      vehiclesCount: json['vehicles_count'],
      bookingsCount: json['bookings_count'],
      servicesCount: json['services_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'partner_id': partnerId,
      'name': name,
      'email': email,
      'mobile': mobile,
      'membership_status': membershipStatus,
      'membership_type': membershipType,
      'vehicles_count': vehiclesCount,
      'bookings_count': bookingsCount,
      'services_count': servicesCount,
    };
  }
}