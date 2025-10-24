import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:html' as html;

void showShareOptions(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _shareOption(context, Icons.link, "Vendor Profile Link", () {
            _safeShare(
              text: "https://yourapp.com/vendor/abc-super-shop",
              subject: "Vendor Profile",
            );
          }),
          _shareOption(context, Icons.person_add, "App Invite / Referral", () {
            _safeShare(
              text: "Join this amazing app and get rewards! https://yourapp.com/referral?code=PROTHES123",
              subject: "App Invite / Referral",
            );
          }),
          _shareOption(context, Icons.share, "Social Media Share", () {
            _safeShare(
              text: "Amazing vendor ABC Super Shop! Check them out: https://yourapp.com/vendor/abc-super-shop",
              subject: "Share Vendor",
            );
          }),
          _shareOption(context, Icons.qr_code, "QR Code Generate & Share", () {
            _showQRCodeDialog(context, "ANGKAN_UI"); // PROTHES_UI , ANGKAN_UI, SHREYASI_UI
          }),
          _shareOption(context, Icons.contacts, "Contact Share", () {
            _safeShare(
              text: "Hey! Check this vendor: ABC Super Shop, https://yourapp.com/vendor/abc-super-shop",
              subject: "Vendor Info",
            );
          }),
          _shareOption(context, Icons.track_changes, "Tracking Links (Pro)", () {
            _safeShare(
              text: "Track vendor activity: https://yourapp.com/vendor/abc-super-shop?track=PRO",
              subject: "Tracking Link",
            );
          }),
        ],
      ),
    ),
  );
}


/// Universal Share Function — works on Web + Mobile
void _safeShare({required String text, String? subject}) async {
  if (kIsWeb) {
    //Web Share API
    try {
      await html.window.navigator.share({'title': subject ?? "Share", 'text': text,});
    } catch (e) {
      html.window.alert("Failed to share: $e");
    }
  } else {
    // Android / iOS
    try {
      await SharePlus.instance.share(ShareParams(text: text,subject: subject));
    } catch (e) {
      debugPrint("Share error: $e");
    }
  }
}


Widget _shareOption(BuildContext context, IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: const Color(0xFF6C63FF)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    onTap: () {
      Navigator.pop(context);
      onTap();
    },
  );
}



void _showQRCodeDialog(BuildContext context, String data) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 300,
        height: 400,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Vendor QR Code", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,),),
              const SizedBox(height: 16),
              QrImageView(
                data: data,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text("Scan this QR code to view vendor profile or share with others.", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              // Example scrollable content
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[700]),
                    child: const Text("Close"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _safeShare(text: data, subject: "QR Link");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text("Share"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

