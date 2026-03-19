import 'package:al_nawaras/view/book_parking/book_parking_screen.dart';
import 'package:al_nawaras/view/payment/payment_success_view.dart';
import 'package:flutter/material.dart';

class _SlotRowConfig {
  final double top;
  final double startX;
  final int count;
  final double slotW;
  final double slotH;
  final String prefix;
  final List<int> booked;
  final bool shaded;

  _SlotRowConfig({
    required this.top,
    required this.startX,
    required this.count,
    required this.slotW,
    required this.slotH,
    required this.prefix,
    this.booked = const [],
    this.shaded = false,
  });
}

class SelectParkingView extends StatefulWidget {
  const SelectParkingView({super.key});

  @override
  State<SelectParkingView> createState() => _SelectParkingViewState();
}

class _SelectParkingViewState extends State<SelectParkingView> {
  String selectedSlotCode = "FTP-12";
  String selectedLocation = "Food Truck Parking";

  final double canvasWidth = 2800.0;
  final double canvasHeight = 900.0;

  late final List<_SlotRowConfig> _slotRows;

  @override
  void initState() {
    super.initState();
    _slotRows = [
      _SlotRowConfig(
        top: 110, // Fits inside 90-180 track layout
        startX: 250,
        count: 69,
        slotW: 42,
        slotH: 48,
        prefix: 'JTSP',
        booked: [3, 4],
      ),
      _SlotRowConfig(
        top: 250, // Shuttles inside 220-340 track
        startX: 220,
        count: 64,
        slotW: 46,
        slotH: 55,
        prefix: 'FTP',
        booked: [5, 6],
      ),
      _SlotRowConfig(
        top: 410, // Shuttles inside 380-500 track
        startX: 240,
        count: 69,
        slotW: 42,
        slotH: 50,
        prefix: 'BTP',
        shaded: true,
      ),
      _SlotRowConfig(
        top: 570, // Shuttles inside 540-660 track
        startX: 210,
        count: 70,
        slotW: 42,
        slotH: 50,
        prefix: 'CTP',
        shaded: true,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        title: const Text(
          'Select Parking Location',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 19),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildInstructions(),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: GestureDetector(
                  onTapDown: (details) =>
                      _handleCanvasTap(details.localPosition),
                  child: Container(
                    width: canvasWidth,
                    height: canvasHeight,
                    color: const Color(0xFF242424),
                    child: Stack(
                      children: [
                        // Single Layer: Full CustomPaint layout covering road connects AND overlaps interactively
                        Positioned.fill(
                          child: CustomPaint(
                            painter: _CompleteMapPainter(
                              selectedCode: selectedSlotCode,
                              slotRows: _slotRows,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildFooterPanel(),
        ],
      ),
    );
  }

  void _handleCanvasTap(Offset position) {
    final double px = position.dx;
    final double py = position.dy;
    final double skewFactor = -0.7;

    for (final row in _slotRows) {
      if (py >= row.top && py <= row.top + row.slotH) {
        for (int i = 0; i < row.count; i++) {
          final double skewOffset = skewFactor * (row.top + row.slotH - py);
          final double slotStartX =
              row.startX + (i * row.slotW * 0.82) + skewOffset;

          if (px >= slotStartX && px <= slotStartX + row.slotW) {
            final codeString =
                "${row.prefix}-${(i + 1).toString().padLeft(2, '0')}";
            if (row.booked.contains(i + 1)) return; // Booked

            setState(() {
              selectedSlotCode = codeString;
              selectedLocation = _getFriendlyLocation(row.prefix);
            });
            return;
          }
        }
      }
    }
  }

  String _getFriendlyLocation(String prefix) {
    switch (prefix) {
      case 'JTSP':
        return "Jetski Parking";
      case 'FTP':
        return "Food Truck Parking";
      case 'BTP':
        return "Boats Parking";
      case 'CTP':
        return "Caravan Parking";
      default:
        return "$prefix Area";
    }
  }

  String _getLocationType(String prefix) {
    if (prefix == 'BTP' || prefix == 'CTP') return "Shaded";
    return "Open";
  }

  String _getSlotSize(String prefix) {
    switch (prefix) {
      case 'JTSP':
        return "4m x 10m";
      case 'FTP':
        return "5m x 17m";
      case 'BTP':
        return "5m x 15m";
      case 'CTP':
        return "5m x 16m";
      default:
        return "Standard";
    }
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: const Text(
        'Please navigate to select your parking slot of your choice.',
        style: TextStyle(color: Colors.black87, fontSize: 12.5),
      ),
    );
  }

  Widget _buildFooterPanel() {
    return Container(
      color: const Color(0xFFF2F2F2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLegendRow(),
          const SizedBox(height: 18),
          _buildInfoRow('Location Code : ', selectedSlotCode),
          _buildInfoRow('Location : ', selectedLocation),
          _buildInfoRow(
            'Location Type : ',
            _getLocationType(
              selectedSlotCode.contains('-')
                  ? selectedSlotCode.split('-')[0]
                  : 'FTP',
            ),
          ),
          _buildInfoRow(
            'Size : ',
            _getSlotSize(
              selectedSlotCode.contains('-')
                  ? selectedSlotCode.split('-')[0]
                  : 'FTP',
            ),
          ),

          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                minimumSize: const Size(double.infinity, 44),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => BookParkingScreen()),
                );
              },
              child: const Text(
                'Confirm Location',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildLegendItem(const Color(0xFF2E2E2E), 'Available'),
        _buildLegendItem(const Color(0xFFCDCDCD), 'Booked'),
        _buildLegendItem(const Color(0xFFE30613), 'Selected'),
        _buildLegendItem(const Color(0xFF7B846D), 'Shaded'),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(width: 14, height: 14, color: color),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Row(
        children: [
          SizedBox(
            width: 105,
            child: Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 12.5),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompleteMapPainter extends CustomPainter {
  final String selectedCode;
  final List<_SlotRowConfig> slotRows;

  _CompleteMapPainter({required this.selectedCode, required this.slotRows});

  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()
      ..color = const Color(0xFF1E1E1E)
      ..style = PaintingStyle.fill;
    final curvePaint = Paint()
      ..color = const Color(0xFF2B2B2B)
      ..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = Colors.white12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // --- 1. DRAW CONTINUOUS CONNECTING TRACKS ---
    _drawContinuousRoadTrack(
      canvas,
      90,
      180,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'JETSKI WITH TRAILER PARKING',
    );
    _drawContinuousRoadTrack(
      canvas,
      220,
      340,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'FOOD TRUCK PARKING - Length 17m',
    );
    _drawContinuousRoadTrack(
      canvas,
      380,
      500,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'BOATS PARKING (SHADED)',
    );
    _drawContinuousRoadTrack(
      canvas,
      540,
      660,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'CARAVAN PARKING (SHADED)',
    );

    // --- 2. DRAW SLOTTED OVERLAPPING BLOCKS MESH ---
    for (final row in slotRows) {
      _drawSlantedSlotsRow(
        canvas,
        top: row.top,
        startX: row.startX,
        count: row.count,
        slotW: row.slotW,
        slotH: row.slotH,
        prefix: row.prefix,
        booked: row.booked,
        shaded: row.shaded,
      );
    }
  }

  void _drawContinuousRoadTrack(
    Canvas canvas,
    double top,
    double bottom,
    double width,
    Paint fill,
    Paint loopFill,
    Paint line, {
    required String label,
  }) {
    final trackH = bottom - top;
    final ribbonPath = Path();
    ribbonPath.moveTo(200, top);
    ribbonPath.lineTo(width - 200, top);
    ribbonPath.quadraticBezierTo(
      width - 40,
      top + trackH / 2,
      width - 200,
      bottom,
    );
    ribbonPath.lineTo(200, bottom);
    ribbonPath.quadraticBezierTo(40, top + trackH / 2, 200, top);
    ribbonPath.close();

    canvas.drawPath(ribbonPath, loopFill);
    canvas.drawPath(ribbonPath, line);

    // Label coordinates Absolute continuous sizing setups framing coordinators setups dashboard formats
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(250, top - 18));
  }

  void _drawSlantedSlotsRow(
    Canvas canvas, {
    required double top,
    required double startX,
    required int count,
    required double slotW,
    required double slotH,
    required String prefix,
    List<int> booked = const [],
    bool shaded = false,
  }) {
    final availablePaint = Paint()
      ..color = const Color(0xFF2A2A2A)
      ..style = PaintingStyle.fill;
    final bookedPaint = Paint()
      ..color = const Color(0xFFCDCDCD)
      ..style = PaintingStyle.fill;
    final selectedPaint = Paint()
      ..color = const Color(0xFFE30613)
      ..style = PaintingStyle.fill;
    final shadedPaint = Paint()
      ..color = const Color(0xFF7B846D).withOpacity(0.35)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final double skewFactor = -0.7;

    for (int i = 0; i < count; i++) {
      final codeString = "$prefix-${(i + 1).toString().padLeft(2, '0')}";
      final isBooked = booked.contains(i + 1);
      final isSelected = codeString == selectedCode;

      Paint cellPaint = availablePaint;
      if (isBooked) cellPaint = bookedPaint;
      if (shaded) cellPaint = shadedPaint;
      if (isSelected) cellPaint = selectedPaint;

      final double x = startX + (i * slotW * 0.82);
      final double y = top;

      // Draw Slanted Parallelogram
      final Path slotPath = Path();
      slotPath.moveTo(x + (skewFactor * slotH), y);
      slotPath.lineTo(x + slotW + (skewFactor * slotH), y);
      slotPath.lineTo(x + slotW, y + slotH);
      slotPath.lineTo(x, y + slotH);
      slotPath.close();

      canvas.drawPath(slotPath, cellPaint);
      canvas.drawPath(slotPath, strokePaint);

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: (i + 1).toString().padLeft(2, '0'),
          style: TextStyle(
            color: isBooked || isSelected ? Colors.black87 : Colors.white70,
            fontSize: 9.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(x + slotW / 2 + (skewFactor * slotH / 2) - 5, y + slotH / 2 - 5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
