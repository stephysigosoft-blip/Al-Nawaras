import 'package:al_nawaras/view/widgets/rewards_card.dart';
import 'package:flutter/material.dart';
import '../widgets/rewards_header.dart';
import '../widgets/rewards_action_item.dart';
import '../widgets/draggable_help_button.dart';
import 'package:get/get.dart';
import '../../controller/rewards_controller.dart';
import '../widgets/custom_no_data.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.05;

    return GetBuilder<RewardsController>(
      init: RewardsController(),
      builder: (controller) {
        if (controller.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFE30613)),
            ),
          );
        }

        if (controller.rewardsData == null) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF00B0FF),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: const Center(
              child: CustomNoData(message: "Unable to load rewards"),
            ),
          );
        }

        final data = controller.rewardsData!;

        return Scaffold(
          backgroundColor: Colors.grey[100],
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        RewardsHeader(
                          width: width,
                          height: height,
                          userName: data['name'] ?? 'User',
                          phoneNumber: data['phone_number'] ?? '',
                          email: data['email'] ?? '',
                        ),
                        Positioned(
                          top: height * 0.25, // Position overlap curve
                          left: padding,
                          right: padding,
                          child: RewardsCard(
                            width: width,
                            points: '${data['points'] ?? 0} Points',
                            membershipType: data['membership_type'] ?? 'Silver Member',
                            memberSince: 'Member Since ${data['member_since'] ?? '2023'}',
                            progress: (data['progress_bar_data']?['percentage'] ?? 0) / 100.0,
                            membershipImage: controller.getMemberImage(data['membership_type']),
                          ),
                        ),
                      ],
                    ),
                    // Buffer space for the overlapping card
                    SizedBox(height: height * 0.2),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: padding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Earn Points',
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildEarnPointsList(data['earn_points_rules'] as List? ?? []),
                          const SizedBox(height: 24),
                          const Text(
                            'Redeem Points',
                            style: TextStyle(
                              // fontWeight: FontWeight.w900,
                              fontSize: 17,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildRedeemPointsSection(width, data['redeemable_rewards'] as List? ?? []),
                          const SizedBox(height: 24),
                          _buildShareAndEarnSection(width),
                          const SizedBox(height: 24),
                          _buildTermsAndConditionsButton(width),
                          const SizedBox(height: 32), // Space for bottom
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEarnPointsList(List rules) {
    if (rules.isEmpty) {
      // Default placeholders if rules are empty but API status is true
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: const Center(child: Text("No rules found")),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: rules.map((r) {
            String title = r['title'] ?? 'Title';
            return RewardsActionItem(
              icon: _getEarnIcon(title),
              title: title,
              points: '+${r['points'] ?? 0} pts',
            );
          }).toList(),
        ),
      ),
    );
  }

  AssetImage _getEarnIcon(String title) {
    String t = title.toLowerCase();
    if (t.contains('slot')) return const AssetImage("lib/assets/images/book slot.png");
    if (t.contains('add-ons')) return const AssetImage("lib/assets/images/purchase addon.png");
    if (t.contains('refer')) return const AssetImage("lib/assets/images/refere frnd.png");
    if (t.contains('review')) return const AssetImage("lib/assets/images/Write review.png");
    return const AssetImage("lib/assets/images/book slot.png");
  }

  Widget _buildRedeemPointsSection(double width, List rewards) {
    if (rewards.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(child: Text("No redeemable rewards available")),
      );
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: rewards.map((r) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: _buildRedeemCard(
              r['title']?.toString().replaceAll(' ', '\n') ?? 'Reward',
              '${r['points'] ?? 0} pts',
              width,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRedeemCard(String title, String points, double width) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 4),
            Text(points, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            SizedBox(
              height: width * 0.085,
              width: width * 0.22,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFFFF5252), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: const Text(
                  'Redeem',
                  style: TextStyle(
                    color: const Color(0xFFE30613),
                    //fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareAndEarnSection(double width) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.03,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Share & Earn',
                  style: TextStyle(
                    // fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Invite friends and earn more points!',
                  style: TextStyle(color: Colors.black54, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: width * 0.20,
            height: width * 0.09,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: const Color(0xFFE30613),
                  width: 1,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.zero,
              ),
              child: const Text(
                'Share',
                style: TextStyle(
                  color: const Color(0xFFE30613),
                  // fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditionsButton(double width) {
    return SizedBox(
      width: double.infinity,
      height: width * 0.12,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFFCDD2), width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'View Terms & Conditions',
          style: TextStyle(
            color: const Color(0xFFE30613),
            // fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
