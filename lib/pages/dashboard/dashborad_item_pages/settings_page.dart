import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../models/hive_models/theme_selected_model/theme_selected_model.dart';
import '../../../providers/theme_provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {

  bool isShopOpen = true;
  bool isEnabledOrderNotification = true;
  String selectedLanguage = 'English';


  // currentTheme
  AppTheme currentTheme = AppTheme.system;

  // _getThemeDescription
  String _getThemeDescription(AppTheme theme) {
    switch (theme) {
      case AppTheme.system:
        return "Current: System Default";
      case AppTheme.light:
        return "Current: Light Mode";
      case AppTheme.dark:
        return "Current: Dark Mode";
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);


    return Scaffold(
      appBar: AppBar(title: const Text("Settings"), backgroundColor: Theme.of(context).appBarTheme.backgroundColor,),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [



          // Profile
          ListTile(
            leading: Icon(Icons.person, color: Theme.of(context).iconTheme.color),
            title: Text("Profile Settings", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Update your personal info", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            onTap: () {},
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Store
          ListTile(
            leading: Icon(Icons.store, color: Theme.of(context).iconTheme.color),
            title: Text("Store Settings", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Update store info & logo", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            onTap: () {},
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Shop Open/Close Toggle
          SwitchListTile(
            title: Text("Shop ${isShopOpen ? "Open" : "Close"}", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Turn on/off your shop", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            value: isShopOpen,
            onChanged: (value) {setState(() {isShopOpen = value;});},
            secondary: Icon(Icons.storefront, color: Theme.of(context).iconTheme.color),
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Payment
          ListTile(
            leading: Icon(Icons.payment, color: Theme.of(context).iconTheme.color),
            title: Text("Payment Settings", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Add or update payment info", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            onTap: () {},
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Order Notifications
          SwitchListTile(
            title: Text("Order Notifications", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text(isEnabledOrderNotification ? "Enable" : "Disable", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            value: isEnabledOrderNotification,
            onChanged: (value) {setState(() {isEnabledOrderNotification = value;});},
            secondary: Icon(Icons.notifications, color: Theme.of(context).iconTheme.color),
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Password & Security
          ListTile(
            leading: Icon(Icons.security, color: Theme.of(context).iconTheme.color),
            title: Text("Password & Security", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Change password & enable 2FA", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
            onTap: () {},
          ),
          Divider(color: Theme.of(context).dividerColor),


          // Language Selection
          ListTile(
            leading: Icon(Icons.language, color: Theme.of(context).iconTheme.color),
            title: Text("Language", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text("Current: $selectedLanguage", style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color)),
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
          Divider(color: Theme.of(context).dividerColor),



          // App Preferences
          ListTile(
            leading: Icon(Icons.color_lens, color: Theme.of(context).iconTheme.color),
            title: Text("App Preferences", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            subtitle: Text( _getThemeDescription(themeProvider.selectedTheme), style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color),),
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
                              themeProvider.setTheme(tempTheme);
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
          Divider(color: Theme.of(context).dividerColor),



          // Logout
          ListTile(
            leading: Icon(Icons.exit_to_app, color: Theme.of(context).iconTheme.color),
            title: Text("Logout", style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
            onTap: () {},
          ),


          SizedBox(height: 50.h,),
        ],
      ),
    );
  }
}
