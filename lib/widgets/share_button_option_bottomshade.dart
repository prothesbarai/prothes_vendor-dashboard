import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:prothesvendordashboard/utils/constant/app_colors.dart';


void showShareOptions(BuildContext context,String name,String notes,String email,String phoneNo) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25)),),
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _shareOption(context, Icons.link, "Merchant Profile Link", () {
              _safeShare(
                text: "https://yourapp.com/merchant/abc-super-shop",
                subject: "Merchant Profile",
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
                text: "Amazing Merchant ABC Super Shop! Check them out: https://yourapp.com/merchant/abc-super-shop",
                subject: "Share Merchant",
              );
            }),
            _shareOption(context, Icons.qr_code, "QR Code Generate & Share", () {
              _showQRCodeDialog(context,name,notes, email, phoneNo);
            }),
            _shareOption(context, Icons.contacts, "Contact Share", () {
              _safeShare(
                text: "Hey! Check this Merchant: ABC Super Shop, https://yourapp.com/merchant/abc-super-shop",
                subject: "Merchant Info",
              );
            }),
            _shareOption(context, Icons.track_changes, "Tracking Links (Pro)", () {
              _safeShare(
                text: "Track merchant activity: https://yourapp.com/merchant/abc-super-shop?track=PRO",
                subject: "Tracking Link",
              );
            }),
          ],
        ),
      ),
    ),
  );
}


/// >>> Share Function — works
void _safeShare({dynamic files,String? subject,required String text}) async {
  try {
    await SharePlus.instance.share(ShareParams(files : files, subject: subject, text: text));
  } catch (e) {
    debugPrint("Share error: $e");
  }
}


Widget _shareOption(BuildContext context, IconData icon, String title, VoidCallback onTap) {
  return ListTile(
    leading: Icon(icon, color: AppColors.primaryColor),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
    onTap: () {
      Navigator.pop(context);
      onTap();
    },
  );
}



void _showQRCodeDialog(BuildContext context, String name,String notes, String email, String phoneNo) {
  final vCardData = "BEGIN:VCARD\nVERSION:3.0\nN:$name;;;\nFN:$name\nTEL;TYPE=CELL:$phoneNo\nEMAIL:$email\nNOTE:Store Name: $notes\nEND:VCARD";
  final ScreenshotController screenshotController = ScreenshotController();
  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 300,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            Screenshot(controller : screenshotController,child: QrImageView(data: vCardData, version: QrVersions.auto, size: 200, backgroundColor: Colors.white,)),
            const SizedBox(height: 20),
            const Text("Scan this QR code to add Merchant to Contacts", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
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
                  onPressed: () async {
                    // Capture QR image as PNG
                    Uint8List? imageBytes = await screenshotController.capture();
                    if (imageBytes != null) {
                      final tempDir = await getTemporaryDirectory();
                      final file = await File('${tempDir.path}/merchant_qr.png').writeAsBytes(imageBytes);
                      _safeShare(files: [XFile(file.path)], text: "Merchant Contact QR");
                    }
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
  );
}



