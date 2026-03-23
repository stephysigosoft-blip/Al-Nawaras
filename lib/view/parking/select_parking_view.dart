import 'package:al_nawaras/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/api_constants.dart';
import '../../generated/l10n.dart';

class _SlotRowConfig {
  final double top;
  final double startX;
  final int count;
  final double slotW;
  final double slotH;
  final String prefix;

  _SlotRowConfig({
    required this.top,
    required this.startX,
    required this.count,
    required this.slotW,
    required this.slotH,
    required this.prefix,
  });
}

class SelectParkingView extends StatefulWidget {
  final bool isDirectionMode;
  const SelectParkingView({super.key, this.isDirectionMode = false});

  @override
  State<SelectParkingView> createState() => _SelectParkingViewState();
}

class _SelectParkingViewState extends State<SelectParkingView> {
  String selectedSlotCode = ""; // Empty by default
  String selectedSlotNumber = ""; // Empty by default
  String selectedLocationCode = ""; // Empty by default
  String selectedLocation = "";
  String selectedLocationType = "";
  String selectedSlotSize = "";
  bool isLoadingData = false;

  List<String> bookedSlots = [];
  List<String> shadedSlots = [];

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
      ),
      _SlotRowConfig(
        top: 250, // Shuttles inside 220-340 track
        startX: 220,
        count: 64,
        slotW: 46,
        slotH: 55,
        prefix: 'FTP',
      ),
      _SlotRowConfig(
        top: 410, // Shuttles inside 380-500 track
        startX: 240,
        count: 69,
        slotW: 42,
        slotH: 50,
        prefix: 'BTP',
      ),
      _SlotRowConfig(
        top: 570, // Shuttles inside 540-660 track
        startX: 210,
        count: 70,
        slotW: 42,
        slotH: 50,
        prefix: 'CTP',
      ),
    ];

    // Booked and Shaded slots are now dynamic.
    // They will be populated as you select slots or if an API is provided to list all.
    bookedSlots = [];
    shadedSlots = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isDirectionMode) {
        _fetchDynamicParkingDetails();
      } else {
        _fetchVehicleTypes();
      }
    });
  }

  Future<void> _fetchVehicleTypes() async {
    try {
      setState(() {
        isLoadingData = true;
      });

      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (vehicle_types) ---');
      debugPrint('URL: ${ApiConstants.vehicleTypes}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.vehicleTypes,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (vehicle_types) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List types = response.data['data'] as List? ?? [];

          if (mounted) {
            setState(() {
              for (var type in types) {
                String? name = type['slot_type_name']?.toString().toUpperCase();
                if (name != null) {
                  // If a vehicle type exists, we mark its area as tentatively booked for these demo slots
                  if (name.contains('JETSKI')) {
                    if (!bookedSlots.contains('JTSP-01'))
                      bookedSlots.add('JTSP-01');
                  } else if (name.contains('FOOD TRUCK')) {
                    if (!bookedSlots.contains('FTP-01'))
                      bookedSlots.add('FTP-01');
                  } else if (name.contains('BOATS')) {
                    if (!bookedSlots.contains('BTP-01'))
                      bookedSlots.add('BTP-01');
                  } else if (name.contains('CARAVAN')) {
                    if (!bookedSlots.contains('CTP-01'))
                      bookedSlots.add('CTP-01');
                  }
                }
              }
            });
          }

          if (types.isNotEmpty) {
            // Check if we should fetch dynamic parking details based on vehicle types
            _fetchDynamicParkingDetails();
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching vehicle types: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingData = false;
        });
      }
    }
  }

  Future<void> _fetchDynamicParkingDetails() async {
    try {
      setState(() {
        isLoadingData = true;
      });

      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (location_details) ---');
      debugPrint('URL: ${ApiConstants.locationDetails}');
      debugPrint('Parameters: {booking_id: 1}');

      // 1. Fetch location details
      final locationResponse = await dio.get(
        ApiConstants.locationDetails,
        queryParameters: {'booking_id': 1},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (location_details) ---');
      debugPrint('Status Code: ${locationResponse.statusCode}');
      debugPrint('Response Data: ${locationResponse.data}');
      debugPrint('--------------------------\n');

      if (locationResponse.statusCode == 200 && locationResponse.data != null) {
        if (locationResponse.data['status'] == true) {
          final data = locationResponse.data['data'];
          if (data != null && data['slot_number'] != null) {
            final returnedSlotNumber = data['slot_number'];
            await _fetchSlotDetails(returnedSlotNumber, headers, dio);
            return;
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching parking details: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingData = false;
        });
      }
    }
  }

  String _getPrefixFromSlotNumber(String slotNumber) {
    if (slotNumber.contains('JETSKI')) return 'JTSP';
    if (slotNumber.contains('FOOD TRUCK')) return 'FTP';
    if (slotNumber.contains('BOATS')) return 'BTP';
    if (slotNumber.contains('CARAVAN')) return 'CTP';
    return '';
  }

  String _getNumberFromSlotNumber(String slotNumber) {
    // Expected format "A01 - JETSKI" or "B12 - FOOD TRUCK"
    final regex = RegExp(r'[A-D](\d+) -');
    final match = regex.firstMatch(slotNumber);
    if (match != null) {
      return match.group(1) ?? "";
    }
    return "";
  }

  Future<void> _fetchSlotDetails(
    String slotNumber,
    Map<String, dynamic> headers,
    Dio dio,
  ) async {
    debugPrint('\n--- API REQUEST (slot_details) ---');
    debugPrint('URL: ${ApiConstants.slotDetails}');
    debugPrint('Body: {"slot_number": "$slotNumber"}');

    final slotResponse = await dio.post(
      ApiConstants.slotDetails,
      data: {'slot_number': slotNumber},
      options: Options(
        headers: headers,
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    debugPrint('--- API RESPONSE (slot_details) ---');
    debugPrint('Status Code: ${slotResponse.statusCode}');
    debugPrint('Response Data: ${slotResponse.data}');
    debugPrint('--------------------------\n');

    if (slotResponse.statusCode == 200 && slotResponse.data != null) {
      if (slotResponse.data['status'] == true) {
        final data = slotResponse.data['data'];
        if (mounted && data != null) {
          setState(() {
            if (widget.isDirectionMode) {
              final prefix = _getPrefixFromSlotNumber(slotNumber);
              final num = _getNumberFromSlotNumber(slotNumber);
              if (prefix.isNotEmpty && num.isNotEmpty) {
                selectedSlotCode = "$prefix-$num";
              }
            }

            selectedLocation =
                data['location_name']?.toString() ??
                _getFriendlyLocation(
                  selectedSlotCode.isNotEmpty
                      ? selectedSlotCode.split('-').first
                      : slotNumber.split('-').first,
                );
            selectedLocationType =
                data['location_type']?.toString() ??
                _getLocationType(slotNumber.split('-').first);
            selectedSlotSize =
                data['slot_size']?.toString() ??
                _getSlotSize(slotNumber.split('-').first);
            selectedSlotNumber = data['slot_number']?.toString() ?? "N/A";
            selectedLocationCode = data['location_code']?.toString() ?? "N/A";

            if (data.containsKey('is_booked')) {
              if (data['is_booked'] == true) {
                if (!bookedSlots.contains(selectedSlotCode))
                  bookedSlots.add(selectedSlotCode);
              } else {
                bookedSlots.remove(selectedSlotCode);
              }
            }
            if (data.containsKey('shaded_slot')) {
              if (data['shaded_slot'] == true) {
                if (!shadedSlots.contains(selectedSlotCode))
                  shadedSlots.add(selectedSlotCode);
              } else {
                shadedSlots.remove(selectedSlotCode);
              }
            }
          });
        }
      }
    }
  }

  Future<void> _onSlotSelected(String codeString, String formattedSlot) async {
    setState(() {
      selectedSlotCode = codeString; // Keep internal code for UI matching
      selectedSlotNumber = formattedSlot;
      selectedLocation = _getFriendlyLocation(codeString.split('-').first);
      selectedLocationType = _getLocationType(codeString.split('-').first);
      selectedSlotSize = _getSlotSize(codeString.split('-').first);
      isLoadingData = true;
    });

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };
      await _fetchSlotDetails(formattedSlot, headers, dio);
    } catch (e) {
      debugPrint('Error fetching slot details: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoadingData = false;
        });
      }
    }
  }

  String _formatSlotCode(String prefix, int index) {
    String formattedPrefix = prefix;
    String locationName = "";

    switch (prefix) {
      case 'JTSP':
        formattedPrefix = "A";
        locationName = "JETSKI";
        break;
      case 'FTP':
        formattedPrefix = "B";
        locationName = "FOOD TRUCK";
        break;
      case 'BTP':
        formattedPrefix = "C";
        locationName = "BOATS";
        break;
      case 'CTP':
        formattedPrefix = "D";
        locationName = "CARAVAN";
        break;
    }

    return "$formattedPrefix${index.toString().padLeft(2, '0')} - $locationName";
  }

  Future<void> _confirmLocation() async {
    setState(() {
      isLoadingData = true;
    });

    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final Map<String, dynamic> requestBody = {
        'booking_id': 1,
        'slot_number': _formatSlotCode(
          selectedSlotCode.split('-').first,
          int.parse(selectedSlotCode.split('-').last),
        ),
      };

      debugPrint('\n--- API REQUEST (confirm_location) ---');
      debugPrint('URL: ${ApiConstants.confirmLocation}');
      debugPrint('Body: $requestBody');

      final response = await dio.post(
        ApiConstants.confirmLocation,
        data: requestBody,
        options: Options(
          headers: headers,
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      debugPrint('--- API RESPONSE (confirm_location) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');
      debugPrint('--------------------------\n');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          if (mounted) {
            _showCustomSnackBar(
              response.data['message'] ??
                  S.of(context).locationConfirmedSuccessfully,
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color(0xFFE30613),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                content: Text(
                  response.data['message'] ?? S.of(context).failedToConfirmLocation,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint('Error confirming location: $e');
      _showCustomSnackBar(S.of(context).errorConfirmingLocation, isError: true);
    } finally {
      if (mounted) {
        setState(() {
          isLoadingData = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        title: Text(
          widget.isDirectionMode
              ? S.of(context).vehicleDirection
              : S.of(context).selectParkingLocation,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 19),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
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
                                  bookedSlots: bookedSlots,
                                  shadedSlots: shadedSlots,
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
          if (isLoadingData)
            Container(
              color: Colors.black12,
              child: const Center(
                child: CircularProgressIndicator(color: Color(0xFFE30613)),
              ),
            ),
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
            if (bookedSlots.contains(codeString)) return; // Booked

            final formattedSlot = _formatSlotCode(row.prefix, i + 1);
            _onSlotSelected(codeString, formattedSlot);
            return;
          }
        }
      }
    }
  }

  String _getFriendlyLocation(String prefix) {
    switch (prefix) {
      case 'JTSP':
        return S.of(context).jetskiParking;
      case 'FTP':
        return S.of(context).foodTruckParking;
      case 'BTP':
        return S.of(context).boatsParking;
      case 'CTP':
        return S.of(context).caravanParking;
      default:
        return S.of(context).areaSuffix(prefix);
    }
  }

  String _getLocationType(String prefix) {
    if (prefix == 'BTP' || prefix == 'CTP') return S.of(context).shaded;
    return S.of(context).open;
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
        return S.of(context).standard;
    }
  }

  Widget _buildInstructions() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Text(
        S.of(context).navigateSelectSlot,
        style: const TextStyle(color: Colors.black87, fontSize: 12.5),
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
          if (selectedSlotCode.isNotEmpty) ...[
            const SizedBox(height: 18),
            _buildInfoRow(S.of(context).locationCodeLabel, selectedLocationCode),
            _buildInfoRow(S.of(context).slotNumberLabel, selectedSlotNumber),
            _buildInfoRow(S.of(context).locationLabel, selectedLocation),
            _buildInfoRow(S.of(context).locationTypeLabel, selectedLocationType),
            _buildInfoRow(S.of(context).sizeLabel, selectedSlotSize),
          ],

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
              onPressed: selectedSlotCode.isEmpty ? null : _confirmLocation,
              child: Text(
                S.of(context).confirmLocation,
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
        _buildLegendItem(const Color(0xFF2E2E2E), S.of(context).available),
        _buildLegendItem(const Color(0xFFCDCDCD), S.of(context).booked),
        _buildLegendItem(const Color(0xFFE30613), S.of(context).selected),
        _buildLegendItem(const Color(0xFF7B846D), S.of(context).shaded),
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
    if (value.isEmpty) return const SizedBox.shrink();
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

  void _showCustomSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError
            ? const Color(0xFFE30613)
            : const Color(0xFF2ECC71),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class _CompleteMapPainter extends CustomPainter {
  final String selectedCode;
  final List<_SlotRowConfig> slotRows;
  final List<String> bookedSlots;
  final List<String> shadedSlots;

  _CompleteMapPainter({
    required this.selectedCode,
    required this.slotRows,
    required this.bookedSlots,
    required this.shadedSlots,
  });

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
      final isBooked = bookedSlots.contains(codeString);
      final isSelected = codeString == selectedCode;
      final isShaded = shadedSlots.contains(codeString);

      Paint cellPaint = availablePaint;
      if (isShaded) cellPaint = shadedPaint;
      if (isBooked) cellPaint = bookedPaint;
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
