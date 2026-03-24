import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/notifications_controller.dart';
import '../../generated/l10n.dart';
import '../widgets/custom_no_data.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationsController>(
      init: NotificationsController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: AppBar(
            backgroundColor: const Color(0xFFE30613),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Get.back(),
            ),
            title: Text(
              S.of(context).notifications,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            centerTitle: false,
          ),
          body: controller.isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Color(0xFFE30613)),
                )
              : RefreshIndicator(
                  onRefresh: () =>
                      controller.fetchNotifications(isRefresh: true),
                  color: const Color(0xFFE30613),
                  child: controller.notifications.isEmpty
                      ? ListView(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2,
                            ),
                            CustomNoData(
                              message: S.of(context).noNotifications,
                            ),
                          ],
                        )
                      : NotificationListener<ScrollNotification>(
                          onNotification: (ScrollNotification scrollInfo) {
                            if (scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                              controller.loadMore();
                            }
                            return true;
                          },
                          child: ListView.separated(
                            padding: const EdgeInsets.all(16),
                            itemCount:
                                controller.notifications.length +
                                (controller.hasMore ? 1 : 0),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) {
                              if (index == controller.notifications.length) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(
                                      color: Color(0xFFE30613),
                                    ),
                                  ),
                                );
                              }

                              final notification =
                                  controller.notifications[index];
                              return _buildNotificationTile(
                                context,
                                notification,
                              );
                            },
                          ),
                        ),
                ),
        );
      },
    );
  }

  Widget _buildNotificationTile(
    BuildContext context,
    Map<String, dynamic> notification,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFDECEC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.notifications_active_outlined,
              color: Color(0xFFE30613),
              size: 22,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notification['title'] ?? S.of(context).notification,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    if (notification['created_at'] != null)
                      Text(
                        _formatDate(notification['created_at']),
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  notification['message'] ?? '',
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return "";
    try {
      DateTime dt = DateTime.parse(dateStr);
      // Simple format, can use intl package if available
      return "${dt.day}/${dt.month}/${dt.year}";
    } catch (e) {
      return dateStr;
    }
  }
}
