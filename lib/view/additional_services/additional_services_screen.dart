import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/additional_services_controller.dart';
import '../../controller/home_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/draggable_help_button.dart';

class AdditionalServicesScreen extends StatelessWidget {
  const AdditionalServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<AdditionalServicesController>(
      init: AdditionalServicesController(),
      initState: (state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.find<HomeController>().currentIndex = 2;
          Get.find<HomeController>().update();
        });
      },
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: 'Additional Services',
            centerTitle: false,
            onBackPressed: () {
              Get.find<HomeController>().currentIndex = 0;
              Get.find<HomeController>().update();
              Get.back();
            },
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: height * 0.025),
                      const Text(
                        'Select from our range of additional services',
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                      ),
                      SizedBox(height: height * 0.025),
                      // Render each service card
                      ...controller.services.asMap().entries.map((entry) {
                        int idx = entry.key;
                        var service = entry.value;
                        return Padding(
                          padding: EdgeInsets.only(bottom: height * 0.03),
                          child: _buildServiceCard(
                            service,
                            idx,
                            controller,
                            height,
                            width,
                          ),
                        );
                      }),
                      SizedBox(height: height * 0.05),
                    ],
                  ),
                ),
              ),
              const DraggableHelpButton(),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: 2,
            onTap: (index) {
              Get.find<HomeController>().changeBottomNavIndex(index);
            },
          ),
        );
      },
    );
  }

  Widget _buildServiceCard(
    Map<String, String> service,
    int index,
    AdditionalServicesController controller,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.asset(
            service['image']!,
            height: height * 0.15,
            width: width * 0.5,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: Colors.grey.shade300,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            service['title']!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xFF00B2FF), fontSize: 17),
          ),
          SizedBox(height: height * 0.015),
          Text(
            service['description']!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 11.5,
              height: 1.5,
            ),
          ),
          SizedBox(height: height * 0.02),
          Text(
            service['price']!,
            style: TextStyle(
              color: Colors.black.withOpacity(0.6),
              fontSize: 16,
            ),
          ),
          SizedBox(height: height * 0.025),
          ElevatedButton(
            onPressed: () => controller.onBuyNowClick(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00B2FF),
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
            ),
            child: const Text('Buy Now!', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
