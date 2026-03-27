import 'package:al_nawaras/view/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/api_constants.dart';
import '../../generated/l10n.dart';
import 'dart:math' as math;

class _SlotRowConfig {
  final double top;
  final double sec1StartX;
  final int sec1Count;
  final double sec2StartX;
  final int sec2Count;
  final double slotW;
  final double slotH;
  final String prefix;

  _SlotRowConfig({
    required this.top,
    required this.sec1StartX,
    required this.sec1Count,
    required this.sec2StartX,
    required this.sec2Count,
    required this.slotW,
    required this.slotH,
    required this.prefix,
  });
}

class SelectParkingView extends StatefulWidget {
  final bool isDirectionMode;
  final int? bookingId;
  const SelectParkingView({
    super.key,
    this.isDirectionMode = false,
    this.bookingId,
  });

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
  Map<String, dynamic>? lookupVehicle;
  String initialConfirmedSlot = ""; 

  final double canvasWidth = 3500.0;
  final double canvasHeight = 900.0;

  late final List<_SlotRowConfig> _slotRows;

  @override
  void initState() {
    super.initState();
    _slotRows = [
      _SlotRowConfig(
        top: 110,
        sec1StartX: 250,
        sec1Count: 17,
        sec2StartX: 1200,
        sec2Count: 47,
        slotW: 42,
        slotH: 48,
        prefix: 'JTSP1',
      ),
      _SlotRowConfig(
        top: 250,
        sec1StartX: 250,
        sec1Count: 17,
        sec2StartX: 1200,
        sec2Count: 47,
        slotW: 42,
        slotH: 48,
        prefix: 'JTSP2',
      ),
      _SlotRowConfig(
        top: 410,
        sec1StartX: 250,
        sec1Count: 17,
        sec2StartX: 1200,
        sec2Count: 47,
        slotW: 42,
        slotH: 50,
        prefix: 'FTP17',
      ),
      _SlotRowConfig(
        top: 570,
        sec1StartX: 250,
        sec1Count: 17,
        sec2StartX: 1200,
        sec2Count: 47,
        slotW: 42,
        slotH: 50,
        prefix: 'FTP13A',
      ),
      _SlotRowConfig(
        top: 730,
        sec1StartX: 250,
        sec1Count: 17,
        sec2StartX: 1200,
        sec2Count: 47,
        slotW: 42,
        slotH: 50,
        prefix: 'FTP13B',
      ),
    ];

    // Booked and Shaded slots are now dynamic.
    // They will be populated as you select slots or if an API is provided to list all.
    bookedSlots = [];
    shadedSlots = [];
    // Shaded slots for Section 2: 35 to 47
    for (int i = 35; i <= 47; i++) {
      for (final row in _slotRows) {
        shadedSlots.add("${row.prefix}_S2-${i.toString().padLeft(2, '0')}");
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.isDirectionMode) {
        _lookupVehicle();
        _fetchDynamicParkingDetails();
      } else {
        _fetchVehicleTypes();
        _fetchParkingHistory();
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
              // Demo logic removed as per implementation plan
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

  Future<void> _lookupVehicle() async {
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

      debugPrint('\n--- API REQUEST (lookup) ---');
      debugPrint('URL: ${ApiConstants.lookup}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.lookup,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (lookup) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          if (mounted) {
            setState(() {
              lookupVehicle = response.data['data'];
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error looking up vehicle: $e');
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
      debugPrint('Parameters: {booking_id: ${widget.bookingId ?? 1}}');

      // 1. Fetch location details
      final locationResponse = await dio.get(
        ApiConstants.locationDetails,
        queryParameters: {'booking_id': widget.bookingId ?? 1},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (location_details) ---');
      debugPrint('Status Code: ${locationResponse.statusCode}');
      debugPrint('Response Data: ${locationResponse.data}');
      debugPrint('--------------------------\n');

      if (locationResponse.statusCode == 200 && locationResponse.data != null) {
        if (locationResponse.data['status'] == true) {
          final data = locationResponse.data['data'];
          // Only proceed if we have a valid slot number, the booking is confirmed, and not expired
          if (data != null &&
              data['slot_number'] != null &&
              data['slot_number'].toString().isNotEmpty &&
              data['slot_number'].toString() != "false") {
            final returnedSlotNumber = data['slot_number'].toString();
            await _fetchSlotDetails(returnedSlotNumber, headers, dio);
            return;
          }
        }
      }

      // If we reach here in direction mode, it means no valid booking was found
      if (mounted && widget.isDirectionMode) {
        setState(() {
          selectedSlotCode = "";
          selectedSlotNumber = "N/A";
        });
      }
    } catch (e) {
      debugPrint('Error fetching parking details: $e');
      if (mounted && widget.isDirectionMode) {
        setState(() {
          selectedSlotCode = "";
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoadingData = false;
        });
      }
    }
  }

  Future<void> _fetchParkingHistory() async {
    try {
      final dio = Dio();
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      final response = await dio.get(
        ApiConstants.parkingHistory,
        queryParameters: {'limit': 100, 'offset': 0},
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List history = response.data['data']['history'] ?? [];
          if (mounted) {
            setState(() {
              for (var booking in history) {
                final slotStr = booking['slot']?.toString();
                if (slotStr != null && slotStr != "null" && slotStr.isNotEmpty) {
                  final prefix = _getPrefixFromSlotNumber(slotStr);
                  final num = _getNumberFromSlotNumber(slotStr);
                  if (prefix.isNotEmpty && num.isNotEmpty) {
                    for (final row in _slotRows) {
                      if (row.prefix.startsWith(prefix)) {
                         final s1Code = "${row.prefix}_S1-$num";
                         final s2Code = "${row.prefix}_S2-$num";
                         if (!bookedSlots.contains(s1Code)) bookedSlots.add(s1Code);
                         if (!bookedSlots.contains(s2Code)) bookedSlots.add(s2Code);
                      }
                    }
                  }
                }
              }
            });
          }
        }
      }
    } catch (e) {
      debugPrint('Error fetching history for booked slots: $e');
    }
  }

  String _getPrefixFromSlotNumber(String slotNumber) {
    if (slotNumber.contains('JETSKI WITH TRAILER')) {
      // Logic to distinguish JTSP1 vs JTSP2 might need more info from API
      // For now fallback to first
      return 'JTSP1';
    }
    if (slotNumber.contains('FOOD TRUCK') && slotNumber.contains('17 m')) {
      return 'FTP17';
    }
    if (slotNumber.contains('FOOD TRUCK') && slotNumber.contains('13 m')) {
      return 'FTP13A';
    }
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
            final prefix = _getPrefixFromSlotNumber(slotNumber);
            final num = _getNumberFromSlotNumber(slotNumber);
            if (prefix.isNotEmpty && num.isNotEmpty) {
              selectedSlotCode = "$prefix-$num";
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
                _getLocationType(slotNumber.split('-').first, slotNumber);
            selectedSlotSize =
                data['slot_size']?.toString() ??
                _getSlotSize(slotNumber.split('-').first);
            selectedSlotNumber = data['slot_number']?.toString() ?? "N/A";
            selectedLocationCode = data['location_code']?.toString() ?? "N/A";

            // If we are initially loading the slot from the backend for this booking
            if (initialConfirmedSlot.isEmpty && selectedSlotNumber != "N/A") {
              initialConfirmedSlot = selectedSlotNumber;
            }

            if (data.containsKey('is_booked')) {
              if (data['is_booked'] == true) {
                if (!bookedSlots.contains(selectedSlotCode)) {
                  bookedSlots.add(selectedSlotCode);
                }
              } else {
                bookedSlots.remove(selectedSlotCode);
              }
            }
            if (data.containsKey('shaded_slot')) {
              if (data['shaded_slot'] == true) {
                if (!shadedSlots.contains(selectedSlotCode)) {
                  shadedSlots.add(selectedSlotCode);
                }
              } else {
                shadedSlots.remove(selectedSlotCode);
              }
            }
          });
        }
      }
    }
  }

  bool _isSameAsConfirmed() {
    return initialConfirmedSlot.isNotEmpty &&
        selectedSlotNumber == initialConfirmedSlot;
  }

  Future<void> _onSlotSelected(String codeString, String formattedSlot) async {
    if (bookedSlots.contains(codeString)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('This slot is already booked and cannot be selected.'),
          backgroundColor: Color(0xFFE30613),
        ),
      );
      return;
    }

    setState(() {
      selectedSlotCode = codeString; // Keep internal code for UI matching
      selectedSlotNumber = formattedSlot;
      selectedLocation = _getFriendlyLocation(codeString.split('-').first);
      selectedLocationType = _getLocationType(codeString.split('-').first, codeString);
      selectedSlotSize = _getSlotSize(codeString.split('-').first);
    });
  }

  String _formatSlotCode(String prefix, int index) {
    // Strip section identifiers _S1 and _S2
    String cleanPrefix = prefix.replaceAll('_S1', '').replaceAll('_S2', '');
    String formattedPrefix = cleanPrefix;
    String locationName = "";

    switch (cleanPrefix) {
      case 'JTSP1':
        formattedPrefix = "A";
        locationName = "JETSKI";
        break;
      case 'JTSP2':
        formattedPrefix = "B";
        locationName = "JETSKI";
        break;
      case 'FTP17':
        formattedPrefix = "C";
        locationName = "FOOD TRUCK";
        break;
      case 'FTP13A':
        formattedPrefix = "D";
        locationName = "FOOD TRUCK";
        break;
      case 'FTP13B':
        formattedPrefix = "E";
        locationName = "FOOD TRUCK";
        break;
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
        'Accept': '*/*',
      };

      final Map<String, dynamic> requestBody = {
        'booking_id': widget.bookingId ?? 1,
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
        ),
      );

      debugPrint('--- API RESPONSE (confirm_location) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        if (mounted) {
          // After confirmation, fetch slot details as requested
          // check for both slot_assigned and slot_number in response
          final Map<String, dynamic>? data = response.data['data'];
          final String confirmedSlot =
              (data != null && data['slot_assigned'] != null)
              ? data['slot_assigned'].toString()
              : (data != null && data['slot_number'] != null)
              ? data['slot_number'].toString()
              : requestBody['slot_number'].toString();

          await _fetchSlotDetails(confirmedSlot, headers, dio);

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
                  response.data['message'] ??
                      S.of(context).failedToConfirmLocation,
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
    if (widget.isDirectionMode) return;
    final double px = position.dx;
    final double py = position.dy;
    final double skewFactor = -0.7;

    for (final row in _slotRows) {
      if (py >= row.top && py <= row.top + row.slotH) {
        // Section 1: 17 slots
        for (int i = 0; i < row.sec1Count; i++) {
          final double skewOffset = skewFactor * (row.top + row.slotH - py);
          final double x = row.sec1StartX + (i * row.slotW) + skewOffset;
          if (px >= x && px <= x + row.slotW) {
            final codeString =
                "${row.prefix}_S1-${(i + 1).toString().padLeft(2, '0')}";
            _onSlotSelected(codeString, _formatSlotCode(row.prefix, i + 1));
            return;
          }
        }
        // Section 2: 47 slots
        for (int i = 0; i < row.sec2Count; i++) {
          final double skewOffset = skewFactor * (row.top + row.slotH - py);
          final double x = row.sec2StartX + (i * row.slotW) + skewOffset;
          if (px >= x && px <= x + row.slotW) {
            final codeString =
                "${row.prefix}_S2-${(i + 1).toString().padLeft(2, '0')}";
            _onSlotSelected(codeString, _formatSlotCode(row.prefix, i + 1));
            return;
          }
        }
      }
    }
  }

  String _getFriendlyLocation(String prefix) {
    switch (prefix) {
      case 'JTSP1':
      case 'JTSP2':
        return S.of(context).jetskiWithTrailerParking;
      case 'FTP17':
        return S.of(context).foodTruckParking17m;
      case 'FTP13A':
      case 'FTP13B':
        return S.of(context).foodTruckParking13m;
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

  String _getLocationType(String prefix, [String? code]) {
    if (code != null && shadedSlots.contains(code)) return S.of(context).shaded;
    if (prefix == 'BTP' || prefix == 'CTP') return S.of(context).shaded;
    if (prefix.contains('FTP')) return S.of(context).open;
    return S.of(context).open;
  }

  String _getSlotSize(String prefix) {
    switch (prefix) {
      case 'JTSP1':
      case 'JTSP2':
        return "4m x 10m";
      case 'FTP17':
        return "5m x 17m";
      case 'FTP13A':
      case 'FTP13B':
        return "5m x 13m";
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
          if (widget.isDirectionMode && lookupVehicle != null) ...[
            const SizedBox(height: 18),
            _buildInfoRow(
              '${S.of(context).vehicle} : ',
              "${lookupVehicle!['license_number'] ?? ''} • ${lookupVehicle!['vehicle_type_name'] ?? ''}",
            ),
          ],
          if (selectedSlotCode.isNotEmpty) ...[
            const SizedBox(height: 18),
            _buildInfoRow(
              S.of(context).locationCodeLabel,
              selectedLocationCode,
            ),
            _buildInfoRow(S.of(context).slotNumberLabel, selectedSlotNumber),
            _buildInfoRow(S.of(context).locationLabel, selectedLocation),
            _buildInfoRow(
              S.of(context).locationTypeLabel,
              selectedLocationType,
            ),
            _buildInfoRow(S.of(context).sizeLabel, selectedSlotSize),
          ],

          const SizedBox(height: 14),
          if (!widget.isDirectionMode)
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
                onPressed: (selectedSlotCode.isEmpty || 
                            _isSameAsConfirmed()) 
                           ? null : _confirmLocation,
                child: Text(
                  _isSameAsConfirmed() 
                    ? S.of(context).locationConfirmedSuccessfully 
                    : S.of(context).confirmLocation,
                  style: const TextStyle(
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
      label: 'JETSKI WITH TRAILER PARKING',
    );
    _drawContinuousRoadTrack(
      canvas,
      380,
      500,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'FOOD TRUCK PARKING - Length 17m',
    );
    _drawContinuousRoadTrack(
      canvas,
      540,
      660,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'FOOD TRUCK PARKING - Length 13m',
    );
    _drawContinuousRoadTrack(
      canvas,
      700,
      820,
      size.width,
      roadPaint,
      curvePaint,
      linePaint,
      label: 'FOOD TRUCK PARKING - Length 13m',
    );

    // --- 2. DRAW VERTICAL ENTRANCE/EXIT ROADWAY ---
    _drawVerticalRoadway(
      canvas,
      x: 1000,
      width: 140,
      height: 820,
      roadPaint: roadPaint,
      linePaint: linePaint,
    );

    // --- 3. DRAW SLOTTED OVERLAPPING BLOCKS MESH ---
    for (final row in slotRows) {
      // Section 1: 17 slots
      _drawSlantedSlotsRow(
        canvas,
        top: row.top,
        startX: row.sec1StartX,
        count: row.sec1Count,
        slotW: row.slotW,
        slotH: row.slotH,
        prefix: "${row.prefix}_S1",
      );
      // Section 2: 47 slots
      _drawSlantedSlotsRow(
        canvas,
        top: row.top,
        startX: row.sec2StartX,
        count: row.sec2Count,
        slotW: row.slotW,
        slotH: row.slotH,
        prefix: "${row.prefix}_S2",
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
    // Label under Section 1
    textPainter.paint(canvas, Offset(250, bottom + 10));
    // Label under Section 2 (after the road)
    textPainter.paint(canvas, Offset(1300, bottom + 10));
  }

  void _drawVerticalRoadway(
    Canvas canvas, {
    required double x,
    required double width,
    required double height,
    required Paint roadPaint,
    required Paint linePaint,
  }) {
    final rect = Rect.fromLTWH(x, 80, width, height);
    canvas.drawRect(rect, roadPaint);
    canvas.drawRect(rect, linePaint);

    final double midX = x + width / 2;
    final dashPaint = Paint()
      ..color = Colors.white38
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw Dashed Line in middle
    double currentY = 80;
    while (currentY < 80 + height) {
      canvas.drawLine(
        Offset(midX, currentY),
        Offset(midX, math.min(currentY + 15, 80 + height)),
        dashPaint,
      );
      currentY += 25;
    }

    // Lane Labels: EXIT & ENTRANCE
    _drawVerticalLabel(
      canvas,
      "EXIT",
      Offset(x + width * 0.25, 80 + height - 20),
    );
    _drawVerticalLabel(
      canvas,
      "ENTRANCE",
      Offset(x + width * 0.75, 80 + height - 20),
    );

    // Optional: Draw curved dashed lines matching the design
    for (final row in slotRows) {
      _drawConnectionCurve(
        canvas,
        row.top + row.slotH / 2,
        x,
        width,
        dashPaint,
      );
    }
  }

  void _drawConnectionCurve(
    Canvas canvas,
    double y,
    double roadX,
    double roadWidth,
    Paint paint,
  ) {
    // Left side (Section 1)
    for (var i = 0; i < 4; i++) {
      canvas.drawCircle(Offset(roadX - 15 + i * 4, y), 0.4, paint);
    }
    // Right side (Section 2)
    for (var i = 0; i < 4; i++) {
        canvas.drawCircle(Offset(roadX + roadWidth + 5 + i * 4, y), 0.4, paint);
    }
  }

  void _drawVerticalLabel(Canvas canvas, String text, Offset offset) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);
    canvas.rotate(-math.pi / 2);
    textPainter.paint(
      canvas,
      Offset(-textPainter.width / 2, -textPainter.height / 2),
    );
    canvas.restore();
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
      ..color = const Color(0xFF3A3A3A)
      ..style = PaintingStyle.fill;
    final bookedPaint = Paint()
      ..color = const Color(0xFF777777) // Darker gray for booked
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
      final double x = startX + (i * slotW);
      final double y = top;

      if (isSelected) {
        cellPaint = selectedPaint;
        // Draw a small checkmark in the center of the selected slot
        final double centerX = x + slotW / 2;
        final double centerY = y + slotH / 2;
        final checkPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0;
        final checkPath = Path();
        checkPath.moveTo(centerX - 6, centerY);
        checkPath.lineTo(centerX - 2, centerY + 4);
        checkPath.lineTo(centerX + 6, centerY - 6);
        canvas.drawPath(checkPath, checkPaint);
      }

      // --- SKIP SLOTS THAT OVERLAP WITH THE VERTICAL ROADWAY ---
      // No longer needed since we split the sections

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
