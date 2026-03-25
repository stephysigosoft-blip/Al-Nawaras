import 'package:dio/dio.dart';
import 'package:al_nawaras/view/payment/payment_success_view.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../config/api_constants.dart';
import '../../generated/l10n.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_item.dart';
import '../widgets/credit_card_form.dart';
import '../widgets/custom_logos.dart';
import '../widgets/draggable_help_button.dart';

class PaymentView extends StatefulWidget {
  final int? bookingId;
  final String? title;
  final String? subtitle;
  final String? amount;
  final String? subtotal;
  final String? vat;
  final String? total;
  final List<Map<String, String>>? details;

  const PaymentView({
    super.key,
    this.bookingId,
    this.title,
    this.subtitle,
    this.amount,
    this.subtotal,
    this.vat,
    this.total,
    this.details,
  });

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  int selectedPaymentMethod = 0; // State variable
  bool saveCard = false; // State variable

  @override
  Widget build(BuildContext context) {
    // using MediaQuery for responsiveness
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final padding = width * 0.04; // 4% of screen width for padding

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: const Color(0xFFE30613),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Icons.arrow_forward_ios
                : Icons.arrow_back_ios,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          S.of(context).payment,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        S.of(context).paymentSummary,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      PaymentSummaryCard(
                        width: width,
                        title: widget.title ?? S.of(context).monthlyMembership,
                        subtitle: widget.subtitle ?? S.of(context).shadedParkingDetail,
                        amount: widget.amount ?? 'AED 1,500',
                        subtotal: widget.subtotal ?? 'AED 1,500.00',
                        vat: widget.vat ?? 'AED 75.00',
                        total: widget.total,
                        details: widget.details ??
                            [
                              {'label': S.of(context).vehicle, 'value': 'Airstream Caravel'},
                              {'label': S.of(context).duration, 'value': S.of(context).thirtyDays},
                              {'label': S.of(context).startDateLabel, 'value': '15 May 2023'},
                              {'label': S.of(context).endDateLabel, 'value': '15 Jun 2023'},
                            ],
                      ),
                      SizedBox(height: height * 0.03),
                      Text(
                        S.of(context).paymentMethod,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      _buildPaymentMethods(width, height),
                      SizedBox(height: height * 0.02),
                      _buildFooterCheckbox(),
                    ],
                  ),
                ),
              ),
              _buildStickyFooter(context, width, height),
            ],
          ),
          const DraggableHelpButton(),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(double width, double height) {
    return Column(
      children: [
        PaymentMethodItem(
          index: 0,
          title: S.of(context).creditDebitCard,
          trailing: CustomLogos.buildMastercard(),
          isSelected: selectedPaymentMethod == 0,
          isExpanded: selectedPaymentMethod == 0,
          expandedContent: CreditCardForm(width: width, height: height),
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 0),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 1,
          title: S.of(context).applePayLabel,
          trailing: CustomLogos.buildApplePay(),
          isSelected: selectedPaymentMethod == 1,
          isExpanded: selectedPaymentMethod == 1,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 1),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 2,
          title: S.of(context).googlePayLabel,
          trailing: CustomLogos.buildGooglePay(width),
          isSelected: selectedPaymentMethod == 2,
          isExpanded: selectedPaymentMethod == 2,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 2),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 3,
          title: S.of(context).payPalLabel,
          trailing: CustomLogos.buildPayPal(width),
          isSelected: selectedPaymentMethod == 3,
          isExpanded: selectedPaymentMethod == 3,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 3),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 4,
          title: S.of(context).nolPayLabel,
          trailing: CustomLogos.buildNolPay(width),
          isSelected: selectedPaymentMethod == 4,
          isExpanded: selectedPaymentMethod == 4,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 4),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 5,
          title: S.of(context).cashOnSite,
          trailing: CustomLogos.buildCashOnSite(width),
          isSelected: selectedPaymentMethod == 5,
          isExpanded: selectedPaymentMethod == 5,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 5),
        ),
      ],
    );
  }

  Widget _buildFooterCheckbox() {
    return InkWell(
      onTap: () => setState(() => saveCard = !saveCard),
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: saveCard,
              onChanged: (value) => setState(() => saveCard = value ?? false),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            S.of(context).saveCardForFuture,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter(BuildContext context, double width, double height) {
    String totalStr = widget.total ?? (widget.subtotal == null
        ? "${S.of(context).currency} 1,575.00"
        : _calculateTotal(context, widget.subtotal!, widget.vat ?? "${S.of(context).currency} 0.00"));

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ), // ignore: deprecated_member_use
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                // Call payment/confirm using the real booking_id (or fallback to 1)
                try {
                  final dio = Dio();
                  final storage = GetStorage();
                  final token = storage.read('token');
                  
                  final headers = {
                    if (token != null) 'Authorization': 'Bearer $token',
                    'Accept': 'application/json',
                  };

                  // Parse numerical value from totalStr or amount
                  String priceStr = totalStr.replaceAll(RegExp(r'[^0-9.]'), '');
                  double numericAmount = double.tryParse(priceStr) ?? 500.0;

                  final Map<String, dynamic> requestBody = {
                    "booking_id": widget.bookingId ?? 1,
                    "amount": numericAmount,
                    "payment_gateway": "stripe",
                    "payment_reference": "gateway_payment_reference"
                  };

                  debugPrint('\n--- API REQUEST (payment/confirm) ---');
                  debugPrint('URL: ${ApiConstants.paymentConfirm}');
                  debugPrint('Body: $requestBody');

                  final response = await dio.post(
                    ApiConstants.paymentConfirm,
                    data: requestBody,
                    options: Options(
                      headers: headers,
                      contentType: Headers.formUrlEncodedContentType,
                    ),
                  );

                  debugPrint('--- API RESPONSE (payment/confirm) ---');
                  debugPrint('Status Code: ${response.statusCode}');
                  debugPrint('Response Data: ${response.data}');

                  if (response.statusCode == 200 && response.data != null && response.data['status'] == true) {
                    if (mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PaymentSuccessView(
                            bookingId: widget.bookingId,
                            title: widget.title,
                            subtitle: widget.subtitle,
                            total: totalStr,
                            details: widget.details,
                          ),
                        ),
                      );
                    }
                  } else {
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.data['message'] ?? 'Payment confirmation failed.'),
                          backgroundColor: const Color(0xFFE30613),
                        ),
                      );
                    }
                  }
                } catch (e) {
                  debugPrint('Error confirming payment: $e');
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(S.of(context).errorServer),
                        backgroundColor: Color(0xFFE30613),
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                S.of(context).payAmount(totalStr),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).agreeToTermsPrivacy,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  String _calculateTotal(BuildContext context, String subtotal, String vat) {
    try {
      final sub = double.parse(subtotal.replaceAll(RegExp(r'[^0-9.]'), ''));
      final v = double.parse(vat.replaceAll(RegExp(r'[^0-9.]'), ''));
      return '${S.of(context).currency} ${(sub + v).toStringAsFixed(2)}';
    } catch (e) {
      return subtotal;
    }
  }
}
