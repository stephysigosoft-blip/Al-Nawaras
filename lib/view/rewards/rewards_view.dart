import 'package:al_nawaras/view/widgets/rewards_card.dart';
import 'package:flutter/material.dart';
import '../widgets/rewards_header.dart';
import '../widgets/rewards_action_item.dart';
import '../widgets/draggable_help_button.dart';

class RewardsView extends StatelessWidget {
  const RewardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.05;

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
                    RewardsHeader(width: width, height: height),
                    Positioned(
                      top: height * 0.25, // Position overlap curve
                      left: padding,
                      right: padding,
                      child: RewardsCard(width: width),
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
                      _buildEarnPointsList(),
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
                      _buildRedeemPointsSection(width),
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
  }

  Widget _buildEarnPointsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(10),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          children: const [
            RewardsActionItem(
              icon: AssetImage("lib/assets/images/book slot.png"),
              title: 'Book a Slot',
              points: '+10 pts',
            ),
            RewardsActionItem(
              icon: AssetImage("lib/assets/images/purchase addon.png"),
              title: 'Purchase Add-ons',
              points: '+5 pts',
            ),
            RewardsActionItem(
              icon: AssetImage("lib/assets/images/refere frnd.png"),
              title: 'Refer a Friend',
              points: '+50 pts',
            ),
            RewardsActionItem(
              icon: AssetImage("lib/assets/images/Write review.png"),
              title: 'Write a Review',
              points: '+15 pts',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRedeemPointsSection(double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildRedeemCard('Free Day\nPass', '100 pts', width),
          const SizedBox(width: 12),
          _buildRedeemCard('AED 50\nOFF', '200 pts', width),
          const SizedBox(width: 12),
          _buildRedeemCard('Free\nCleaning', '150 pts', width),
          const SizedBox(width: 12),
          _buildRedeemCard('Free Oil\nChange', '200 pts', width),
          const SizedBox(width: 12),
          _buildRedeemCard('Free Pick\n& Drop', '200 pts', width),
        ],
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
