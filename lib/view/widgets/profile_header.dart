import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import '../../controller/home_controller.dart';
import '../../controller/profile_controller.dart';
import '../notifications/notifications_view.dart';

class ProfileHeader extends StatelessWidget {
  final double width;
  final double height;

  const ProfileHeader({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Red Header Background to match HomeScreen
        Container(
          height: height * 0.28,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFE30613), // Primary red color
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        } else {
                          Get.find<HomeController>().changeBottomNavIndex(0);
                        }
                      },
                    ),
                    const Text(
                      'Profile',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () => Get.to(() => const NotificationsView()),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.015),
                _buildUserInfo(width),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserInfo(double width) {
    final controller = Get.find<ProfileController>();
    return Obx(() {
    final user = controller.profile.value;
    final box = GetStorage();

    final name = user?.name ?? box.read('name') ?? 'User';
    final mobile = user?.mobile ?? box.read('mobile') ?? 'N/A';
    final email = user?.email ?? box.read('email') ?? 'N/A';
    final img = user?.profileImage;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: width * 0.09, // Dynamic size
              backgroundColor: Colors.transparent,
              backgroundImage: img != null && img.isNotEmpty
                  ? (img.startsWith('http')
                      ? NetworkImage(img)
                      : MemoryImage(base64Decode(img)) as ImageProvider)
                  : null,
              child: img == null || img.isEmpty
                  ? Icon(
                      Icons.person,
                      color: Colors.blueGrey[800],
                      size: width * 0.12,
                    )
                  : null,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mobile,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    });
  }
}
