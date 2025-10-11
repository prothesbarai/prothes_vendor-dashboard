import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

enum AppTheme { system, light, dark }

class _SettingsPageState extends State<SettingsPage> {

  AppTheme currentTheme = AppTheme.light;
  bool isShopOpen = true;
  String selectedLanguage = 'English';

  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = false;
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [



          // Profile
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile Settings"),
            subtitle: const Text("Update your personal info"),
            onTap: () {},
          ),
          const Divider(),


          // Store
          ListTile(
            leading: const Icon(Icons.store),
            title: const Text("Store Settings"),
            subtitle: const Text("Update store info & logo"),
            onTap: () {},
          ),
          const Divider(),


          // Shop Open/Close Toggle
          SwitchListTile(
            title: Text("Shop ${isShopOpen ? "Open" : "Close"}"),
            subtitle: const Text("Turn on/off your shop"),
            value: isShopOpen,
            onChanged: (value) {setState(() {isShopOpen = value;});},
            secondary: const Icon(Icons.storefront),
          ),
          const Divider(),


          // Payment
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text("Payment Settings"),
            subtitle: const Text("Add or update payment info"),
            onTap: () {},
          ),
          const Divider(),


          // Order Notifications
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Order Notifications"),
            subtitle: const Text("Enable/Disable order alerts"),
            onTap: () {},
          ),
          const Divider(),


          // Password & Security
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text("Password & Security"),
            subtitle: const Text("Change password & enable 2FA"),
            onTap: () {},
          ),
          const Divider(),


          // Language Selection
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Language"),
            subtitle: Text("Current: $selectedLanguage"),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Select Language"),
                    content: RadioGroup<String>(
                      groupValue: selectedLanguage,
                      onChanged: (value) {
                        setState(() {selectedLanguage = value!;});
                        Navigator.pop(context);
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RadioListTile<String>(value: "English", title: Text("English"),),
                          RadioListTile<String>(value: "Bangla", title: Text("Bangla"),),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),



          // App Preferences
          ListTile(
            leading: const Icon(Icons.color_lens),
            title: const Text("App Preferences"),
            subtitle: Text(currentTheme == AppTheme.system ? "Current: System Default" : currentTheme == AppTheme.light ? "Current: Light Mode" : "Current: Dark Mode",),
            onTap: () {
              AppTheme tempTheme = currentTheme;
              showDialog(
                context: context,
                builder: (context) {
                  return StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return AlertDialog(
                        title: const Text("Select Theme"),
                        content: RadioGroup<AppTheme>(
                          groupValue: tempTheme,
                          onChanged: (value) {
                            setStateDialog(() {tempTheme = value!;});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              RadioListTile<AppTheme>(value: AppTheme.system, title: const Text("System Default"), activeColor: Colors.blue,),
                              RadioListTile<AppTheme>(value: AppTheme.light, title: const Text("Light Mode"), activeColor: Colors.blue,),
                              RadioListTile<AppTheme>(value: AppTheme.dark, title: const Text("Dark Mode"), activeColor: Colors.blue,),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel"),),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {currentTheme = tempTheme;});
                              Navigator.pop(context);
                            },
                            child: const Text("Apply"),
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
          const Divider(),



          // Logout
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
            onTap: () {},
          ),


          SizedBox(height: 50.h,),
        ],
      ),
    );
  }
}
