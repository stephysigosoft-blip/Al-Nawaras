import 'package:flutter/material.dart';
import '../widgets/booking_card.dart';
import '../widgets/booking_tab_bar.dart';
import '../widgets/draggable_help_button.dart';
import '../widgets/custom_bottom_nav_bar.dart';
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
          Get.find<HomeController>().currentIndex = 1;
          Get.find<HomeController>().update();
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

                    if (_selectedTab == 'All' || _selectedTab == 'Active') ...[
                      const Text(
                        'May 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      BookingCard(
                        title: 'Monthly Membership',
                        subtitle: 'Airstream Caravel • Spot A12',
                        status: 'Active',
                        startDate: '15 May 2023',
                        endDate: '15 Jun 2023',
                        amount: 'AED 1,575',
                        isActive: true,
                        actions: [
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
                                  side: BorderSide(
                                    color: const Color(0xFFE30613),
                                    width: 1.5,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Extend',
                                  style: TextStyle(
                                    color: const Color(0xFFE30613),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],

                    if (_selectedTab == 'All' ||
                        _selectedTab == 'Completed') ...[
                      if (_selectedTab == 'Completed') ...[
                        const Text(
                          'May 2023',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],

                      BookingCard(
                        title: 'Daily Parking',
                        subtitle: 'Airstream Caravel • Spot A12',
                        status: 'Completed',
                        startDate: '15 May 2023',
                        endDate: '15 Jun 2023',
                        amount: 'AED 1,575',
                        isActive: false,
                        actions: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
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
                        ],
                      ),
                      const SizedBox(height: 24),

                      const Text(
                        'May 2023',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 12),

                      BookingCard(
                        title: 'Weekly Parking',
                        subtitle: 'Airstream Caravel • Spot A12',
                        status: 'Completed',
                        startDate: '15 May 2023',
                        endDate: '15 Jun 2023',
                        amount: 'AED 1,575',
                        isActive: false,
                        actions: [
                          Expanded(
                            child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
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
                        ],
                      ),
                      const SizedBox(height: 24),
                    ],

                    if (_selectedTab == 'All' ||
                        _selectedTab == 'Completed') ...[
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
