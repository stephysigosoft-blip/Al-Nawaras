import 'package:al_nawaras/view/payment/payment_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../config/api_constants.dart';
import 'base_client.dart';

class BookParkingController extends GetxController {
  bool isLoadingVehicles = false;
  bool isLoadingMemberships = false;
  bool isLoadingParkingTypes = false;
  bool isLoadingServices = false;
  bool isBooking = false;
  List<Map<String, dynamic>> vehiclesList = [];
  Map<String, dynamic>? selectedVehicleData;

  int? lastBookingId; // Stores the booking_id returned from parking/book API
  double? lastBookingTotal; // Stores the total_amount from booking response

  String selectedParkingType = 'Shaded';
  String selectedMembership = 'Hourly';

  // Maps UI display values to API IDs.
  // Populated dynamically from /parking/types API.
  final Map<String, int> parkingTypeIdMap = {};

  // Populated from /memberships API: key = plan title, value = plan id
  final Map<String, int> membershipIdMap = {};

  @override
  void onInit() {
    super.onInit();
    fetchVehicles();
    fetchMemberships();
    fetchParkingTypes();
    fetchServices();
  }

  Future<void> fetchVehicles() async {
    isLoadingVehicles = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (vehicles) ---');
      debugPrint('URL: ${ApiConstants.vehicles}');
      debugPrint('Headers: $headers');

      final response = await dio.get(
        ApiConstants.vehicles,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (vehicles) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['status'] == true) {
          final List vData = response.data['data']['vehicles'] ?? [];
          vehiclesList = vData.map((e) => e as Map<String, dynamic>).toList();

          if (vehiclesList.isNotEmpty) {
            selectedVehicleData = vehiclesList[0];
          }
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching vehicles: $e');
    } catch (e) {
    } finally {
      isLoadingVehicles = false;
      if (!isClosed) update();
    }
  }

  void setSelectedVehicle(Map<String, dynamic> vehicle) {
    selectedVehicleData = vehicle;
    if (!isClosed) update();
  }

  String getVehicleImage(String? typeName) {
    // Mapping based on common names or defaults
    return 'lib/assets/images/Airstream.png';
  }

  // Populated from /parking/types
  List<Map<String, dynamic>> dynamicParkingTypes = [];

  Future<void> fetchParkingTypes() async {
    isLoadingParkingTypes = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (parking types) ---');
      debugPrint('URL: ${ApiConstants.parkingTypes}');

      final response = await dio.get(
        ApiConstants.parkingTypes,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking types) ---');
      debugPrint('Status Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.data}'); // Optional debug

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List<dynamic> pTypes = response.data['data'] ?? [];

        dynamicParkingTypes = [];
        parkingTypeIdMap.clear();

        for (final p in pTypes) {
          final id = p['id'] as int?;
          final name = p['name']?.toString() ?? 'Parking Plan';

          dynamicParkingTypes.add(p as Map<String, dynamic>);
          if (id != null) parkingTypeIdMap[name] = id;
        }

        if (dynamicParkingTypes.isNotEmpty) {
          selectedParkingType = dynamicParkingTypes.first['name'] ?? '';
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching parking types: $e');
    } catch (e) {
    } finally {
      isLoadingParkingTypes = false;
      if (!isClosed) update();
    }
  }

  AssetImage getParkingTypeImage(String typeName) {
    final lower = typeName.toLowerCase();

    // Existing typical ones
    if (lower.contains('unshaded')) {
      return const AssetImage("lib/assets/images/unshaded.png");
    } else if (lower.contains('shaded')) {
      return const AssetImage("lib/assets/images/shaded.png");
    } else if (lower.contains('air conditioned')) {
      return const AssetImage("lib/assets/images/air conditioned.png");
    }

    // Dynamic vehicle-oriented ones
    if (lower.contains('jet ski') || lower.contains('jetski')) {
      return const AssetImage("lib/assets/images/jet ski.png");
    } else if (lower.contains('truck')) {
      return const AssetImage("lib/assets/images/food truck.png");
    } else if (lower.contains('boat')) {
      return const AssetImage("lib/assets/images/boat.png");
    } else if (lower.contains('caravan')) {
      return const AssetImage("lib/assets/images/caravan.png");
    }

    // Generic fallback
    return const AssetImage("lib/assets/images/shaded.png");
  }

  // Populated dynamically from /memberships API
  List<Map<String, String>> membershipPackages = [];

  Future<void> fetchMemberships() async {
    isLoadingMemberships = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (memberships - book parking) ---');
      debugPrint('URL: ${ApiConstants.memberships}');

      final response = await dio.get(
        ApiConstants.memberships,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (memberships - book parking) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final List<dynamic> memberships =
            response.data['data']['memberships'] ?? [];

        membershipPackages = [];
        membershipIdMap.clear();

        for (final m in memberships) {
          final title = m['plan_type']?.toString() ?? 'Standard Plan';
          final price = 'AED ${m['plan_price']}/${m['duration'] ?? 'month'}';
          final id = m['id'] as int?;

          membershipPackages.add({'title': title, 'price': price});
          if (id != null) membershipIdMap[title] = id;
        }

        // Auto-select the first membership if available
        if (membershipPackages.isNotEmpty) {
          selectedMembership = membershipPackages.first['title']!;
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching memberships for book parking: $e');
    } catch (e) {
    } finally {
      isLoadingMemberships = false;
      if (!isClosed) update();
    }
  }

  // Populated dynamically from /services API
  List<Map<String, dynamic>> addonServices = [];

  Future<void> fetchServices() async {
    isLoadingServices = true;
    if (!isClosed) update();

    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');

      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      debugPrint('\n--- API REQUEST (services - book parking) ---');
      debugPrint('URL: ${ApiConstants.services}');

      final response = await dio.get(
        ApiConstants.services,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (services - book parking) ---');
      debugPrint('Status Code: ${response.statusCode}');
      // debugPrint('Response Body: ${response.data}'); // Optional debug

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final rawData = response.data['data'];
        List<dynamic> servicesList = [];
        if (rawData is List) {
          servicesList = rawData;
        } else if (rawData is Map && rawData['services'] != null) {
          servicesList = rawData['services'] as List<dynamic>;
        }

        addonServices = [];

        for (final s in servicesList) {
          final title =
              s['name']?.toString() ?? s['title']?.toString() ?? 'Service';
          final priceVal = s['price'] ?? 0;
          final subtitle =
              s['subtitle']?.toString() ??
              s['description']?.toString() ??
              'Additional service';
          addonServices.add({
            'title': title,
            'price': 'AED $priceVal',
            'subtitle': subtitle,
            'icon': getServiceImage(title),
            'isSelected': false,
            'id': s['id'],
          });
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching services for book parking: $e');
    } finally {
      isLoadingServices = false;
      if (!isClosed) update();
    }
  }

  String getServiceImage(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('battery')) {
      return 'lib/assets/images/battery.png';
    }
    if (lower.contains('oil')) {
      return 'lib/assets/images/oil charge.png';
    }
    if (lower.contains('tire')) {
      return 'lib/assets/images/tire change.png';
    }
    if (lower.contains('wash') || lower.contains('clean')) {
      return 'lib/assets/images/cleaning.png';
    }
    if (lower.contains('towing')) {
      return 'lib/assets/images/trolly.png';
    }
    if (lower.contains('vehicle pickup')) {
      return 'lib/assets/images/vehicle pickup.png';
    }
    if (lower.contains('customer pickup')) {
      return 'lib/assets/images/customer pickup.png';
    }
    return 'lib/assets/images/battery.png'; // default fallback
  }

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      if (!isClosed) update();
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedStartTime = picked;
      if (!isClosed) timeController.text = picked.format(context);
      if (!isClosed) update();
    }
  }

  Future<void> selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      endDateController.text = "${picked.day}/${picked.month}/${picked.year}";
      if (!isClosed) update();
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFE30613),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      selectedEndTime = picked;
      if (!isClosed) endTimeController.text = picked.format(context);
      if (!isClosed) update();
    }
  }

  void setParkingType(String type) {
    selectedParkingType = type;
    if (!isClosed) update();
  }

  void setMembership(String membership) {
    selectedMembership = membership;
    if (!isClosed) update();
  }

  void toggleAddon(int index) {
    addonServices[index]['isSelected'] = !addonServices[index]['isSelected'];
    if (!isClosed) update();
  }

  /// Returns the total price as a formatted string based on:
  ///  - the selected membership package price
  ///  - the prices of all selected add-on services
  String get calculatedTotal {
    double total = 0.0;

    // Add selected membership price
    final selectedPkg = membershipPackages.firstWhere(
      (p) => p['title'] == selectedMembership,
      orElse: () => {},
    );
    if (selectedPkg.isNotEmpty) {
      total += _parsePrice(selectedPkg['price'] ?? '0');
    }

    // Add selected add-on prices
    for (final addon in addonServices) {
      if (addon['isSelected'] == true) {
        total += _parsePrice(addon['price']?.toString() ?? '0');
      }
    }

    return 'AED ${total.toStringAsFixed(2)}';
  }

  /// Extracts the first numeric value from a price string.
  /// e.g. "AED 1500/month" → 1500.0,  "AED 150" → 150.0
  double _parsePrice(String priceStr) {
    final match = RegExp(r'[\d]+\.?[\d]*').firstMatch(priceStr);
    if (match != null) {
      return double.tryParse(match.group(0)!) ?? 0.0;
    }
    return 0.0;
  }

  Future<void> onNextClick() async {
    isBooking = true;
    if (!isClosed) update();

    int? bookingId;
    double? bookingTotal;

    // Step 1: Call parking/book API
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Build ISO 8601 date strings for start/end
      final now = DateTime.now();
      final startDate = _combineDateAndTime(
        dateController.text,
        selectedStartTime,
        now,
      );
      final endDate = _combineDateAndTime(
        endDateController.text,
        selectedEndTime,
        startDate.add(const Duration(hours: 2)),
      );

      final vehicleId = selectedVehicleData?['id'];
      final parkingTypeId = parkingTypeIdMap[selectedParkingType] ?? 1;
      final membershipPackageId = membershipIdMap[selectedMembership] ?? 1;

      final requestBody = {
        "vehicle_id": vehicleId,
        "parking_type_id": parkingTypeId,
        "membership_package_id": membershipPackageId,
        "booking_start_date": startDate.toUtc().toIso8601String(),
        "booking_end_date": endDate.toUtc().toIso8601String(),
      };

      debugPrint('\n--- API REQUEST (parking/book) ---');
      debugPrint('URL: ${ApiConstants.parkingBook}');
      debugPrint('Body: $requestBody');

      final bookResponse = await dio.post(
        ApiConstants.parkingBook,
        data: requestBody,
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (parking/book) ---');
      debugPrint('Status Code: ${bookResponse.statusCode}');
      debugPrint('Response Body: ${bookResponse.data}');

      if (bookResponse.statusCode == 200 && bookResponse.data != null) {
        final bookData = bookResponse.data['data'];
        if (bookData != null) {
          bookingId = bookData['booking_id'];
          bookingTotal = (bookData['total_amount'] as num?)?.toDouble();
          lastBookingId = bookingId;
          lastBookingTotal = bookingTotal;
        }
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error calling parking/book: $e');
    } catch (e) {
      // Don't block navigation — still proceed to payment
    } finally {
      isBooking = false;
      if (!isClosed) update();
    }

    // Step 2: Fetch payment/summary and navigate to PaymentView
    try {
      final dio = BaseClient.dio;
      final storage = GetStorage();
      final token = storage.read('token');
      final headers = {
        if (token != null) 'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      };

      // Use the real booking_id if available, else fallback to 1
      final summaryBookingId = bookingId ?? 1;

      debugPrint('\n--- API REQUEST (payment/summary) ---');
      debugPrint(
        'URL: ${ApiConstants.paymentSummary}?booking_id=$summaryBookingId',
      );

      final response = await dio.get(
        ApiConstants.paymentSummary,
        queryParameters: {'booking_id': summaryBookingId},
        options: Options(headers: headers),
      );

      debugPrint('--- API RESPONSE (payment/summary) ---');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Data: ${response.data}');

      if (response.statusCode == 200 &&
          response.data != null &&
          response.data['status'] == true) {
        final data = response.data['data'];
        final currency = data['currency'] ?? 'AED';

        Get.to(
          () => PaymentView(
            bookingId: bookingId,
            title: 'Booking Payment',
            subtitle: '$selectedParkingType Parking',
            amount: calculatedTotal,
            subtotal: calculatedTotal,
            vat: '$currency ${data['vat'] ?? '0.00'}',
            total: calculatedTotal,
            details: [
              {'label': 'Membership Type', 'value': selectedMembership},
              {'label': 'Parking Type', 'value': selectedParkingType},
              {
                'label': 'Vehicle',
                'value':
                    data['vehicle']?.toString() ??
                    (selectedVehicleData?['vehicle_type_name'] ?? 'N/A'),
              },
              {
                'label': 'Start Date',
                'value': "${dateController.text} ${timeController.text}",
              },
              {
                'label': 'End Date',
                'value': "${endDateController.text} ${endTimeController.text}",
              },
              {
                'label': 'Duration',
                'value': data['duration']?.toString() ?? 'N/A',
              },
            ],
          ),
        );
      } else {
        _navigateToDefaultPayment(bookingId: bookingId);
      }
    } on DioException catch (e) {
      BaseClient.handleDioError(e);
      debugPrint('Error fetching payment summary: $e');
      _navigateToDefaultPayment(bookingId: bookingId);
    } catch (e) {}
  }

  /// Combines a date string (dd/mm/yyyy) and a TimeOfDay into a DateTime object.
  DateTime _combineDateAndTime(
    String dateStr,
    TimeOfDay? time,
    DateTime fallback,
  ) {
    try {
      final parts = dateStr.split('/');
      if (parts.length == 3) {
        final year = int.parse(parts[2]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[0]);

        final hour = time?.hour ?? 0;
        final minute = time?.minute ?? 0;

        return DateTime(year, month, day, hour, minute);
      }
    } catch (_) {}
    return fallback;
  }

  void _navigateToDefaultPayment({int? bookingId}) {
    Get.to(
      () => PaymentView(
        bookingId: bookingId,
        title: 'Booking Payment',
        subtitle: '$selectedParkingType Parking',
        amount: calculatedTotal,
        subtotal: calculatedTotal,
        vat: 'AED 0.00',
        total: calculatedTotal,
        details: [
          {
            'label': 'Vehicle',
            'value': selectedVehicleData?['vehicle_type_name'] ?? 'N/A',
          },
          {'label': 'Membership', 'value': selectedMembership},
          {'label': 'Type', 'value': selectedParkingType},
          {
            'label': 'Start Date',
            'value': "${dateController.text} ${timeController.text}",
          },
          {
            'label': 'End Date',
            'value': "${endDateController.text} ${endTimeController.text}",
          },
        ],
      ),
    );
  }

  @override
  void onClose() {
    // Rely on GetX lifecycle for cleanup to avoid "used after disposed" errors
    super.onClose();
  }
}
