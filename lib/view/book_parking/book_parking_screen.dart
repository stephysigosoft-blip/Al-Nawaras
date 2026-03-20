import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/book_parking_controller.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/draggable_help_button.dart';

class BookParkingScreen extends StatelessWidget {
  const BookParkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<BookParkingController>(
      init: BookParkingController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: CustomAppBar(
            title: 'Book Parking',
            centerTitle: false,
            onBackPressed: () {
              Get.back();
            },
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height * 0.025),
                            _buildLabel('Select Vehicle'),
                            _buildVehicleCard(controller, width, height),
                            SizedBox(height: height * 0.035),
                            _buildLabel('Parking Type'),
                            _buildParkingTypeRow(controller, width, height),
                            SizedBox(height: height * 0.035),
                            _buildLabel('Membership Package'),
                            _buildMembershipList(controller, width, height),
                            SizedBox(height: height * 0.035),
                            _buildDateTimeSection(controller, width, height),
                            SizedBox(height: height * 0.035),
                            _buildLabel('Add-on Services (Optional)'),
                            _buildAddonList(controller, width, height),
                            SizedBox(height: height * 0.05),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _buildBottomAction(controller, width, height),
                ],
              ),
              const DraggableHelpButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildVehicleCard(
    BookParkingController controller,
    double width,
    double height,
  ) {
    if (controller.isLoadingVehicles) {
      return Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFFE30613)),
        ),
      );
    }

    if (controller.vehiclesList.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            "No vehicles found",
            style: TextStyle(color: Colors.black45),
          ),
        ),
      );
    }

    final v = controller.selectedVehicleData;
    if (v == null) return const SizedBox();

    return PopupMenuButton<Map<String, dynamic>>(
      onSelected: (vehicle) => controller.setSelectedVehicle(vehicle),
      offset: const Offset(0, 80),
      itemBuilder: (context) {
        return controller.vehiclesList.map((vehicle) {
          return PopupMenuItem<Map<String, dynamic>>(
            value: vehicle,
            child: Text(
              '${vehicle['vehicle_type_name']} (${vehicle['license_number']})',
              style: const TextStyle(fontSize: 13),
            ),
          );
        }).toList();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Image.asset(
              controller.getVehicleImage(v['vehicle_type_name']),
              height: 50,
              width: 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    v['vehicle_type_name'] ?? 'Generic Vehicle',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF001133),
                    ),
                  ),
                  Text(
                    'License: ${v['license_number'] ?? 'N/A'}',
                    style: const TextStyle(fontSize: 12, color: Colors.black45),
                  ),
                ],
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.black38),
          ],
        ),
      ),
    );
  }

  Widget _buildParkingTypeRow(
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildParkingTypeItem(
          'Unshaded',
          AssetImage("lib/assets/images/unshaded.png"),
          controller,
          width,
        ),
        _buildParkingTypeItem(
          'Shaded',
          AssetImage("lib/assets/images/shaded.png"),
          controller,
          width,
        ),
        _buildParkingTypeItem(
          'Air Conditioned',
          AssetImage("lib/assets/images/air conditioned.png"),
          controller,
          width,
        ),
      ],
    );
  }

  Widget _buildParkingTypeItem(
    String title,
    AssetImage image,
    BookParkingController controller,
    double width,
  ) {
    final isSelected = controller.selectedParkingType == title;
    return GestureDetector(
      onTap: () => controller.setParkingType(title),
      child: Container(
        width: width * 0.28,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF00B2FF)
                : Colors.black.withOpacity(0.05),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF00B2FF)
                          : Colors.black12,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            height: 8,
                            width: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF00B2FF),
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            Image(image: image, height: 40, width: 40),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 11, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMembershipList(
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: controller.membershipPackages.map((pkg) {
          final isSelected = controller.selectedMembership == pkg['title'];
          return GestureDetector(
            onTap: () => controller.setMembership(pkg['title']!),
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black.withOpacity(0.05)),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF00B2FF)
                            : Colors.black12,
                      ),
                    ),
                    child: isSelected
                        ? Center(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF00B2FF),
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pkg['title']!,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        pkg['price']!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateTimeSection(
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date & Time',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: height * 0.02),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Date',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField('dd/mm/yyyy', controller.dateController),
                ],
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Start Time',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  _buildDateField('--- -- --', controller.timeController),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String hint, TextEditingController controller) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black.withOpacity(0.08)),
      ),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildAddonList(
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Column(
      children: List.generate(controller.addonServices.length, (index) {
        final addon = controller.addonServices[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                _buildCustomCheckbox(
                  addon['isSelected'],
                  () => controller.toggleAddon(index),
                ),
                const SizedBox(width: 12),
                Image.asset(
                  addon['icon'],
                  height: 40,
                  width: 40,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: addon['title'] + ' ',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B2FF),
                              ),
                            ),
                            TextSpan(
                              text: '(${addon['price']})',
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00B2FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        addon['subtitle'],
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildBottomAction(
    BookParkingController controller,
    double width,
    double height,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Total Amount',
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
                SizedBox(height: height * 0.01),
                Text(
                  'AED 700.00',
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: controller.onNextClick,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                foregroundColor: Colors.white,
                minimumSize: Size(width * 0.5, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomCheckbox(bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 18,
            width: 18,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black.withOpacity(0.4),
                width: 1.5,
              ),
            ),
          ),
          if (isSelected)
            Positioned(
              top: -3,
              left: 2,
              child: CustomPaint(
                size: const Size(18, 18),
                painter: TickPainter(),
              ),
            ),
        ],
      ),
    );
  }
}

class TickPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Starting point of the tick
    path.moveTo(size.width * 0.1, size.height * 0.45);
    // Bottom point of the tick
    path.lineTo(size.width * 0.35, size.height * 0.75);
    // Ending point (long slanted line)
    path.lineTo(size.width * 1.0, size.height * 0.05);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
