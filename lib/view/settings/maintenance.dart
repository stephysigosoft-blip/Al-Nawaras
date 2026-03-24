import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../generated/l10n.dart';

class Maintenance extends StatelessWidget {
  Maintenance({super.key, required this.serverDownReason});
  final String? serverDownReason;
  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsetsDirectional.only(start: 15.0, end: 15, bottom: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  "lib/assets/images/wewillback.png",
                  // replace with your asset
                  height: MediaQuery.of(context).size.height * 0.25,
                ),
              ),

              const SizedBox(height: 20),
              Text(
                S.of(context).weWillBeBackSoon,
                style: GoogleFonts.rubik(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsetsDirectional.only(start: 15, end: 15),
                child: Text(
                  (serverDownReason != null && serverDownReason!.isNotEmpty && serverDownReason != "null")
                      ? serverDownReason!
                      : S.of(context).noDataAvailable, // Fallback to a localized string or generic message
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
