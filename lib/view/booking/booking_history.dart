import 'package:flutter/material.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_tab_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/custom_no_data.dart';
import '../../controller/home_controller.dart';
import 'package:get/get.dart';

class BookingHistoryView extends StatefulWidget {
  const BookingHistoryView({super.key});

  @override
  State<BookingHistoryView> createState() => _BookingHistoryViewState();
}

class _BookingHistoryViewState extends State<BookingHistoryView> {
  String _selectedTab = 'All';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find<HomeController>(),
      initState: (_) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final ctrl = Get.find<HomeController>();
          ctrl.currentIndex = 1;
          ctrl.fetchParkingHistory();
          ctrl.update();
        });
      },
      builder: (controller) {
        final mediaQuery = MediaQuery.of(context);
        final width = mediaQuery.size.width;
        final padding = width * 0.04;

        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: AppBar(
            backgroundColor: const Color(0xFFE30613),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  controller.changeBottomNavIndex(0);
                }
              },
            ),
            title: const Text(
              'Booking History',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            centerTitle: false,
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: padding,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Toggle Tab Bar
                    BookingTabBar(
                      selectedTab: _selectedTab,
                      width: width,
                      onTabChanged: (tab) {
                        setState(() {
                          _selectedTab = tab;
                        });
                      },
                    ),
                    const SizedBox(height: 24),

                    const SizedBox(height: 24),

                    if (controller.isLoadingHistory)
                      SizedBox(
                        height: mediaQuery.size.height * 0.6,
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFE30613),
                          ),
                        ),
                      )
                    else if (controller.bookingHistory.isEmpty)
                      SizedBox(
                        height: mediaQuery.size.height * 0.6,
                        child: const Center(
                          child: CustomNoData(
                            message: "No booking history found",
                          ),
                        ),
                      )
                    else
                      ..._buildDynamicCategorizedHistory(controller, padding),

                    if (_selectedTab == 'All' ||
                        _selectedTab == 'Completed') ...[
                      if (!controller.isLoadingHistory &&
                          controller.bookingHistory.isNotEmpty)
                        _buildLoadMoreButton(),
                    ],
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: controller.currentIndex,
            onTap: controller.changeBottomNavIndex,
          ),
        );
      },
    );
  }

  List<Widget> _buildDynamicCategorizedHistory(
    HomeController controller,
    double padding,
  ) {
    // Filter by tab
    List<Map<String, dynamic>> filtered = controller.bookingHistory.where((
      item,
    ) {
      if (_selectedTab == 'All') return true;
      if (_selectedTab == 'Active') return item['isActive'] == true;
      if (_selectedTab == 'Completed') return item['isActive'] == false;
      return true;
    }).toList();

    if (filtered.isEmpty) {
      return [
        SizedBox(
          height: 300,
          child: Center(
            child: CustomNoData(message: "No entries for $_selectedTab tab"),
          ),
        ),
      ];
    }

    // Group by MonthYear
    Map<String, List<Map<String, dynamic>>> groups = {};
    for (var item in filtered) {
      String key = item['monthYear'] ?? 'Recent';
      if (!groups.containsKey(key)) groups[key] = [];
      groups[key]!.add(item);
    }

    List<Widget> widgets = [];
    groups.forEach((month, items) {
      widgets.add(
        Text(
          month,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      );
      widgets.add(const SizedBox(height: 12));
      for (var item in items) {
        widgets.add(
          BookingCard(
            title: item['title'],
            subtitle: item['subtitle'],
            status: item['status'],
            startDate: item['startDate'],
            endDate: item['endDate'],
            amount: item['amount'],
            isActive: item['isActive'],
            actions: _buildActions(item['isActive']),
          ),
        );
        widgets.add(const SizedBox(height: 16));
      }
      widgets.add(const SizedBox(height: 8));
    });

    return widgets;
  }

  List<Widget> _buildActions(bool isActive) {
    if (isActive) {
      return [
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFE30613), width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Extend',
                style: TextStyle(
                  color: Color(0xFFE30613),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ];
    } else {
      return [
        Expanded(
          child: SizedBox(
            height: 48,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade300, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Details',
                style: TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ];
    }
  }

  Widget _buildLoadMoreButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            // borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
        ),
        child: const Text(
          'Load More',
          style: TextStyle(
            color: Colors.grey,
            // fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
