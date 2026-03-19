import 'package:al_nawaras/view/payment/payment_success_view.dart';
import 'package:flutter/material.dart';
import '../widgets/payment_summary_card.dart';
import '../widgets/payment_method_item.dart';
import '../widgets/credit_card_form.dart';
import '../widgets/custom_logos.dart';
import '../widgets/draggable_help_button.dart';

class PaymentView extends StatefulWidget {
  final String? title;
  final String? subtitle;
  final String? amount;
  final String? subtotal;
  final String? vat;
  final List<Map<String, String>>? details;

  const PaymentView({
    super.key,
    this.title,
    this.subtitle,
    this.amount,
    this.subtotal,
    this.vat,
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Payment',
          style: TextStyle(
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
                      const Text(
                        'Payment Summary',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: height * 0.015),
                      PaymentSummaryCard(
                        width: width,
                        title: widget.title ?? 'Monthly Membership',
                        subtitle: widget.subtitle ?? 'Shaded Parking',
                        amount: widget.amount ?? 'AED 1,500',
                        subtotal: widget.subtotal ?? 'AED 1,500.00',
                        vat: widget.vat ?? 'AED 75.00',
                        details: widget.details ??
                            const [
                              {'label': 'Vehicle', 'value': 'Airstream Caravel'},
                              {'label': 'Duration', 'value': '30 Days'},
                              {'label': 'Start Date', 'value': '15 May 2023'},
                              {'label': 'End Date', 'value': '15 Jun 2023'},
                            ],
                      ),
                      SizedBox(height: height * 0.03),
                      const Text(
                        'Payment Method',
                        style: TextStyle(
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
          title: 'Credit/Debit Card',
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
          title: 'Apple Pay',
          trailing: CustomLogos.buildApplePay(),
          isSelected: selectedPaymentMethod == 1,
          isExpanded: selectedPaymentMethod == 1,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 1),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 2,
          title: 'Google Pay',
          trailing: CustomLogos.buildGooglePay(width),
          isSelected: selectedPaymentMethod == 2,
          isExpanded: selectedPaymentMethod == 2,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 2),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 3,
          title: 'PayPal',
          trailing: CustomLogos.buildPayPal(width),
          isSelected: selectedPaymentMethod == 3,
          isExpanded: selectedPaymentMethod == 3,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 3),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 4,
          title: 'Nol Pay',
          trailing: CustomLogos.buildNolPay(width),
          isSelected: selectedPaymentMethod == 4,
          isExpanded: selectedPaymentMethod == 4,
          width: width,
          onTap: () => setState(() => selectedPaymentMethod = 4),
        ),
        const SizedBox(height: 12),
        PaymentMethodItem(
          index: 5,
          title: 'Cash on site',
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
          const Text(
            'Save card for future payments',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildStickyFooter(BuildContext context, double width, double height) {
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
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const PaymentSuccessView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE30613),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: Text(
                'Pay ${widget.subtotal == null ? "AED 1,575.00" : _calculateTotal(widget.subtotal!, widget.vat ?? "AED 0.00")}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'By proceeding, you agree to our Terms of Service\nand Privacy Policy',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
        ],
      ),
    );
  }

  String _calculateTotal(String subtotal, String vat) {
    try {
      final sub = double.parse(subtotal.replaceAll(RegExp(r'[^0-9.]'), ''));
      final v = double.parse(vat.replaceAll(RegExp(r'[^0-9.]'), ''));
      return 'AED ${(sub + v).toStringAsFixed(2)}';
    } catch (e) {
      return subtotal;
    }
  }
}
