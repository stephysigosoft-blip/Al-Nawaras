import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/register_vehicle_controller.dart';

class RegisterVehicleScreen extends StatelessWidget {
  const RegisterVehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return GetBuilder<RegisterVehicleController>(
      init: RegisterVehicleController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F7F7),
          appBar: AppBar(
            backgroundColor: const Color(0xFFE30613),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Get.back(),
            ),
            title: const Text(
              'Register Vehicle',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            actions: [
              TextButton(
                onPressed: controller.onSkipClick,
                child: Row(
                  children: [
                    const Text(
                      'Skip ',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                    ),
                    const Icon(
                      Icons.double_arrow_rounded,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(width: width * 0.02),
                  ],
                ),
              ),
            ],
            centerTitle: false,
            titleSpacing: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.025),
                  const Text(
                    'Please provide your vehicle details',
                    style: TextStyle(color: Colors.black54, fontSize: 13),
                  ),
                  SizedBox(height: height * 0.03),
                  const Text(
                    'Select Vehicle Type',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF001133),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  _buildVehicleTypeGrid(controller, height, width),
                  SizedBox(height: height * 0.035),
                  _buildLabel('Vehicle License Number'),
                  _buildTextField(
                    controller.licenseController,
                    'Enter your License Number',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.02),
                  _buildLabel('Make'),
                  _buildTextField(
                    controller.makeController,
                    'e.g. Yamaha',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.02),
                  _buildLabel('Model'),
                  _buildTextField(
                    controller.modelController,
                    'e.g. Caravel',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.02),
                  _buildLabel('Year'),
                  _buildTextField(
                    controller.yearController,
                    'e.g. 2020',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.035),
                  const Text(
                    'Vehicle Dimensions',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color(0xFF001133),
                    ),
                  ),
                  SizedBox(height: height * 0.015),
                  _buildTextField(
                    controller.lengthController,
                    'Length (m)',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.012),
                  _buildTextField(
                    controller.widthController,
                    'Width (m)',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.012),
                  _buildTextField(
                    controller.heightController,
                    'Height (m)',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.035),
                  _buildLabel('Comments'),
                  _buildTextArea(
                    controller.commentsController,
                    'Comments',
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.035),
                  _buildLabel('Vehicle Photo'),
                  _buildUploadBox(
                    'Tap to upload vehicle photo',
                    controller.onUploadPhotoClick,
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.035),
                  _buildLabel('Vehicle Registration Document'),
                  _buildUploadBox(
                    'Tap to upload registration document',
                    controller.onUploadDocClick,
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.045),
                  _buildButton(
                    'Register Vehicle',
                    const Color(0xFFE30613),
                    Colors.white,
                    controller.onRegisterClick,
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.015),
                  _buildOutlinedButton(
                    'Register Later',
                    const Color(0xFFE30613),
                    controller.onRegisterLaterClick,
                    height,
                    width,
                  ),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVehicleTypeGrid(
    RegisterVehicleController controller,
    double height,
    double width,
  ) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTypeItem(
              'Caravan',
              'lib/assets/images/caravan.png',
              controller,
              width,
            ),
            _buildTypeItem(
              'Jet Ski',
              'lib/assets/images/jetski.png',
              controller,
              width,
            ),
            _buildTypeItem(
              'Trolly',
              'lib/assets/images/trolly.png',
              controller,
              width,
            ),
          ],
        ),
        SizedBox(height: height * 0.015),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTypeItem(
              'Food Truck',
              'lib/assets/images/foodtruck.png',
              controller,
              width,
            ),
            SizedBox(width: width * 0.04),
            _buildTypeItem(
              'Boat',
              'lib/assets/images/boat.png',
              controller,
              width,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeItem(
    String title,
    String imagePath,
    RegisterVehicleController controller,
    double width,
  ) {
    final isSelected = controller.selectedVehicleType == title;
    return GestureDetector(
      onTap: () => controller.setVehicleType(title),
      child: Container(
        width: width * 0.28,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              height: 50,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.directions_car,
                size: 40,
                color: Colors.black12,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isSelected ? const Color(0xFFE30613) : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? const Color(0xFFE30613) : Colors.black12,
                  width: 1,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 8,
                        width: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black54,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String hint,
    double height,
    double width,
  ) {
    return Container(
      height: height * 0.055,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        ),
      ),
    );
  }

  Widget _buildTextArea(
    TextEditingController controller,
    String hint,
    double height,
    double width,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.08)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: 4,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black26, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }

  Widget _buildUploadBox(
    String hint,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.12,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: CustomPaint(
          painter: DashPainter(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image_outlined, color: Colors.black26, size: 40),
              const SizedBox(height: 10),
              Text(
                hint,
                style: const TextStyle(color: Colors.black26, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text,
    Color bg,
    Color textCol,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: textCol,
        minimumSize: Size(double.infinity, height * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }

  Widget _buildOutlinedButton(
    String text,
    Color color,
    VoidCallback onTap,
    double height,
    double width,
  ) {
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 1.2),
        minimumSize: Size(double.infinity, height * 0.06),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
      ),
    );
  }
}

class DashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    const dashWidth = 6.0;
    const dashSpace = 4.0;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    final metrics = path.computeMetrics();
    for (final metric in metrics) {
      var distance = 0.0;
      while (distance < metric.length) {
        final length = dashWidth;
        canvas.drawPath(metric.extractPath(distance, distance + length), paint);
        distance += length + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
