import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/home_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_app_bar.dart';

class RecentActivityView extends StatelessWidget {
  const RecentActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: S.of(context).recentActivity,
            onBackPressed: () => Get.back(),
          ),
          body: controller.filteredActivities.isEmpty
              ? Center(
                  child: Text(
                    S.of(context).currentlyNoItemsFoundPleaseTryLater,
                  ),
                )
              : NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      controller.loadMoreActivities();
                    }
                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.02,
                    ),
                    itemCount:
                        controller.filteredActivities.length +
                        (controller.isActivityLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.filteredActivities.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      final activity = controller.filteredActivities[index];
                      String title = "";
                      String subtitle = activity['subtitle'];

                      if (activity['titleKey'] == 'parkingRenewed') {
                        title = S.of(context).parkingRenewed;
                        subtitle = subtitle.replaceAll(
                          'monthlyPremium',
                          S.of(context).monthlyPremium,
                        );
                      } else if (activity['titleKey'] == 'vehicleCheckIn') {
                        title = S.of(context).vehicleCheckIn;
                        subtitle = subtitle.replaceAll(
                          'parkedAtSpotA12',
                          S.of(context).parkedAtSpot('A12'),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.only(bottom: height * 0.01),
                        child: _buildActivityCard(
                          title,
                          subtitle,
                          activity['icon'],
                          activity['color'],
                          height,
                          width,
                        ),
                      );
                    },
                  ),
                ),
        );
      },
    );
  }

  Widget _buildActivityCard(
    String title,
    String subtitle,
    IconData iconData,
    Color iconColor,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: height * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: height * 0.045,
            width: height * 0.045,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData, color: iconColor, size: 20),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF001133),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: height * 0.005),
                Text(
                  subtitle,
                  style: const TextStyle(fontSize: 10, color: Colors.black54),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
