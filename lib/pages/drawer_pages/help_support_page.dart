import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  /// >>> Generic Email Launcher
  Future<void> _launchEmail(String email, {String? subject}) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: email, query: subject != null ? 'subject=${Uri.encodeComponent(subject)}' : null,);
    try {
      if (!await launchUrl(emailUri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch email app';
      }
    } catch (e) {
      debugPrint('Email launch failed: $e');
    }
  }

  /// >>> Generic Phone Launcher
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch dial pad';
      }
    } catch (e) {
      debugPrint('Phone launch failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Help & Support")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Need help? Contact me:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),

            // Main Support
            ListTile(
              leading: const Icon(Icons.email_outlined, color: Colors.blue),
              title: const Text("developerprothes16@gmail.com"),
              onTap: () => _launchEmail("developerprothes16@gmail.com", subject: "Help & Support"),
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.green),
              title: const Text("+8801317818826"),
              onTap: () => _launchPhone("+8801317818826"),
            ),

            const Divider(),

            // Additional Contacts (reusable)
            ListTile(
              leading: const Icon(Icons.email_outlined, color: Colors.blueAccent),
              title: const Text("developerprothes16@gmail.com"),
              onTap: () => _launchEmail("developerprothes16@gmail.com", subject: "Emergency"),
            ),
            ListTile(
              leading: const Icon(Icons.call, color: Colors.teal),
              title: const Text("+8801317818826"),
              onTap: () => _launchPhone("+8801317818826"),
            ),
          ],
        ),
      ),
    );
  }
}
