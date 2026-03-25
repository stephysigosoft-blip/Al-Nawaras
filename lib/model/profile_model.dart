class ProfileModel {
  final int? partnerId;
  final String? name;
  final String? email;
  final String? mobile;
  final String? profileImage;
  final String? membershipStatus;


  ProfileModel({
    this.partnerId,
    this.name,
    this.email,
    this.mobile,
    this.profileImage,
    this.membershipStatus,

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
    );
  }
}